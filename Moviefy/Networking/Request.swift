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

struct APIRequest {
    
    static let headers = [
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(Secrets.apiKey)"
    ]
    
    
    func configureRequest(from route: Route, with parameters: [String: Any], and method: HTTPRequest, contains body: Data?) throws -> URLRequest {

        // safely unwrap URL or return error
        guard let url = URL(string: "https://api.themoviedb.org/3/\(route.rawValue)") else { fatalError("Error while unwrapping url")}
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.httpBody = body
        try APIRequest.configureParametersAndHeaders(parameters: parameters, headers: APIRequest.headers, request: &request)
        return request
    }
    
    static func configureParametersAndHeaders(parameters: [String: Any]?,
                                                  headers: [String: String]?,
                                                  request: inout URLRequest) throws {
        do {
            if let headers = headers, let parameters = parameters {
                try encodeParameters(for: &request, with: parameters)
                try setHeaders(for: &request, with: headers)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
}




