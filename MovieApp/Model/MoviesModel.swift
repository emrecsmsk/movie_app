//
//  MoviesModel.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 1.03.2023.
//

import Foundation

// MARK: - MoviesModel
struct MoviesModel: Codable {
    let search: [Search]?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case response = "Response"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, imdbID: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case imdbID
        case poster = "Poster"
    }
}
