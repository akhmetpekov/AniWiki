//
//  MangaFullInformationCollectionViewCellViewModel.swift
//  AniWiki
//
//  Created by Erik on 06.06.2024.
//

import Foundation

final class MangaFullInformationCollectionViewCellViewModel {
    private let status: String
    public let chapters: Int
    public let favorites: Int
    private let authors: [Author]?
    private let publishers: [Author]?
    
    init(status: String, chapters: Int, favorites: Int, authors: [Author]?, publishers: [Author]?) {
        self.status = status
        self.chapters = chapters
        self.favorites = favorites
        self.authors = authors
        self.publishers = publishers
    }
    
    public var statusConverted: String {
        if status == "Publishing" {
            return "Ongoing"
        } else {
            return status
        }
    }
    
    public var authorsConverted: String {
        var authorNames: [String] = []
        guard let authors = authors else { return "" }
        for author in authors {
            guard let authorName = author.name else { continue }
            authorNames.append(authorName)
        }
        return authorNames.joined(separator: "  ")
    }
    
    public var publlishersConverted: String {
        var publisherNames: [String] = []
        guard let publishers = publishers else { return "" }
        for publisher in publishers {
            guard let publisherName = publisher.name else { continue }
            publisherNames.append(publisherName)
        }
        return publisherNames.joined(separator: "  ")
    }
}
