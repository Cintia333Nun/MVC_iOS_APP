//
//  APIMovie.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 01/01/24.
//

import Foundation
import UIKit

struct MoviesResponse: Codable {
    let page: Int
    let next: String
    let entries: Int
    let results: Array<ResultsMovies>
    
    struct ResultsMovies: Codable {
        let _id: String
        let id: String
        let primaryImage: PrimaryImage?
        let titleType: DataResponse
        let titleText: DataResponse?
        let originalTitleText: DataResponse?
        let releaseYear: DataResponse?
        let releaseDate: DataResponse?
        
        struct PrimaryImage: Codable {
            let id: String?
            let url: String?
        }
        
        struct DataResponse: Codable {
            //MARK: TitleType, TitleText
            let text: String?
            let id: String?
            let isSeries: Bool?
            let isEpisode: Bool?
            //MARK: ReleaseYear, ReleaseDate
            let year: Int?
            let endYear: Int?
            let day: Int?
            let month: Int?
        }
    }
}

class APIMovie {
    // MARK: Properties and constants
    /// APIClient instance for service consumption and general validations
    private let apiClient = APIClient()
    /// Defines the END-POINT for all web services
    private let END_POINT_API = "https://moviesdatabase.p.rapidapi.com/"
    /// Defines HEADERS for all web services
    private var headers: [String : String] = [
        "X-RapidAPI-Key": "582de0c4demsh642394a9b710ec7p1dd672jsn9464f91df962",
        "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
    ]
    
    func getMovies(completion: @escaping (Result<Array<MovieModel>, APIError>) -> Void) {
        if let url = URL(string: "\(END_POINT_API)titles") {
            apiClient.executeService(request: HTTPRequest(url: url, method: .GET, body: nil, headers: headers)) { result in
                DispatchQueue.main.sync {
                    switch result {
                    case .success(let data):
                        do {
                            let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                            print("Movies response: \(moviesResponse)")
                            let arrayMovies = moviesResponse.results.map { data in
                                MovieModel(
                                    urlImage: data.primaryImage?.url, title: data.titleText?.text,
                                    titleType: data.titleType.text, titleOriginal: data.originalTitleText?.text,
                                    image: nil,
                                    releaseYear: String(data.releaseYear?.year ?? 0),
                                    releaseDate: self.getReleaseDate(data.releaseDate)
                                )
                            }
                            completion(.success(arrayMovies))
                        } catch {
                            completion(.failure(.invalidResponse))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } else {
            completion(.failure(.invalidURL))
        }
    }
    
    private func getReleaseDate(_ releaseDate: MoviesResponse.ResultsMovies.DataResponse?) -> String {
        if let releaseDate = releaseDate {
            return "\(releaseDate.year ?? 0)/\(releaseDate.month ?? 0)/\(releaseDate.day ?? 0)"
        } else {
            return "No data"
        }
    }
    
    func getImageFromUrlOrDefault(_ url: String, completion: @escaping (Result<UIImage, APIError>) -> Void) {
        if let url = URL(string: url) {
            apiClient.executeService(request: HTTPRequest(url: url, method: .GET, body: nil, headers: nil)) { result in
                DispatchQueue.main.sync {
                    switch result {
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            completion(.success(image))
                        } else {
                            completion(.failure(.invalidData))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        } else {
            completion(.failure(.invalidURL))
        }
    }
}
