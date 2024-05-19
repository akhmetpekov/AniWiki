//
//  Service.swift
//  AniWiki
//
//  Created by Erik on 05.05.2024.
//

import Foundation

final class Service {
    static let shared = Service()
    
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequst = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequst) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from awRequest: Request) -> URLRequest? {
        guard let url = awRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = awRequest.httpMethod
        return request
    }
}
