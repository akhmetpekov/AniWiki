//
//  TopListViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 07.05.2024.
//

import Foundation
import UIKit

final class TopListViewViewModel: NSObject {
    func fetchTopAnime() {
        Service.shared.execute(.listTopRequests, expecting: GetAllTop.self) { result in
            switch result {
            case .success(let model):
                guard let images = model.data[0].images else {
                    return
                }
                print(String(describing: images.jpg?.imageURL))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension TopListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? TopCollectionViewCell else {
            fatalError()
        }
        let viewModel = TopCollectionViewCellViewModel(animeTitle: "Sousou no Frieren", animeImageURL: URL(string: "https://cdn.myanimelist.net/images/anime/1015/138006.jpg"))
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 40)/2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
