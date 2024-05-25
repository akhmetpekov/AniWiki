//
//  TopAnimeTrailerCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimeTrailerCollectionViewCellViewModel {
    private let trailerID: String?
    init(trailerID: String?) {
        self.trailerID = trailerID
    }
    
    public func getTrailerID() -> String? {
        return trailerID
    }
}
