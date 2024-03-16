//
//  Extension.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit


extension UIViewController {
    
    func displayAlert(title alertTitle: String, message alertMessage: String) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true)
    }
    
    func getViewController<T: UIViewController>(type: T.Type) -> T? {
        
        let identifier = String(describing: T.self)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as? T
        return viewController
    }
}
