//
//  LoginResource.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import KeychainSwift

class LoginResource {

    static let shared = LoginResource()
    private let keychain = KeychainSwift()

    private init() {}

    func saveLogin(username: String, password: String) {
        keychain.set(username, forKey: KeychainKeys.username.stringValue)
        keychain.set(password, forKey:  KeychainKeys.password.stringValue)
    }

    func getLogin() -> (username: String?, password: String?) {
        let username = keychain.get( KeychainKeys.username.stringValue)
        let password = keychain.get( KeychainKeys.password.stringValue)
        return (username, password)
    }
}
