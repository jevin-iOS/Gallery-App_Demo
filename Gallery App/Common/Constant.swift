//
//  Constant.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation


let CLIENT_ID = "HE1T-JUJKlKvbvFWZsG9FEU174OqHaicmEXQ7ZWDapM"


enum StaticErrorMessages: String {
    case title = "Opps!"
    case message = "Something went wrong."
    
    var stringValue: String {
        return self.rawValue
    }
}
