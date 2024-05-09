//
//  TopCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 07.05.2024.
//

import Foundation

final class TopCollectionViewCellViewModel {
    
    public let animeTitle: String
    private let animeImageURL: URL?
    
    init(animeTitle: String, animeImageURL: URL?) {
        self.animeTitle = animeTitle
        self.animeImageURL = animeImageURL
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = animeImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
