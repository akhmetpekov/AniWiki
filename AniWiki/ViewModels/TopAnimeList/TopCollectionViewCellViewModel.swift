//
//  TopCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 07.05.2024.
//

import Foundation

final class TopCollectionViewCellViewModel: Hashable, Equatable {
    
    public let animeTitle: String
    public let topNumber: String
    private let animeImageURL: URL?
    
    init(animeTitle: String, animeImageURL: URL?, topNumber: String) {
        self.animeTitle = animeTitle
        self.topNumber = topNumber
        self.animeImageURL = animeImageURL
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = animeImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    static func == (lhs: TopCollectionViewCellViewModel, rhs: TopCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(animeTitle)
        hasher.combine(topNumber)
        hasher.combine(animeImageURL)
    }
}
