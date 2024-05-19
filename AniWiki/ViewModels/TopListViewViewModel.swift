//
//  TopListViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 07.05.2024.
//

import Foundation
import UIKit

protocol TopListViewViewModelDelegate: AnyObject {
    func didLoadTopAnime()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectAnime(_ anime: Top)
}

final class TopListViewViewModel: NSObject {
    
    public weak var delegate: TopListViewViewModelDelegate?
    
    private var isLoadingMoreTopAnime = false
    
    private var animes: [Top] = [] {
        didSet {
            for (index, anime) in animes.enumerated() {
                guard let animeTitle = anime.title else {
                    continue
                }
                
                guard let animeURL = anime.images?.jpg?.largeImageURL else {
                    continue
                }
                
                let viewModel = TopCollectionViewCellViewModel(animeTitle: animeTitle, animeImageURL: URL(string: animeURL), topNumber: "\(index+1)")
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [TopCollectionViewCellViewModel] = []
    
    private var apiInfo: GetAllTop.Pagination? = nil
    
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
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreTopAnime = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreTopAnime = false
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
            withReuseIdentifier: TopCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? TopCollectionViewCell else {
            fatalError()
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else {
            fatalError()
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? FooterLoadingCollectionReusableView else {
            fatalError()
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
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
        guard shouldShowLoadMoreIndicator, !isLoadingMoreTopAnime, !cellViewModels.isEmpty  else {
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
