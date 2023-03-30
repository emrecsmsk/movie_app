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
    
    
    var searchText = String()
    var movieDetailText = String()
    let search = UISearchController(searchResultsController: nil)
    var viewModel = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar()
        
        if(ConnectivityControl.isConnectedToInternet != true){
            performSegue(withIdentifier: "noInternetConnection", sender: nil)
            
        }
        initObservers()
        
        
        moviesActivityIndicatorView.startAnimating()
        
        viewModel.fetchCurrentMovies(popular: "avengers", trendingNow: "avatar")
        
    }
    
    
    func refresh() {
        DispatchQueue.main.async {
            self.popularMovieCollectionView.reloadData()
            self.trendingNowCollectionView.reloadData()
            self.popularMovieLabel.isHidden = false
            self.trendingNowLabel.isHidden = false
            self.popularMovieCollectionView.isHidden = false
            self.trendingNowCollectionView.isHidden = false
            self.moviesActivityIndicatorView.isHidden = true
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == popularMovieCollectionView){
            return viewModel.popularMoviesModel.value?.search?.count ?? 0
        }else{
            return viewModel.trendingNowModel.value?.search?.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == popularMovieCollectionView){
            let cell = popularMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "popularMovieCell", for: indexPath) as! PopularMovieCollectionViewCell
            
            let url =  URL(string: viewModel.popularMoviesModel.value?.search?[indexPath.row].poster ?? "")
            
            cell.popularMovieImage.kf.setImage(with: url)
            
            cell.popularMovieImage.layer.cornerRadius = 10.0
            
            return cell
        }else{
            let cell = trendingNowCollectionView.dequeueReusableCell(withReuseIdentifier: "trendingNowCell", for: indexPath) as! TrendingNowCollectionViewCell
            
            let url =  URL(string: viewModel.trendingNowModel.value?.search?[indexPath.row].poster ?? "")
            
            cell.trendingNowImage.kf.setImage(with: url)
            
            cell.trendingNowImage.layer.cornerRadius = 10.0
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == popularMovieCollectionView){
            movieDetailText = viewModel.popularMoviesModel.value?.search?[indexPath.row].imdbID ?? "tt0499549"
        }else{
            movieDetailText = viewModel.trendingNowModel.value?.search?[indexPath.row].imdbID ?? "tt0499549"
        }
        
        performSegue(withIdentifier: "movieDetailWithHome", sender: nil)
    }
    
    func searchBar(){
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
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
    
    private func initObservers() {
        viewModel.popularMoviesModel.bind { movie in
            self.refresh()
            
        }
        viewModel.trendingNowModel.bind { movie in
            self.refresh()
        }
    }
}
