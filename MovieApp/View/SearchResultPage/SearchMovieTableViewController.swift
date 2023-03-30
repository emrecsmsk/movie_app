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
    
    var viewModel = SearchResultViewModel()
    var search = String()
    var movieDetailText = String()
    var page = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesActivityIndicatorView.startAnimating()
        viewModel.fetchMovies(search: search)
        initObservers()
        
    }
    
    func refresh() {
        
        DispatchQueue.main.async {
            if(self.viewModel.searchMoviesModel.value?.response == "False"){
                self.moviesActivityIndicatorView.isHidden = true
                self.notFoundImage.isHidden = false
            }
            
            self.searchMovieTableView.reloadData()
            self.moviesActivityIndicatorView.isHidden = true
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchMoviesModel.value?.search?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchMovieCell", for: indexPath) as! SearchMovieTableViewCell
        
        cell.searchMovieImage.clipsToBounds = true;
        cell.searchMovieImage.layer.cornerRadius = 10;
        
        let url = URL(string: viewModel.searchMoviesModel.value?.search?[indexPath.row].poster ?? "")
        
        cell.searchMovieImage.kf.setImage(with: url)
        
        cell.searchMovieName.text = viewModel.searchMoviesModel.value?.search?[indexPath.row].title ?? ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieDetailText = viewModel.searchMoviesModel.value?.search?[indexPath.row].imdbID ?? "tt0499549"
        performSegue(withIdentifier: "movieDetailWithSearch", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailWithSearch"{
            let destinationVC = segue.destination as! MovieDetailViewController
            destinationVC.imdb = movieDetailText
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (viewModel.searchMoviesModel.value?.search?.count ?? 0) - 1 && viewModel.searchMoviesModel.value?.response == "True" ){
            page += 1
            viewModel.fetchMoviesPaging(search: search, page: page)
        }
    }
    
    private func initObservers() {
        viewModel.searchMoviesModel.bind { movie in
            self.refresh()
            
        }
    }
    
}
