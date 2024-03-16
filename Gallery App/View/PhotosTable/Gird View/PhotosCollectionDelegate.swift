//
//  PhotosCollectionDelegate.swift
//  Gallery App
//
//  Created by jevin kamani on 16/03/24.
//

import Foundation
import UIKit


class PhotosCollectionDelegate<T>: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var didSelectItem: ((T?, IndexPath) -> Void) = { _, _ in }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = collectionView.cellForItem(at: indexPath) as? GridViewCell
        didSelectItem(item?.photosDetails as? T, indexPath)
    }
    
    // MARK: - Manage Cell Size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let gridCount = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
        let spacing: CGFloat = 0
        var totalSpacing = (CGFloat(gridCount) * spacing) + 20.0

            let availableWidth = collectionView.frame.width - totalSpacing
            let widthPerItem = availableWidth / CGFloat(gridCount)

        return CGSize(width: widthPerItem, height: widthPerItem * 1.25)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

