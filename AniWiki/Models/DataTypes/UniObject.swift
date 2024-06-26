import Foundation

// MARK: - Top
struct UniObject: Codable {
    let malID: Int?
    let url: String?
    let images: Image?
    let trailer: Trailer?
    let approved: Bool?
    let titles: [Title]?
    let title, titleEnglish, titleJapanese: String?
    let titleSynonyms: [String]?
    let type, source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool?
    let aired: Aired?
    let duration, rating: String?
    let score: Double?
    let scoredBy, rank, popularity: Int?
    let members, favorites: Int?
    let synopsis, background, season: String?
    let year: Int?
    let broadcast: Broadcast?
    let producers, licensors, studios, genres: [Demographic]?
    let explicitGenres, themes, demographics: [Demographic]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, trailer, approved, titles, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, season, year, broadcast, producers, licensors, studios, genres
        case explicitGenres = "explicit_genres"
        case themes, demographics
    }
}

// MARK: - Aired
struct Aired: Codable {
    let from, to: String?
    let prop: Prop?
}

// MARK: - Prop
struct Prop: Codable {
    let from, to: From?
    let string: String?
}

// MARK: - From
struct From: Codable {
    let day, month, year: Int?
}

// MARK: - Broadcast
struct Broadcast: Codable {
    let day, time, timezone, string: String?
}

// MARK: - Demographic
struct Demographic: Codable {
    let malID: Int?
    let type, name, url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

// MARK: - Image
struct Image: Codable {
    let jpg: Jpg?
    let webp: Webp?
}

struct Jpg: Codable {
    let imageURL: String?
    let smallImageURL: String?
    let largeImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

struct Webp: Codable {
    let imageURL: String?
    let smallImageURL: String?
    let largeImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Title
struct Title: Codable {
    let type, title: String?
}

// MARK: - Trailer
struct Trailer: Codable {
    let youtubeID, url, embedURL: String?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
    }
}


