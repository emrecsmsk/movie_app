//
//  OmdbService.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 1.03.2023.
//

import Foundation
import Alamofire

class OmdbService {
    
    let url = "https://www.omdbapi.com/?apikey=ec34e385&"
    
    
    
    func fetchMovies(completion: @escaping (MoviesModel) -> Void, search: String, page: Int){
        
        let parameter = ["s":search, "page": page] as [String : Any]
        
        let request = AF.request(url, method: .get, parameters: parameter)
        
        request.responseDecodable(of: MoviesModel.self) { (response) in
            
            guard let moviesModel = response.value else {return}
            completion(moviesModel)
        }
    }
    
    func fetchMovieDetail(completion: @escaping (MovieDetailModel) -> Void, imdb: String){
        
        let parameter = ["i":imdb]
        
        let request = AF.request(url, method: .get, parameters: parameter)
        
        
        request.responseDecodable(of: MovieDetailModel.self) { (response) in
            
            guard let moviesModel = response.value else {return}
            completion(moviesModel)
        }
    }
}
