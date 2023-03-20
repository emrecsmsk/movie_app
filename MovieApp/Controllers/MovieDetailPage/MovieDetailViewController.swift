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
    
    var imdb = String()
    var movieDetailModel = MovieDetailModel(title: "", year: "", runtime: "", genre: "", plot: "", actors: "", poster: "", imdbRating: "")
    let omdbService = OmdbService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesActivityIndicatorView.startAnimating()
        fetchMovieDetail(imdb: imdb)
    }
    

    func fetchMovieDetail(imdb: String){
        omdbService.fetchMovieDetail(completion: { movieDetailModel in
            self.movieDetailModel = movieDetailModel
            self.refresh()
        }, imdb: imdb)
    }
    
    @IBAction func refresh(){
        
        
        DispatchQueue.main.async {
            let url = URL(string: self.movieDetailModel.poster)
                    
            self.movieImage.kf.setImage(with: url)
            self.movieNameLabel.text = self.movieDetailModel.title
            self.movieDetailLabel.text = "\(self.movieDetailModel.year) | \(self.movieDetailModel.runtime) | \(self.movieDetailModel.genre)"
            self.moviePlotLabel.text = self.movieDetailModel.plot
            
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
            
            let actorList = self.movieDetailModel.actors.split(separator: ",")
            if(actorList.count>=3){
                self.actor1Label.text = String(actorList[0])
                self.actor2Label.text = String(actorList[1])
                self.actor3Label.text = String(actorList[2])
            }else if actorList.count>=2{
                self.actor1Label.text = String(actorList[0])
                self.actor2Label.text = String(actorList[1])
                self.actor3Label.text = "NO ACTOR"
            }else if actorList.count>=1{
                self.actor1Label.text = String(actorList[0])
                self.actor2Label.text = "NO ACTOR"
                self.actor3Label.text = "NO ACTOR"
            }else {
                self.actor1Label.text = "NO ACTOR"
                self.actor2Label.text = "NO ACTOR"
                self.actor3Label.text = "NO ACTOR"
            }
            }
        }
        
        
        
       
        
    }


