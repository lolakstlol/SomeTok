//
//  UICollectionView+Ext.swift
//  LikeTok
//
//  Created by Daniel on 7.11.21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(nibOfClass: AnyClass) {
        let name = String(describing: nibOfClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: name)
    }
    
    func register(cellClass: AnyClass) {
        let name = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: name)
    }
    
    func register(nibOfClass: AnyClass, kind: String) {
        let name = String(describing: nibOfClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
    }
}
