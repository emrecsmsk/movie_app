//
//  HomePageViewModel.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 29.03.2023.
//

import Foundation


class HomePageViewModel {
    
    let omdbService = OmdbService()
    var popularMoviesModel = Bindable<MoviesModel>()
    var trendingNowModel = Bindable<MoviesModel>()
    
    
    func fetchCurrentMovies(popular: String, trendingNow: String){
         omdbService.fetchMovies(completion: { moviesModel in
             self.popularMoviesModel.value = moviesModel
         }, search: popular, page: 1)
        
        omdbService.fetchMovies(completion: { moviesModel in
            self.trendingNowModel.value = moviesModel
        }, search: trendingNow, page: 1)
        
    }
}
