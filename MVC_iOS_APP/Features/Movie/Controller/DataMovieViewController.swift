//
//  DataMovieViewController.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 17/12/23.
//

import UIKit

class DataMovieViewController: UIViewController {
    private let data: MovieModel
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orignalTitleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var shadowBackground: UIView!
    
    init(data: MovieModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("data: MovieModel. has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let noData = "Data not available"
        image.image = data.image ?? UIImage(named: "movie")
        titleLabel.text = data.title ?? noData
        orignalTitleLabel.text = data.titleOriginal ?? noData
        titleTypeLabel.text = data.titleType ?? noData
        dateLabel.text = data.releaseDate ?? noData
        yearLabel.text = data.releaseYear ?? noData
        
        shadowBackground.layer.shadowColor = UIColor.black.cgColor
        shadowBackground.layer.shadowOpacity = 0.2
        shadowBackground.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowBackground.layer.shadowRadius = 5
    }

    @IBAction func buttonBack(_ sender: Any) {
        dismiss(animated: true)
    }
}
