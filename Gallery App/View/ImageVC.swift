//
//  ImageVC.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit

class ImageVC: UIViewController {
    
    var imageView: UIImageView?
    
    var photosDetails: PhotosDetails
    
    init(with photosDetails: PhotosDetails) {
        self.photosDetails = photosDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width - 40.0, height: self.view.frame.height - 40.0))
        imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(imageView!)
        self.downloadData(url: photosDetails.urls.regular, name: photosDetails.id)
    }
    
    func downloadData(url: String, name: String) {
        
        DispatchQueue.global(qos: .background).async {
            ImageDownloader.downloadImage(from: url) { image in
                DispatchQueue.main.async { [self] in
                    imageView?.image = image
                }
            }
        }
    }
}
