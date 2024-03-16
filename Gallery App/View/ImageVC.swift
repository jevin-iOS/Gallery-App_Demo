//
//  ImageVC.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit

class ImageVC: UIViewController {
    
    var titleLabel: UILabel?
    
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

        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        titleLabel?.center = CGPoint(x: 160, y: 250)
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.text = photosDetails.altDescription 
        self.view.addSubview(titleLabel!)
    }
}
