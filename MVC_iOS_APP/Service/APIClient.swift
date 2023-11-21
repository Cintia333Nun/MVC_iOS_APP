//
//  APIClient.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 18/11/23.
//

import Foundation

// MARK: MODELS FOR APIClient
/// Define methods available for consuming services.
enum HTTPMethod: String {
    case GET
    case POST
}

/// Customizable elements within the generic consumption of a service.
struct HTTPRequest {
    let url: URL
    let method: HTTPMethod
    let body: Data?
    let headers: [String: String]?
}

/// Types of generic errors when execute service.
enum APIError: Error {
    case invalidURL 
    case requestFailed(Error)
    case invalidResponse
    case invalidData
}

// MARK: API Client Class
/// Class intended for the GENERIC consumption of a service.
class APIClient {
    // MARK: API Client properties & Constructor
    /// Existing instance of URLSession.
    private let session: URLSession
    
    /// Initialize the URL session.
    init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    // MARK: Generic Service Consume
    /// This function is for using a service in a general way. It checks common issues during the usage process, like errors, failed responses, wrong status codes, or incorrect data. It saves time by not repeating these checks and focuses on validating response details where this function is applied, using the completion closure.
    /// - Parameter request: Provide the request details like URL, method, body, and necessary headers for the API or request.
    /// - Parameter completion: Its role is to handle GENERIC incorrect responses during the general service usage checks. It allows for specific API validations using expected data for usage.
    func executeService(request: HTTPRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(responseData))
        }
        
        task.resume()
    }
}
