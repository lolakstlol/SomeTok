//
//  UIImage+Ext.swift
//  LikeTok
//
//  Created by Daniel on 6.02.22.
//

import UIKit.UIImage

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
