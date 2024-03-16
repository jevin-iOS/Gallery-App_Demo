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
    var animatedCell: [IndexPath] = []

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let tableCell = tableView.cellForRow(at: indexPath) as? ListViewCell {
            didSelectedRow(tableCell.photosDetails as? T, indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !animatedCell.contains(indexPath) {
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.row) * 0.1, options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            animatedCell.append(indexPath)
        }
    }
}
