//
//  MoviesViewController.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 16/12/23.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    private var arrayMovies = [MovieModel]() {
        didSet {
            moviesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadMovies()
    }
    
    private func configTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell_movie")
        moviesTableView.allowsSelection = true
    }
    
    private func loadMovies() {
        APIMovie().getMovies() { result in
            switch result {
            case .success(let data):
                self.refreshMovies(newArray: data)
            case .failure(let error):
                print("Ha ocurrido un error: \(error)")
            }
        }
    }
    
    private func refreshMovies(newArray: Array<MovieModel>) {
        arrayMovies.removeAll()
        arrayMovies.append(contentsOf: newArray)
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
        cell.configure(dataMovie)
        return cell
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToMovieData(data: arrayMovies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

