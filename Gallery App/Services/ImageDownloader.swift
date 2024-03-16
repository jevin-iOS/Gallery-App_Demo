//
//  ImageDownloader.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit

struct ImageDownloader {
    
    static func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                // Handle error scenario
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
}
