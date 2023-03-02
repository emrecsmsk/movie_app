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
        let url = URL(string: movieDetailModel.poster)
                
        movieImage.kf.setImage(with: url)
        movieNameLabel.text = movieDetailModel.title
        movieDetailLabel.text = "\(movieDetailModel.year) | \(movieDetailModel.runtime) | \(movieDetailModel.genre)"
        moviePlotLabel.text = movieDetailModel.plot
        
        moviesActivityIndicatorView.isHidden = true
        movieImage.isHidden = false
        movieNameLabel.isHidden = false
        movieDetailLabel.isHidden = false
        moviePlotLabel.isHidden = false
        actor1Label.isHidden = false
        actor2Label.isHidden = false
        actor3Label.isHidden = false
        actor1Image.isHidden = false
        actor2Image.isHidden = false
        actor3Image.isHidden = false
        
        var actorList = movieDetailModel.actors.split(separator: ",")
        if(actorList.count>=3){
            actor1Label.text = String(actorList[0])
            actor2Label.text = String(actorList[1])
            actor3Label.text = String(actorList[2])
        }else if actorList.count>=2{
            actor1Label.text = String(actorList[0])
            actor2Label.text = String(actorList[1])
            actor3Label.text = "NO ACTOR"
        }else if actorList.count>=1{
            actor1Label.text = String(actorList[0])
            actor2Label.text = "NO ACTOR"
            actor3Label.text = "NO ACTOR"
        }else {
            actor1Label.text = "NO ACTOR"
            actor2Label.text = "NO ACTOR"
            actor3Label.text = "NO ACTOR"
        }
        }
        
    }


