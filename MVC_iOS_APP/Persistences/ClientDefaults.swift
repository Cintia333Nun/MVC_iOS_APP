//
//  ClientDefaults.swift
//  MVC_iOS_APP
//
//  Created by CinNun on 03/12/23.
//

import Foundation

/// Se definiran los defaults que se almacenaran para los clientes
/// Se agrega la palabra recervada final para evitar que otros programadores hereden de esta clase
final class ClientDefaults {
    /// Se esta creando un Singleton
    private let userKey =  "KEY_USER"
    private let tokenKey =  "KEY_TOKEN"
    static var shared: ClientDefaults {
        return ClientDefaults()
    }
    private let userDefaults = UserDefaults.standard
    
    public var getUserName: String {
        return decryptInfo(with: userDefaults.string(forKey: userKey) ?? "")
    }
    
    public var getToken: String {
        return decryptInfo(with: userDefaults.string(forKey: tokenKey) ?? "")
    }
    
    private init() {}
    
    public func setUserName(with userName: String) {
        if let data = encryptInfo(with: userName) {
            userDefaults.setValue(data, forKey: userKey)
        }
    }
    
    public func setAccessToken(with accessToken: String) {
        if let data = encryptInfo(with: accessToken) {
            userDefaults.setValue(data, forKey: tokenKey)
        }
    }
    
    // Se usa para cifrar en bancos AES-28 investigar
    private func encryptInfo(with value: String) -> String? {
        let data = value.data(using: .utf8)
        let valueEncrypted = data?.base64EncodedString()
        return valueEncrypted
    }
    
    private func decryptInfo(with value: String?) -> String {
        guard let valueEncryted = value,
              let data = Data(base64Encoded: valueEncryted),
              let valueDecrypted = String(data: data, encoding: .utf8) else { return "" }
        return valueDecrypted
    }
}
