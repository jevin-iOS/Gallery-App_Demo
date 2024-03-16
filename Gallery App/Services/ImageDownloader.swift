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

        let sanitizedFilename = urlString.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
        
        if let cachedImage = loadImageFromCache(filename: sanitizedFilename) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                saveImageToCache(image: image, filename: sanitizedFilename)
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    // MARK: - Caching Methods
    
    private static func loadImageFromCache(filename: String) -> UIImage? {
        if let cacheDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
    
            let fileURL = cacheDirectoryURL.appendingPathComponent(filename)
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
                    return image
                }
            }
        }
        return nil
    }
    
    private static func saveImageToCache(image: UIImage, filename: String) {

        if let cacheDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
    
            let fileURL = cacheDirectoryURL.appendingPathComponent(filename)
            
            if let imageData = image.pngData() {
                do {
                    try imageData.write(to: fileURL)
                } catch {
                    print("Error saving image to cache: \(error)")
                }
            }
        }
    }
}
