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
    func didSelectAnime(_ anime: Top)
}

final class TopListViewViewModel: NSObject {
    
    public weak var delegate: TopListViewViewModelDelegate?
    
    private var animes: [Top] = [] {
        didSet {
            for (index, anime) in animes.enumerated() {
                guard let animeTitle = anime.titleEnglish else {
                    continue
                }
                
                guard let animeURL = anime.images?.jpg?.largeImageURL else {
                    continue
                }
                
                let viewModel = TopCollectionViewCellViewModel(animeTitle: animeTitle, animeImageURL: URL(string: animeURL), topNumber: "#\(index+1)")
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [TopCollectionViewCellViewModel] = []
    
    private var apiInfo: GetAllTop.Pagination? = nil
    
    public func fetchTopAnime() {
        Service.shared.execute(.listTopRequests, expecting: GetAllTop.self) { [weak self] result in
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
        guard shouldShowLoadMoreIndicator else {
            return
        }
    }
}
