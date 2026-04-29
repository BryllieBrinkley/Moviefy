//
//  APIClient.swift
//  Moviefy
//
//  Created by Jibryll Brinkley on 4/28/26.
//

// Client: a computer in a network that uses the services provided by a server.
// Server: a piece of computer hardware or software (computer program) that provides functionality for other programs or devices (ie clients)

// API: part of the server that receives requests and sends responses.

// Network Manager / Networking Layer: a well-structured chunk of code used to make API requests and handle its responses from an external server.

import Foundation

struct APIClient {
    static let shared = APIClient()
    let session = URLSession(configuration: .default)
    
    let parameters = [
        "sort_by": "popularity.desc"
    ]
    
    func getPopularMovies(_ completion: @escaping (Result<[Movie]>) -> Void) {
        do {
            // Creating the request
            let request = try Request.configureRequest(from: .movies, with: parameters, and: .get, contains: nil)
            
            session.dataTask(with: request) { (data, response, error) in
                // URLSession error first
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.noResponse))
                    return
                }
                
                let result = Response.handleResponse(for: httpResponse)
                switch result {
                case .success:
                    guard let data = data else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(MovieAPIResponse.self, from: data)
                        completion(.success(apiResponse.movies))
                        
                    } catch {
                        completion(.failure(NetworkError.decodingFailed))
                    }
                case .failure(let err):
                    completion(.failure(err))
                }
            }.resume()
        } catch {
            completion(.failure(NetworkError.badRequest))
        }
    }
}
