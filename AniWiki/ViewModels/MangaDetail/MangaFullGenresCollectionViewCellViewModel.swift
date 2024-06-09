//
//  MangaFullGenresCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 06.06.2024.
//

import Foundation

final class MangaFullGenresCollectionViewCellViewModel {
    public let genres: [Author]
    
    init(genres: [Author]) {
        self.genres = genres
    }
}
