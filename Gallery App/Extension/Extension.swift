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

extension UIImage {

    func resized(withTargetSize targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        self.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage ?? self
    }
}
