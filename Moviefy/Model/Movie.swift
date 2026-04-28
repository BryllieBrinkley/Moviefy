//
//  Movie.swift
//  Moviefy
//
//  Created by Adriana González Martínez on 4/7/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
}

// properties within a Movie returned from the API that we want to extract the info from
extension Movie: Codable {
    
    enum MovieCodingKeys: String, Codable {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
    }
    
    //Decode API properties into proper type "string" "int"
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
}

struct MovieAPIResponse {
    let page: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieAPIResponse {
    
    private enum MovieAPIResponseCodingKeys: String, CodingKey {
        case page
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieAPIResponseCodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
}
