//
//  User.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 17/11/23.
//

import Foundation
struct User {
    let name: String
    let email: String
    let password: String
    let phone: String
}

// MARK: LOGIN SERVICE MODELS
struct LoginRequest: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let isSuccess: Bool
    let status: Int
    let message: String
    let data: UserData
    
    struct UserData: Codable {
        let username: String
        let accessToken: String
    }
}
