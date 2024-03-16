//
//  ListViewCell.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var ImgSelectedImage: UIImageView!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblDates: UILabel!
    
    var photosDetails: PhotosDetails? {
        didSet {
            lblDiscription.text = photosDetails?.altDescription ?? ""
            lblLikes.text = "\(photosDetails?.likes ?? 0)"
            lblDates.text = photosDetails?.createdAt ?? ""
            
            if let urlStr = photosDetails?.urls.regular {
                downloadData(url: urlStr)
            }
            print("")
        }
    }
    
    
    func downloadData(url: String) {
        
        DispatchQueue.global(qos: .background).async {
            ImageDownloader.downloadImage(from: url) { image in
                DispatchQueue.main.async { [self] in
                    imgBackground.image = image ?? UIImage()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
