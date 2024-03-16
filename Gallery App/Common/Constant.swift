//
//  Constant.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation


// MARK: - Constant

let CLIENT_ID = "HE1T-JUJKlKvbvFWZsG9FEU174OqHaicmEXQ7ZWDapM"


// MARK: - StaticErrorMessages

enum StaticErrorMessages: String {
    case title = "Opps!"
    case message = "Something went wrong."
    
    var stringValue: String {
        return self.rawValue
    }
}


// MARK: - KeychainKeys

enum KeychainKeys: String {
    case username = "userName"
    case password = "Password"
    
    var stringValue: String {
        return self.rawValue
    }
}
