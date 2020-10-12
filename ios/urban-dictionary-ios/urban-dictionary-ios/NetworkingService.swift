//
//  NetworkingService.swift
//  urban-dictionary-ios
//
//  Created by Kilo Loco on 10/11/20.
//

import Foundation

final class NetworkingService {
    
    func define(_ searchTerm: String, completion: @escaping (Result<[Term], Error>) -> Void) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mashape-community-urban-dictionary.p.rapidapi.com"
        urlComponents.path = "/define"
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: searchTerm)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkingError.badUrl))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("mashape-community-urban-dictionary.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue("pYQEsMdOHWmsh0C3bRjjDNLGS1kVp1NQ4F2jsnZbMfGJcMbn2M", forHTTPHeaderField: "x-rapidapi-key")
        
        
        let task = URLSession.shared.dataTask(with: request) {
            if let error = $2 {
                completion(.failure(error))
            } else if let data = $0 {
                do {
                    let response = try JSONDecoder().decode(
                        DefineSearchTermResponse.self,
                        from: data
                    )
                    DispatchQueue.main.async {
                        completion(.success(response.list))
                    }
                    
                    
                } catch {
                    completion(.failure(error))
                }
            }
            
        }
        
        task.resume()
    }
    
}

enum NetworkingError: Error {
    case badUrl
}
