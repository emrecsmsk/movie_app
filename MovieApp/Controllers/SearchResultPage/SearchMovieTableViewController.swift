//
//  SearchMovieTableViewController.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 1.03.2023.
//

import UIKit
import Kingfisher

class SearchMovieTableViewController: UITableViewController {
    
    @IBOutlet var searchMovieTableView: UITableView!
    @IBOutlet var moviesActivityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var notFoundImage: UIImageView!
    var search = String()
    var searchMoviesModel = MoviesModel(search:[], response: "")
    let omdbService = OmdbService()
    var movieDetailText = String()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        
        moviesActivityIndicatorView.startAnimating()
        fetchMovies(search: search)
        
    }
    
    func fetchMovies(search:String){
        omdbService.fetchMovies(completion: { moviesModel in
            
            if(moviesModel.response == "False"){
                self.moviesActivityIndicatorView.isHidden = true
                self.notFoundImage.isHidden = false
            }else{
                self.searchMoviesModel = moviesModel
                self.refresh()
            }
            
        }, search: search, page: 1)
    }
    
    func fetchMoviesPaging(search:String, page: Int){
        omdbService.fetchMovies(completion: { moviesModel in
            
            if(moviesModel.response == "False"){
                self.moviesActivityIndicatorView.isHidden = true
                self.notFoundImage.isHidden = false
            }else{
                for i in 0...((moviesModel.search?.count ?? 0)-1){
                    self.searchMoviesModel.search?.append(moviesModel.search![i])
                }
                self.refresh()
            }
            
        }, search: search, page: page)
    }
    
    
    
    func refresh() {
        DispatchQueue.main.async {
            self.searchMovieTableView.reloadData()
            self.moviesActivityIndicatorView.isHidden = true
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMoviesModel.search?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchMovieCell", for: indexPath) as! SearchMovieTableViewCell
        
        cell.searchMovieImage.clipsToBounds = true;
        cell.searchMovieImage.layer.cornerRadius = 10;
        
        let url = URL(string: searchMoviesModel.search?[indexPath.row].poster ?? "")

        cell.searchMovieImage.kf.setImage(with: url)
        
        cell.searchMovieName.text = searchMoviesModel.search?[indexPath.row].title ?? ""

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieDetailText = searchMoviesModel.search?[indexPath.row].imdbID ?? "tt0499549"
        performSegue(withIdentifier: "movieDetailWithSearch", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailWithSearch"{
            let destinationVC = segue.destination as! MovieDetailViewController
            destinationVC.imdb = movieDetailText
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (searchMoviesModel.search?.count ?? 0) - 1 && searchMoviesModel.response == "True" ){
            page += 1
            fetchMoviesPaging(search: search, page: page)
        }
    }

}
