//
//  MangaFull.swift
//  AniWiki
//
//  Created by Erik on 04.06.2024.
//

import Foundation

struct GetMangaFull: Codable {
    let data: MangaFull
}

struct GetTopManga: Codable {
    struct Pagination: Codable {
        let lastVisiblePage: Int?
        let hasNextPage: Bool?
        let items: Items?
        let currentPage: Int?

        enum CodingKeys: String, CodingKey {
            case lastVisiblePage = "last_visible_page"
            case hasNextPage = "has_next_page"
            case currentPage = "current_page"
            case items
        }
    }
    struct Items: Codable {
        let count, total, perPage: Int?

        enum CodingKeys: String, CodingKey {
            case count, total
            case perPage = "per_page"
        }
    }
    
    let pagination: Pagination
    let data: [MangaFull]
}

struct MangaFull: Codable {
    let malID: Int?
    let url: String?
    let images: MangaFullImage?
    let approved: Bool?
    let titles: [MangaFullTitle]?
    let title, titleEnglish, titleJapanese: String?
    let type: String?
    let chapters, volumes: Int?
    let status: String?
    let publishing: Bool?
    let published: Published?
    let score, scored: Double?
    let scoredBy, rank, popularity, members: Int?
    let favorites: Int?
    let synopsis, background: String?
    let authors, serializations, genres: [Author]?
    let themes, demographics: [Author]?
    let relations: [Relation]?
    let external: [External]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, approved, titles, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case type, chapters, volumes, status, publishing, published, score, scored
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, authors, serializations, genres
        case themes, demographics, relations, external
    }
}

// MARK: - Author
struct Author: Codable {
    let malID: Int?
    let type: TypeEnum?
    let name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

enum TypeEnum: String, Codable {
    case anime = "anime"
    case manga = "manga"
    case people = "people"
}

// MARK: - External
struct External: Codable {
    let name: String?
    let url: String?
}

// MARK: - Image
struct MangaFullImage: Codable {
    let jpg: MangaFullJpg?
    let webp: MangaFullWebp?
}

struct MangaFullJpg: Codable {
    let imageURL: String?
    let smallImageURL: String?
    let largeImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

struct MangaFullWebp: Codable {
    let imageURL: String?
    let smallImageURL: String?
    let largeImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Published
struct Published: Codable {
    let from, to: String?
    let prop: MangaFullProp?
    let string: String?
}

// MARK: - Prop
struct MangaFullProp: Codable {
    let from, to: MangaFullFrom?
}

// MARK: - From
struct MangaFullFrom: Codable {
    let day, month, year: Int?
}

// MARK: - Relation
struct Relation: Codable {
    let relation: String?
    let entry: [Author]?
}

// MARK: - Title
struct MangaFullTitle: Codable {
    let type, title: String?
}
