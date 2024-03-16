//
//  LoginValidation.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation


struct LoginValidation {
    
    
    func validateLoginDetails(request: LoginRequest) -> (isValidate: Bool?, response: LoginValidationResponse?)  {
            
        if request.username.count == 0, request.Password.count == 0 {
            return (false, LoginValidationResponse(title: StaticErrorMessages.title.stringValue, message: "Username and password should not nil."))
        } else if request.username.count > 0, request.Password.count == 0 {
            return (false, LoginValidationResponse(title: StaticErrorMessages.title.stringValue, message: "Password should not nil."))
        } else if request.username.count == 0, request.Password.count > 0 {
            return (false, LoginValidationResponse(title: StaticErrorMessages.title.stringValue, message: "Username should not nil."))
        } else if request.username.count < 4, request.Password.count < 4 {
            return (false, LoginValidationResponse(title: StaticErrorMessages.title.stringValue, message: "Username and password text should more then 3 charcter."))
        }
        return (true, nil)
    }
}
