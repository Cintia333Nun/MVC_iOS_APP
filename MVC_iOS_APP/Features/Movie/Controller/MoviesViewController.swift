//
//  MoviesViewController.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 16/12/23.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    //private var arrayMovies = [MovieModel]()
    private var arrayMovies = [
        MovieModel(
            urlImage: nil, title: "Test 1", titleType: nil,
            titleOriginal: nil, image: nil, releaseYear: nil, releaseDate: nil
        ),
        MovieModel(
            urlImage: nil, title: "Test 2", titleType: nil,
            titleOriginal: nil, image: nil, releaseYear: nil, releaseDate: nil
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell_movie")
        moviesTableView.allowsSelection = true
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func goToMovieData(data: MovieModel) {
        let dataMovieViewController = DataMovieViewController(data: data)
        dataMovieViewController.modalPresentationStyle = .fullScreen
        dataMovieViewController.isModalInPresentation = true
        present(dataMovieViewController, animated: true)
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_movie", for: indexPath) as! MovieTableViewCell
        let dataMovie = arrayMovies[indexPath.row]
        let noData = "Data not available"
        cell.isUserInteractionEnabled = true
        cell.configure(dataMovie.title ?? noData, dataMovie.image)
        return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToMovieData(data: arrayMovies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

