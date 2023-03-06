//
//  HomePageViewController.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 28.02.2023.
//

import UIKit
import Kingfisher
import Alamofire

class HomePageViewController: UIViewController,UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var moviesActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var popularMovieCollectionView: UICollectionView!
    @IBOutlet weak var trendingNowCollectionView: UICollectionView!
    @IBOutlet weak var popularMovieLabel: UILabel!
    @IBOutlet weak var trendingNowLabel: UILabel!
    
    let omdbService = OmdbService()
    var popularMoviesModel = MoviesModel(search:[], response: "")
    var trendingNowModel = MoviesModel(search:[], response: "")
    var searchText = String()
    var movieDetailText = String()
    let search = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(ConnectivityControl.isConnectedToInternet != true){
            performSegue(withIdentifier: "noInternetConnection", sender: nil)
        }

        
        
        
       
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        
        moviesActivityIndicatorView.startAnimating()
        
        fetchCurrentMovies(popular: "avengers", trendingNow: "avatar")


    }
    
    
     func refresh() {
        popularMovieCollectionView.reloadData()
        trendingNowCollectionView.reloadData()
        popularMovieLabel.isHidden = false
        trendingNowLabel.isHidden = false
        popularMovieCollectionView.isHidden = false
        trendingNowCollectionView.isHidden = false
        moviesActivityIndicatorView.isHidden = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == popularMovieCollectionView){
           return popularMoviesModel.search?.count ?? 0
        }else{
            return trendingNowModel.search?.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == popularMovieCollectionView){
            let cell = popularMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "popularMovieCell", for: indexPath) as! PopularMovieCollectionViewCell
            
            let url =  URL(string: popularMoviesModel.search?[indexPath.row].poster ?? "")
            
            cell.popularMovieImage.kf.setImage(with: url)
            
            cell.popularMovieImage.layer.cornerRadius = 10.0
            
            return cell
        }else{
            let cell = trendingNowCollectionView.dequeueReusableCell(withReuseIdentifier: "trendingNowCell", for: indexPath) as! TrendingNowCollectionViewCell
            
            let url =  URL(string: trendingNowModel.search?[indexPath.row].poster ?? "")
            
            cell.trendingNowImage.kf.setImage(with: url)
            
            cell.trendingNowImage.layer.cornerRadius = 10.0
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == popularMovieCollectionView){
            movieDetailText = popularMoviesModel.search?[indexPath.row].imdbID ?? "tt0499549"
        }else{
            movieDetailText = trendingNowModel.search?[indexPath.row].imdbID ?? "tt0499549"
        }
        
        performSegue(withIdentifier: "movieDetailWithHome", sender: nil)
    }
    
    
    func fetchCurrentMovies(popular: String, trendingNow: String){
         omdbService.fetchMovies(completion: { moviesModel in
            self.popularMoviesModel = moviesModel
             self.refresh()
         }, search: popular, page: 1)
        
        omdbService.fetchMovies(completion: { moviesModel in
            self.trendingNowModel = moviesModel
            self.refresh()
        }, search: trendingNow, page: 1)
        
    }
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        if(searchBar.text?.count ?? 0 > 2){
            searchText = searchBar.text!
            performSegue(withIdentifier: "searchResult", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchResult"{
            let destinationVC = segue.destination as! SearchMovieTableViewController
            destinationVC.search = searchText
        }
        if segue.identifier == "movieDetailWithHome"{
            let destinationVC = segue.destination as! MovieDetailViewController
            destinationVC.imdb = movieDetailText
        }     
    }
}
