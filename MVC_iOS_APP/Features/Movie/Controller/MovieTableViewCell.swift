//
//  MovieTableViewCell.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 16/12/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var backgroundShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ title: String, _ image: UIImage?) {
        backgroundShadow.layer.shadowColor = UIColor.black.cgColor
        backgroundShadow.layer.shadowOpacity = 0.2
        backgroundShadow.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundShadow.layer.shadowRadius = 5
        
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        movieImageView.image = image ?? UIImage(named: "movie")
        titleMovieLabel.text = "\(title)\n"
    }
}
