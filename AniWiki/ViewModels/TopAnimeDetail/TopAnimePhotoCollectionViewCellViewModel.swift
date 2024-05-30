//
//  TopAnimePhotoCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimePhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    public let animeName: String?
    public let genres: [Demographic]
    public let year: Int
    public let type: String
    private let score: Double
    private let scoredBy: Int
    init(imageUrl: URL?, animeName: String?, genres: [Demographic], year: Int, type: String, score: Double, scoredBy: Int) {
        self.imageUrl = imageUrl
        self.animeName = animeName
        self.genres = genres
        self.year = year
        self.type = type
        self.score = score
        self.scoredBy = scoredBy
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
    
    public func getScore() -> Double {
        return score * 5 / 10
    }
    
    public func getScoredBy() -> String {
        return "(\(scoredBy / 1000)K)"
    }
}
