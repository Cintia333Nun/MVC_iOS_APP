//
//  MovieTableViewCell.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 16/12/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    private let imageCacheManager = ImageCacheManager.shared
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var backgroundShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ data: MovieModel) {
        backgroundShadow.layer.shadowColor = UIColor.black.cgColor
        backgroundShadow.layer.shadowOpacity = 0.2
        backgroundShadow.layer.shadowOffset = CGSize(width: 2, height: 2)
        backgroundShadow.layer.shadowRadius = 5
        
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        titleMovieLabel.text = "\(data.title ?? "No data")\n"
        loadImage(data)
    }
    
    private func loadImage(_ data: MovieModel) {
        if let url = data.urlImage {
            if imageCacheManager.imageExistsInCache(forKey: url) {
                movieImageView.image = imageCacheManager.loadImageFromCache(forKey: url)
            } else {
                APIMovie().getImageFromUrlOrDefault(url) { result in
                    switch result {
                    case .success(let image):
                        self.addAndRefreshElement(url, image)
                    case .failure(let error):
                        self.addErrorElement(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func addAndRefreshElement(_ url: String, _ image: UIImage) {
        if(imageCacheManager.imageExistsInCache(forKey: url)) {
            movieImageView.image = imageCacheManager.loadImageFromCache(forKey: url)
        } else {
            imageCacheManager.cacheImage(image, forKey: url)
            movieImageView.image = image
        }
    }
    
    private func addErrorElement(_ error: String) {
        print("Ocurrio un error \(error)")
        movieImageView.image = UIImage(named: "movie")
    }
}
