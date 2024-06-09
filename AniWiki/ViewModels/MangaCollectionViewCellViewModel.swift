//
//  MangaCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 02.06.2024.
//

import Foundation

final class MangaCollectionViewCellViewModel: Hashable, Equatable {
    
    public let mangaTitle: String
    public let topNumber: String
    private let mangaImageURL: URL?
    
    init(mangaTitle: String, mangaImageURL: URL?, topNumber: String) {
        self.mangaTitle = mangaTitle
        self.topNumber = topNumber
        self.mangaImageURL = mangaImageURL
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = mangaImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    static func == (lhs: MangaCollectionViewCellViewModel, rhs: MangaCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(mangaTitle)
        hasher.combine(topNumber)
        hasher.combine(mangaImageURL)
    }
}
