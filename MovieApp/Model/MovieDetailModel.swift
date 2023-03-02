//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 1.03.2023.
//

import Foundation

// MARK: - MovieDetailModel
struct MovieDetailModel: Codable {
    let title, year, runtime, genre, plot: String
    let actors: String
    let poster: String
    let imdbRating: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case genre = "Genre"
        case actors = "Actors"
        case poster = "Poster"
        case plot = "Plot"
        case imdbRating
    }
}

