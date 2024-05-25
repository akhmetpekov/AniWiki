//
//  TopAnimeRaitingCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimeRaitingCollectionViewCellViewModel {
    private let score: Double
    private let scoredBy: Int
    private let rank: Int
    init(score: Double, scoredBy: Int, rank: Int) {
        self.score = score
        self.scoredBy = scoredBy
        self.rank = rank
    }
}
