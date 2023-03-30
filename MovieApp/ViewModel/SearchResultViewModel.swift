//
//  SearchResultViewModel.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 29.03.2023.
//

import Foundation

class SearchResultViewModel{
    
    let omdbService = OmdbService()
    var searchMoviesModel = Bindable<MoviesModel>()
    
    func fetchMovies(search:String){
        omdbService.fetchMovies(completion: { moviesModel in
            
            self.searchMoviesModel.value = moviesModel
            
        }, search: search, page: 1)
    }
    
    func fetchMoviesPaging(search:String, page: Int){
        omdbService.fetchMovies(completion: { moviesModel in
            
            if(moviesModel.response == "True") {
                
                for i in 0...((moviesModel.search?.count ?? 0)-1){
                    self.searchMoviesModel.value?.search?.append(moviesModel.search![i])
                }
                
            }
            
           
            
        }, search: search, page: page)
    }
    
}
