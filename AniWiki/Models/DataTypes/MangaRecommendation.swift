//
//  Anime.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//


struct MangaRecommendation: Codable {
    let entry: Entry?
    let url: String?
    let votes: Int?
}

// MARK: - Entry
struct Entry: Codable {
    let malID: Int?
    let url: String?
    let images: MangaImage?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, title
    }
}

// MARK: - Image
struct MangaImage: Codable {
    let jpg: MangaJpg?
    let webp: MangaWebp?
}

struct MangaJpg: Codable {
    let imageURL: String?
    let smallImageURL: String?
    let largeImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

struct MangaWebp: Codable {
    let imageURL: String?
    let smallImageURL: String?
    let largeImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}
