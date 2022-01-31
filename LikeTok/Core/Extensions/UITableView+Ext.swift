//
//  UITableView+Ext.swift
//  LikeTok
//
//  Created by Daniel on 23.01.22.
//

import UIKit

extension UITableView {
    func register(nibOfClass: AnyClass) {
        let name = String(describing: nibOfClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellReuseIdentifier: name)
    }
    
    func register(cellClass: AnyClass) {
        let name = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: name)
    }
}
