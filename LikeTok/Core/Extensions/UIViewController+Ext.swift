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
        
    func showToast(_ title: String, toastType: ToastType) {
        Toast.Builder()
            .backgroundColor(.systemGray6)
            .textColor(.black)
            .showLeftIcon(toastType == .successed ? Assets.checkIcon.image : Assets.dismissSubstract24.image)
            .cornerRadius(10)
            .title(title)
            .orientation(.bottomToTop)
            .build()
            .show(on: self)
    }
}

public enum ToastType {
    case successed
    case failured
}
