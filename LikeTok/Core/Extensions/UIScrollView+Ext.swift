//
//  UIScrollView+Ext.swift
//  LikeTok
//
//  Created by Daniel on 10.02.22.
//

import UIKit.UIScrollView

extension UIScrollView {
    
    var isScrolling: Bool {
        return isDragging && !isDecelerating || isTracking
    }
}
