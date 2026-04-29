import Foundation

struct Movie {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
}

extension Movie: Codable {
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
}

struct MovieAPIResponse: Decodable {
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
