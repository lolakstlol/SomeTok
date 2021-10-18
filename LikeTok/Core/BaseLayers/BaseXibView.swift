//
//  BaseXibView.swift
//  magnit-ios
//
//  Created by Dmitry Kosyakov on 26.08.2020.
//  Copyright © 2020 BSL.dev. All rights reserved.
//

import UIKit.UIView

class XibBasedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        guard let contentView = Bundle.main.loadNibNamed(String (describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return }
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupUI()
    }
    
    func setupUI() {}
}
