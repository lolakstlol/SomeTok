//
//  PanNavigationController.swift
//  LikeTok
//
//  Created by Daniel on 7.03.22.
//

import Foundation
import PanModal
import UIKit

class PanNavigationController: UINavigationController, PanModalPresentable {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        panModalSetNeedsLayoutUpdate()
        return vc
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        panModalSetNeedsLayoutUpdate()
    }

    // MARK: - Pan Modal Presentable
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var panModalBackgroundColor: UIColor {
        return .clear
    }
}
