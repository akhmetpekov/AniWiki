//
//  AnimeDetailViewViewModel.swift
//  AniWiki
//
//  Created by Erik on 13.05.2024.
//

import UIKit

final class AnimeDetailViewViewModel {
    private let anime: Top
    
    init(anime: Top) {
        self.anime = anime
    }
    
    public var title: String? {
        anime.title
    }
}
