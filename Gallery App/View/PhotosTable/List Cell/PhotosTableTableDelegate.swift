//
//  photosTableTableDelegate.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit

class PhotosTableTableDelegate<T>: NSObject, UITableViewDelegate {
    
    var didSelectedRow: ((T?, IndexPath)->()) = {_,_  in}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let tableCell = tableView.cellForRow(at: indexPath) as? ListViewCell {
            didSelectedRow(tableCell.photosDetails as? T, indexPath)
        }
    }
}
