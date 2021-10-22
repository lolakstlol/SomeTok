//
//  InsetTextField.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 22.10.21.
//

import Foundation
import UIKit

@IBDesignable
class InsetTextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}


