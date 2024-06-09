//
//  MangaRecommendationsViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 02.06.2024.
//

import Foundation

final class MangaRecommendationsViewCellViewModel: Hashable, Equatable {
    public let mangaName: String?
    private let imageUrl: URL?
    
    init(mangaName: String?, imageUrl: URL?) {
        self.mangaName = mangaName
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
    
    static func == (lhs: MangaRecommendationsViewCellViewModel, rhs: MangaRecommendationsViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(mangaName)
        hasher.combine(imageUrl)
    }
}
