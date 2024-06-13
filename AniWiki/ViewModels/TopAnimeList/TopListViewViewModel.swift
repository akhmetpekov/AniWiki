//
//  TopListViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 07.05.2024.
//

import Foundation
import UIKit
import Combine

protocol TopListViewViewModelDelegate: AnyObject {
    func didLoadTopAnime()
    func didLoadMoreAnime(with newIndexPaths: [IndexPath])
    func didSelectAnime(_ anime: UniObject)
    func didLoadSearchAnime()
}

final class TopListViewViewModel: NSObject {
    
    public weak var delegate: TopListViewViewModelDelegate?
    
    private var isLoadingMoreTopAnime = false
    private var isSearching = false
    var cancellables: Set<AnyCancellable> = []
    private var cellViewModels: [TopCollectionViewCellViewModel] = []
    
    private var apiInfo: GetAllTop.Pagination? = nil
    
    var searchTextPublisher = PassthroughSubject<String, Never>()
    
    private var animes: [UniObject] = [] {
        didSet {
            for anime in animes {
                guard let animeTitle = anime.title else {
                    continue
                }
                
                guard let animeURL = anime.images?.jpg?.largeImageURL else {
                    continue
                }
                
                let rank: String
                if let animeRank = anime.rank {
                    rank = "\(animeRank)"
                } else {
                    rank = "?"
                }
                
                let viewModel = TopCollectionViewCellViewModel(animeTitle: animeTitle, animeImageURL: URL(string: animeURL), topNumber: rank)
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    public func fetchTopAnime() {
        guard let listTopRequests = Request.listTopRequests else {
            print("Failed to create listTopRequests")
            return
        }
        Service.shared.execute(listTopRequests, expecting: GetAllTop.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.data
                let info = responseModel.pagination
                self?.apiInfo = info
                self?.animes = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadTopAnime()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalTopAnime() {
        if isSearching == true {
            return
        }
        guard !isLoadingMoreTopAnime else {
            return
        }
        isLoadingMoreTopAnime = true
        guard var nextPage = apiInfo?.currentPage else { return }
        nextPage += 1
        guard let request = Request(
            endpoint: .top,
            pathComponents: ["anime"],
            queryParametes: [URLQueryItem(name: "page", value: String(nextPage))]) else {
            isLoadingMoreTopAnime = false
            return
        }
        Service.shared.execute(request, expecting: GetAllTop.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.data
                let info = responseModel.pagination
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.animes.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.animes.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreAnime(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreTopAnime = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreTopAnime = false
            }
        }
    }
    
    
    
    public func fetchSearchResultsAnime(query: String) {
        guard !query.isEmpty else {
            isSearching = false
            self.cellViewModels.removeAll()
            fetchTopAnime()
            return
        }
        isSearching = true
        
        guard let request = Request(
            endpoint: .anime,
            queryParametes: [URLQueryItem(name: "q", value: query)]
        ) else {
            return
        }
        Service.shared.execute(request, expecting: GetAllTop.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.data
                let info = responseModel.pagination
                self?.cellViewModels.removeAll()
                self?.apiInfo = info
                self?.animes = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadSearchAnime()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        guard let hasNextPage = apiInfo?.hasNextPage else { return false }
        return hasNextPage
    }
}

extension TopListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopAnimeCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? TopAnimeCollectionViewCell else {
            fatalError()
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter || kind == UICollectionView.elementKindSectionHeader else {
            fatalError()
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TopAnimeSearchBar.identifier,
                for: indexPath
            ) as? TopAnimeSearchBar else {
                fatalError()
            }
            
            header.textPublisher
                .sink { [weak self] searchText in
                    self?.searchTextPublisher.send(searchText)
                }
                .store(in: &cancellables)
            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
                for: indexPath
            ) as? FooterLoadingCollectionReusableView else {
                fatalError()
            }
            footer.startAnimating()
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 40)/2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let anime = animes[indexPath.row]
        delegate?.didSelectAnime(anime)
    }
}

extension TopListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldShowLoadMoreIndicator, !isLoadingMoreTopAnime, !cellViewModels.isEmpty else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalTopAnime()
            }
            t.invalidate()
        }
    }
}
