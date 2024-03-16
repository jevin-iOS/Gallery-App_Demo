//
//  PhotosCollectionDataSource.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit

class PhotosCollectionDataSource<Cell: UICollectionViewCell, T>: NSObject, UICollectionViewDataSource {
    
    private var cellIdentifier: String?
    private var items: [T]?
    var configureCell: ((Cell, T) -> ())?
    
    init(cellIdentifier: String?, items: [T]?, configureCell: @escaping ((Cell, T) -> Void)) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier ?? "", for: indexPath) as? Cell, let item = items?[indexPath.row] {
            configureCell?(collectionCell, item)
            return collectionCell
        }
      
        return UICollectionViewCell()
    }
}
