//
//  OmdbService.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 1.03.2023.
//

import Foundation

class OmdbService {
    
    func fetchMovies(completion: @escaping (MoviesModel) -> Void, search: String, page: Int){
        
        let queryItems = [URLQueryItem(name: "apikey", value: "ec34e385"), URLQueryItem(name: "s", value: search), URLQueryItem(name: "page", value: "\(page)")]
        var urlComps = URLComponents(string: "https://www.omdbapi.com/")!
        urlComps.queryItems = queryItems
        let request = urlComps.url!
        
        
        URLSession.shared.dataTask(with: request) { data,res,err  in
            
            do{
                
                if let data = data {
                    let moviesModel = try JSONDecoder().decode(MoviesModel.self, from: data)
                    completion(moviesModel)
                    
                }else{
                    print("No Data")
                }
                
     
            }catch(let error){
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                            }
                
            }
            
        }.resume()
    }

    func fetchMovieDetail(completion: @escaping (MovieDetailModel) -> Void, imdb: String){
        
        let queryItems = [URLQueryItem(name: "apikey", value: "ec34e385"),URLQueryItem(name: "i", value: imdb)]
        var urlComps = URLComponents(string: "https://www.omdbapi.com/")!
        urlComps.queryItems = queryItems
        let request = urlComps.url!
        
        URLSession.shared.dataTask(with: request) { data,res,err  in
            
            do{
                
                if let data = data {
                    let movieDetailModel = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                    completion(movieDetailModel)
                    
                }else{
                    print("No Data")
                }
                
     
            }catch(let error){
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                            }
                
            }
            
        }.resume()
    }
}
