//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 1.03.2023.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieDetailLabel: UILabel!
    
    @IBOutlet weak var moviePlotLabel: UILabel!
    
    @IBOutlet weak var moviesActivityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var actor1Label: UILabel!
    
    @IBOutlet weak var actor2Label: UILabel!
    
    @IBOutlet weak var actor3Label: UILabel!
    
    @IBOutlet weak var actor1Image: UIImageView!
    
    @IBOutlet weak var actor2Image: UIImageView!
    
    @IBOutlet weak var actor3Image: UIImageView!
    
    var viewModel = MovieDetailViewModel()
    
    var imdb = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchMovieDetail(imdb: imdb)
        initObservers()
        moviesActivityIndicatorView.startAnimating()
    }
    
    func refresh(){
        
        DispatchQueue.main.async {
            let url = URL(string: (self.viewModel.movieDetailModel.value?.poster)!)
            
            self.movieImage.kf.setImage(with: url)
            self.movieNameLabel.text = self.viewModel.movieDetailModel.value?.title
            self.movieDetailLabel.text = "\((self.viewModel.movieDetailModel.value?.year) ?? "2000")  | \((self.viewModel.movieDetailModel.value?.runtime) ?? "140min") | \((self.viewModel.movieDetailModel.value?.genre) ?? "")"
            self.moviePlotLabel.text = self.viewModel.movieDetailModel.value?.plot
            
            self.moviesActivityIndicatorView.isHidden = true
            self.movieImage.isHidden = false
            self.movieNameLabel.isHidden = false
            self.movieDetailLabel.isHidden = false
            self.moviePlotLabel.isHidden = false
            self.actor1Label.isHidden = false
            self.actor2Label.isHidden = false
            self.actor3Label.isHidden = false
            self.actor1Image.isHidden = false
            self.actor2Image.isHidden = false
            self.actor3Image.isHidden = false
            
            let actorList = self.viewModel.movieDetailModel.value?.actors.split(separator: ",")
            if (actorList?.count ?? 0)>=3 {
                self.actor1Label.text = String(actorList?[0] ?? "NO ACTOR")
                self.actor2Label.text = String(actorList?[1] ?? "NO ACTOR")
                self.actor3Label.text = String(actorList?[2] ?? "NO ACTOR")
            }else if (actorList?.count ?? 0)>=2{
                self.actor1Label.text = String(actorList?[0] ?? "NO ACTOR")
                self.actor2Label.text = String(actorList?[1] ?? "NO ACTOR")
                self.actor3Label.text = "NO ACTOR"
            }else if (actorList?.count ?? 0)>=1{
                self.actor1Label.text = String(actorList?[0] ?? "NO ACTOR")
                self.actor2Label.text = "NO ACTOR"
                self.actor3Label.text = "NO ACTOR"
            }else {
                self.actor1Label.text = "NO ACTOR"
                self.actor2Label.text = "NO ACTOR"
                self.actor3Label.text = "NO ACTOR"
            }
        }
        
        
        
    }
    
    private func initObservers() {
        viewModel.movieDetailModel.bind { movie in
            self.refresh()
            
        }
    }
    
}


