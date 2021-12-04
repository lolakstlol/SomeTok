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
        
    func showToast(_ text: String) {
        Toast.Builder()
            .showLeftIcon(Assets.avatarDefaulth.image)
            .cornerRadius(7)
            .title("Я ДАЛБАЕБ")
            .orientation(.bottomToTop)
            .timeDismissal(4)
            .build()
            .show(on: self)
    }
}
