//
//  TopAnimeProducersCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimeProducersCollectionViewCellViewModel {
    private let producers: [Demographic]
    init(producers: [Demographic]) {
        self.producers = producers
    }
}
