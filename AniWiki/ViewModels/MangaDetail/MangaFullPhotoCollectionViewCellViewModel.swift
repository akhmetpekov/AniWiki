//
//  MangaPhotoViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 04.06.2024.
//

import Foundation

final class MangaFullPhotoCollectionViewCellViewModel: Hashable, Equatable {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
    
    static func == (lhs: MangaFullPhotoCollectionViewCellViewModel, rhs: MangaFullPhotoCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageUrl)
    }
}
