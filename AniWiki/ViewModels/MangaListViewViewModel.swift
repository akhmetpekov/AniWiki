//
//  MangaListViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 02.06.2024.
//

import Foundation
import UIKit
import Combine

protocol MangaListViewViewModelDelegate: AnyObject {
    func didLoadTopManga()
    func didLoadMangaRecommendations(_ manga: MangaFull)
    func didSelectedManga()
}


final class MangaListViewViewModel: NSObject {
    public weak var delegate: MangaListViewViewModelDelegate?
    
    enum MangaSectionType {
        case recommendations(viewModel: [MangaRecommendationsViewCellViewModel])
        case top(viewModel: [MangaTopViewCellViewModel])
    }
    
    public var sections: [MangaSectionType] = []
    public var sectionTitles: [String] = []
    public var mangaFull: MangaFull? = nil
    private var apiInfo: GetTopManga.Pagination? = nil
    private var cellViewModels: [MangaTopViewCellViewModel] = []
    
    public var mangaRecommendations: [MangaRecommendation] = []
    
    private var mangas: [MangaFull] = [] {
        didSet {
            for manga in mangas {
                guard let mangaTitle = manga.title else {
                    continue
                }
                
                guard let mangaURL = manga.images?.jpg?.largeImageURL else {
                    continue
                }
                
                let rank: String
                if let mangaRank = manga.rank {
                    rank = "\(mangaRank)"
                } else {
                    rank = "?"
                }
                
                let viewModel = MangaTopViewCellViewModel(mangaName: mangaTitle, imageUrl: URL(string: mangaURL), topNumber: rank)
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    public func fetchMangaRecommendations() {
        guard let listRecommendationRequst = Request.listMangaRecommendations else {
            print("Failed to create listTopRequests")
            return
        }
        Service.shared.execute(listRecommendationRequst, expecting: GetMangaRecommendations.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.data
                self?.mangaRecommendations = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadTopManga()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchTopManga() {
        guard let listTopRequest = Request.listTopMangaRequests else { return }
        Service.shared.execute(listTopRequest, expecting: GetTopManga.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.data
                let info = responseModel.pagination
                self?.apiInfo = info
                self?.mangas = results
                self?.setupSections()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func setupSections() {
        sections = [
            .recommendations(viewModel: mangaRecommendations.compactMap({
                guard let imageUrl = $0.entry?.images?.jpg?.largeImageURL else { fatalError() }
                return MangaRecommendationsViewCellViewModel(mangaName: $0.entry?.title ?? "", imageUrl: URL(string: imageUrl))
            })),
            .top(viewModel: cellViewModels)
        ]
        
        sectionTitles.append("Recommendations")
        sectionTitles.append("Top")
    }
    
    public func createRecommendationsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderItem()]
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    public func createTopSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(280)
            ),
            subitems: [item]
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeaderItem()]
        return section
    }
    
    public func createHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        return header
    }
    
    private func fetchFullManga(_ mangaID: Int, completion: @escaping (MangaFull?) -> Void) {
        let mangaIDString = String(mangaID)
        guard let request = Request(endpoint: .manga, pathComponents: [mangaIDString, "full"]) else {
            completion(nil)
            return
        }
        Service.shared.execute(request, expecting: GetMangaFull.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let result = responseModel.data
                self?.mangaFull = result
                DispatchQueue.main.async {
                    self?.setupSections()
                    completion(result)
                }
            case .failure(let error):
                print(String(describing: error))
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }


}

extension MangaListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .recommendations(let viewModel):
            return viewModel.count
        case .top(let viewModel):
            return viewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .recommendations(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaRecommendationsCollectionViewCell.identifier, for: indexPath) as? MangaRecommendationsCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel[indexPath.row])
            return cell
        case .top(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MangaTopCollectionViewCell.identifier, for: indexPath) as? MangaTopCollectionViewCell else { fatalError() }
            cell.configure(with: viewModel[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }

        guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MangaSectionHeader.identifier, for: indexPath) as? MangaSectionHeader else {
            fatalError("Cannot dequeue section header")
        }

        let sectionType = sections[indexPath.section]
        let sectionTitle: String

        switch sectionType {
        case .recommendations:
            sectionTitle = "Recommendations"
        case .top:
            sectionTitle = "Top"
        }
        sectionHeader.configureSectionCell(label: sectionTitle.capitalized)
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectedManga()
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .recommendations:
            guard let mangaID = mangaRecommendations[indexPath.row].entry?.malID else { return }

            fetchFullManga(mangaID) { [weak self] mangaFull in
                DispatchQueue.main.async {
                    guard let mangaFull = mangaFull else {
                        print("mangaFull Empty")
                        return
                    }
                    self?.delegate?.didLoadMangaRecommendations(mangaFull)
                }
            }
        case .top:
            DispatchQueue.main.async {
                let manga = self.mangas[indexPath.row]
                self.delegate?.didLoadMangaRecommendations(manga)
            }
        }
    }
}

