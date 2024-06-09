//
//  MangaFullBaseInfoCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 05.06.2024.
//

import Foundation

final class MangaFullBaseInfoCollectionViewCellViewModel {
    private let startDate: Int
    public let type: String
    public let score: Double
    private let scoredBy: Int
    
    init(startDate: Int, type: String, score: Double, scoredBy: Int) {
        self.startDate = startDate
        self.type = type
        self.score = score
        self.scoredBy = scoredBy
    }
    
    public var scoredByString: String {
        if scoredBy >= 1000 {
            return "[\(scoredBy / 1000)K]"
        } else {
            return "[\(scoredBy)]"
        }
    }
    
    public var year: String {
        return "\(startDate) y."
    }
    
}
