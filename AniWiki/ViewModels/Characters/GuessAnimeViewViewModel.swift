//
//  GuessAnimeViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 09.06.2024.
//

import Foundation
import Combine

final class GuessAnimeViewViewModel {
    @Published public var animeName: String = "???"
    @Published public var animeURL: URL? = nil
    
    private var retryCount = 0
    private let maxRetries = 25
    private var cancellables = Set<AnyCancellable>()
    
    public func fetchAnime() {
        guard let listTopRequests = Request.randomAnime else {
            print("Failed to create listTopRequests")
            return
        }
        Service.shared.execute(listTopRequests, expecting: GetRandomAnime.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.data
                guard let imageURL = results.images?.jpg?.largeImageURL, let animeTitle = results.titleEnglish else {
                    print("Cannot fetch image or title, retrying...")
                    self?.retryFetchAnime()
                    return
                }
                self?.animeURL = URL(string: imageURL)
                self?.animeName = animeTitle
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func retryFetchAnime() {
        guard retryCount < maxRetries else {
            print("Max retries reached")
            return
        }
        retryCount += 1
        fetchAnime()
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = animeURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}

