//
//  UICollectionCell + Extension.swift
//  Heart
//
//  Created by Александр Александрович on 29.07.2022.
//

import UIKit

extension UICollectionViewCell {
    class func registerWithoutNib(`for` collectionView: UICollectionView) {
        collectionView.register(self.self, forCellWithReuseIdentifier: self.reuseID)
    }

    class func dequeue(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return unsafeDowncast(collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseID, for: indexPath), to: self)
    }
}

extension UICollectionReusableView {
    class func registerWithoutNib(`for` collectionView: UICollectionView, forSupplementaryViewOfKind kind: String) {
        collectionView.register(self, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.reuseID)
    }

    class func dequeue(_ collectionView: UICollectionView, ofKind kind: String, for indexPath: IndexPath) -> Self {
        return unsafeDowncast(collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.reuseID, for: indexPath), to: self)
    }
    
    class var reuseID: String {
        return stringName
    }
    
    fileprivate class var stringName: String {
        return String(describing: self.self)
    }
}

