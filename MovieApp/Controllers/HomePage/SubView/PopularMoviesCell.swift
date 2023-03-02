//
//  PopularMoviesCell.swift
//  MovieApp
//
//  Created by Emre Can Şimşek on 28.02.2023.
//

import UIKit

class PopularMoviesCell: UITableViewCell {
    
    @IBOutlet weak var deneme: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
