//
//  MangaTopViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 08.06.2024.
//

import Foundation

final class MangaTopViewCellViewModel: Hashable, Equatable {
    public let mangaName: String
    private let imageUrl: URL?
    public let topNumber: String
    
    init(mangaName: String, imageUrl: URL?, topNumber: String) {
        self.mangaName = mangaName
        self.topNumber = topNumber
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
    
    static func == (lhs: MangaTopViewCellViewModel, rhs: MangaTopViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(mangaName)
        hasher.combine(imageUrl)
        hasher.combine(topNumber)
    }
}
