//
//  Request.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import Foundation

final class Request {
    private struct Constants {
        static let baseUrl = "https://api.jikan.moe/v4"
    }
    
    let endpoint: Endpoint
    
    let pathComponents: [String]
    
    let queryParametes: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParametes.isEmpty {
            string += "?"
            let argumentString = queryParametes.compactMap ({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init?(endpoint: Endpoint,
         pathComponents: [String] = [],
         queryParametes: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParametes = queryParametes
    }
}

extension Request {
    static let listTopRequests = Request(endpoint: .top, pathComponents: ["anime"], queryParametes: [URLQueryItem(name: "page", value: "1")])
}
