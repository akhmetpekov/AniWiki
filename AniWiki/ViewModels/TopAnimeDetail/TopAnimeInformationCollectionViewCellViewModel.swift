//
//  TopAnimeInformationCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimeInformationCollectionViewCellViewModel {
    private let episodes: Int
    private let duration: String
    private let status: String
    private let source: String
    private let titleEnglish: String
    private let titleJapanese: String
    private let rating: String

    init(episodes: Int, duration: String, status: String, source: String, titleEnglish: String, titleJapanese: String, rating: String) {
        self.episodes = episodes
        self.duration = duration
        self.status = status
        self.source = source
        self.titleEnglish = titleEnglish
        self.titleJapanese = titleJapanese
        self.rating = rating
    }
    
}
