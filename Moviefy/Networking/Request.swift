//
//  Request.swift
//  Moviefy
//
//  Created by Jibryll Brinkley on 4/29/26.
//

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
}
