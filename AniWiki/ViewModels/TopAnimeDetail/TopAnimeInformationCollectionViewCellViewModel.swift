//
//  TopAnimeInformationCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimeInformationCollectionViewCellViewModel {
    public let episodes: Int
    public let duration: String
    public let status: String
    public let source: String
    public let titleEnglish: String
    public let titleJapanese: String
    public let rating: String
    private let genres: [Demographic]
    public let rank: Int
    private let studios: [Demographic]
    private let producers: [Demographic]

    init(episodes: Int, duration: String, status: String, source: String, titleEnglish: String, titleJapanese: String, rating: String, genres: [Demographic], rank: Int, studios: [Demographic], producers: [Demographic]) {
        self.episodes = episodes
        self.duration = duration
        self.status = status
        self.source = source
        self.titleEnglish = titleEnglish
        self.titleJapanese = titleJapanese
        self.rating = rating
        self.genres = genres
        self.rank = rank
        self.studios = studios
        self.producers = producers
    }
    
    public func getGenres() -> String {
        var genreNames: [String] = []
        for genre in genres {
            guard let genreName = genre.name else { continue }
            genreNames.append(genreName)
        }
        return genreNames.joined(separator: ", ")
    }
    
    public func getStudios() -> String {
        var studioNames: [String] = []
        for studio in studios {
            guard let studioName = studio.name else { continue }
            studioNames.append(studioName)
        }
        return studioNames.joined(separator: ", ")
    }
    
    public func getProducers() -> String {
        var producersNames: [String] = []
        for producer in producers {
            guard let producerName = producer.name else { continue }
            producersNames.append(producerName)
        }
        return producersNames.joined(separator: ", ")
    }
    
}
