//
//  LoginService.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 18/11/23.
//

import Foundation

/// Enables the consumption of the LoginTest API from RapidApi and defines each of its required requests per function.
class APILogin {
    // MARK: Properties and constants
    /// APIClient instance for service consumption and general validations
    private let apiClient = APIClient()
    /// Defines the END-POINT for all web services
    private let END_POINT_API = "https://logintesting.p.rapidapi.com/"
    /// Defines HEADERS for all web services
    private var headers: [String : String] = [
        "content-type": "application/json",
        "Authentication": "HI",
        "X-RapidAPI-Key": "582de0c4demsh642394a9b710ec7p1dd672jsn9464f91df962",
        "X-RapidAPI-Host": "logintesting.p.rapidapi.com"
    ]
    
    // MARK: API Login Test Requests
    /// Handles the login service exclusively, taking needed details to build the request body. Sets the request method and uses global headers for API access.
    /// - Parameter email: User's email for the session query in the request body.
    /// - Parameter password: User's password for the session query in the request body.
    /// - Parameter completion: Closure designed to simplify displaying the query result in the UI, showing success or failure.
    func getServiceLogin(email: String, password: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        if let url = URL(string: "\(END_POINT_API)login") {
            let loginRequest = LoginRequest(username: email, password: password)
            
            do {
                let jsonData = try JSONEncoder().encode(loginRequest)
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                request.httpBody = jsonData
                
                apiClient.executeService(request: HTTPRequest(url: url, method: .POST, body: jsonData, headers: headers)) { result in
                    switch result {
                    case .success(let data):
                        do {
                            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                            completion(.success(loginResponse))
                        } catch {
                            completion(.failure(.invalidData))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } catch {
                completion(.failure(.invalidData))
            }
        } else {
            completion(.failure(.invalidURL))
        }
    }
}
