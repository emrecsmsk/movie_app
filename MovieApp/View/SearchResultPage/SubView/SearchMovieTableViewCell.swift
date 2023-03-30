//
//  SearchMovieTableViewCell.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 1.03.2023.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var searchMovieName: UILabel!
    @IBOutlet weak var searchMovieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchMovieImage.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
