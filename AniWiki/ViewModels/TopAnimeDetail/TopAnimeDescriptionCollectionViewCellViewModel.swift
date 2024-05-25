//
//  TopAnimeDescriptionCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 23.05.2024.
//

import Foundation

final class TopAnimeDescriptionCollectionViewCellViewModel {
    private let description: String
    init(description: String) {
        self.description = description
    }
    
    public func getDescription() -> String {
        return description
    }
}
