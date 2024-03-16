//
//  PhotosTableDataSource.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit

class PhotosTableDataSource<Cell: UITableViewCell, T>: NSObject, UITableViewDataSource {
    
    private var cellIdentifier: String?
    private var items: [T]?
    var configureCell: ((Cell, T)->())?
    
    init(cellIdentifier: String?, items: [T]?, configureCell: @escaping ((Cell, T) -> Void)) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ?? "") as? Cell, let item = items?[indexPath.row] {
            configureCell?(tableCell, item)
            tableCell.layer.cornerRadius = 10
            tableCell.layer.masksToBounds = true
            tableCell.layer.shadowColor = UIColor.black.cgColor
            tableCell.layer.shadowOffset = CGSize(width: 0, height: 2)
            tableCell.layer.shadowRadius = 3
            tableCell.layer.shadowOpacity = 0.3
            return tableCell
        }
      
        return UITableViewCell()
    }
}
