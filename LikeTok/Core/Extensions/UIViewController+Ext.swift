//
//  UIViewController+Ext.swift
//  LikeTok
//
//  Created by Daniel on 4.12.21.
//

import Foundation
import UIKit
import CustomToastView_swift

extension UIViewController {
        
    func showToast(_ title: String, leftImage: UIImage) {
        Toast.Builder()
            .backgroundColor(.white)
            .textColor(.black)
            .showLeftIcon(leftImage)
            .cornerRadius(10)
            .title(title)
            .orientation(.bottomToTop)
            .timeDismissal(4)
            .build()
            .show(on: self)
    }
}
