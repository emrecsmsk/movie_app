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
            
        }, search: search)
    }
    
    func refresh() {
        searchMovieTableView.reloadData()
        moviesActivityIndicatorView.isHidden = true
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

}
