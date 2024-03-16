//
//  LoginVC.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var txtPassword: RoundRectTextField!
    @IBOutlet var txtLogin: RoundRectTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let loginDetails = LoginResource.shared.getLogin()
        if let userName = loginDetails.username, let password = loginDetails.password {
            txtLogin.text = userName
            txtPassword.text = password
            
        }
    }
    
    @IBAction func loginBtnTouch(_ sender: UIButton) {
        
        let loginValidation = LoginValidation()
        let loginRequest = LoginRequest(username: txtLogin.text ?? "", Password: txtPassword.text ?? "")
        let loginResult = loginValidation.validateLoginDetails(request: loginRequest)
        
        if let response = loginResult.response {
            self.displayAlert(title: response.title, message: response.message)
        } else if loginResult.isValidate ?? false {
            LoginResource.shared.saveLogin(username: txtLogin.text ?? "" , password: txtPassword.text ?? "")
            
            guard let photosVC = self.getViewController(type: PhotosVC.self) else { return }
            self.navigationController?.pushViewController(photosVC, animated: true)
        }
        
    }
    
}
