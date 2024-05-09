//
//  GetAllTop.swift
//  AniWiki
//
//  Created by Erik on 06.05.2024.
//

import Foundation

struct GetAllTop: Codable {
    struct Pagination: Codable {
        let lastVisiblePage: Int?
        let hasNextPage: Bool?
        let items: Items?

        enum CodingKeys: String, CodingKey {
            case lastVisiblePage = "last_visible_page"
            case hasNextPage = "has_next_page"
            case items
        }
    }
    
    // MARK: - Items
    struct Items: Codable {
        let count, total, perPage: Int?

        enum CodingKeys: String, CodingKey {
            case count, total
            case perPage = "per_page"
        }
    }

    
    let pagination: Pagination
    let data: [Top]
}
