//
//  TopAnimePhotoCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimePhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    private let animeName: String?
    private let genres: [Demographic]
    private let year: Int
    private let type: String
    init(imageUrl: URL?, animeName: String?, genres: [Demographic], year: Int, type: String) {
        self.imageUrl = imageUrl
        self.animeName = animeName
        self.genres = genres
        self.year = year
        self.type = type
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
    
    public func getAnimeTitle() -> String {
        guard let animeName = animeName else {
            return ""
        }
        return animeName
    }
    
    public func getGenres() -> [Demographic] {
        return genres
    }
    
    public func getYear() -> Int {
        return year
    }
    
    public func getType() -> String {
        return type
    }
}
