//
//  Request.swift
//  Moviefy
//
//  Created by Jibryll Brinkley on 4/29/26.
//

import Foundation

enum HTTPRequest: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum Route: String {
    case movies = "discover/movie"

}

struct Request {
    static let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")!

    static let headers: [String: String] = [
        "Accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    static func configureRequest(from route: Route, with parameters: [String: Any], and method: HTTPRequest, contains body: Data?) throws -> URLRequest {
        guard let url = URL(string: "https://api.themoviedb.org/3/\(route.rawValue)") else {
            throw NetworkError.missingURL
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        // Merge provided parameters with the api_key (v3)
        var mergedParams = parameters
        mergedParams["api_key"] = Secrets.apiKey
        
        try configureParametersAndHeaders(parameters: mergedParams, headers: headers, request: &request)
        return request
    }
    
    static func configureParametersAndHeaders(parameters: [String: Any]?,
                                              headers: [String: String]?,
                                              request: inout URLRequest) throws {
        do {
            if let headers = headers {
                try Encoder.setHeaders(for: &request, with: headers)
            }
            if let parameters = parameters {
                try Encoder.encodeParameters(for: &request, with: parameters)
            }
            
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
