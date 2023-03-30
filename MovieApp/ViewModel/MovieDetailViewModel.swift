//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 29.03.2023.
//

import Foundation
import UIKit


class MovieDetailViewModel{
    
    
    let omdbService = OmdbService()
    var movieDetailModel = Bindable<MovieDetailModel>()
    
    func fetchMovieDetail(imdb: String){
        omdbService.fetchMovieDetail(completion: { movieDetailModel in
            self.movieDetailModel.value = movieDetailModel
        }, imdb: imdb)
    }
    
    
    
}
