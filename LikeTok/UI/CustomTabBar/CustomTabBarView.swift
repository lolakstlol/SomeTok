//
//  CustomTabBarView.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 26.10.21.
//

import UIKit

final class CustomTabBarView: UIView {
    weak var delegate: CustomTabBarDelegate?
    
    var items: [UITabBarItem] = [] {
        didSet { reloadViews() }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.cornerRadius = 20
        
        return blurEffectView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else {
            super.touchesEnded(touches, with: event)
            return
        }

        let buttons = self.stackView.arrangedSubviews.compactMap { $0 as? CustomTabBarItemView }.filter { !$0.isHidden }
        let distances = buttons.map { $0.center.distance(to: position) }

        let buttonsDistances = zip(buttons, distances)

        if let closestButton = buttonsDistances.min(by: { $0.1 < $1.1 }) {
            buttonTapped(sender: closestButton.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        layer.cornerRadius = 20
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(blurView)
        addSubview(stackView)
        
        self.backgroundColor = .clear
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.15
        
        tintColorDidChange()
    }
    
    private func addButton(with image: UIImage, unselectedImage: UIImage) {
        let button = CustomTabBarItemView(image: image, selected: unselectedImage)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(sender:)))
        gesture.numberOfTapsRequired = 1
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(gesture)
        self.stackView.addArrangedSubview(button)
    }
    
    private func updateAppearance() {
        let index = selectedIndex()
        switch index {
        case 0:
            backgroundColor = .clear
            blurView.isHidden = false
            isHidden = false
        case 2:
            backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            blurView.isHidden = true
            isHidden = true
        default:
            backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            blurView.isHidden = true
            isHidden = false
        }
    }
    
    private func reloadViews() {
        for button in (stackView.arrangedSubviews.compactMap { $0 as? CustomTabBarItemView }) {
            stackView.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        for item in items {
            guard let selectedImage = item.selectedImage else { continue }
            if let image = item.image {
                addButton(with: image, unselectedImage: selectedImage)
            } else {
                addButton(with: UIImage(), unselectedImage: selectedImage)
            }
        }
        
        select(at: 0)
    }
    
    private func buttons() -> [CustomTabBarItemView] {
        return stackView.arrangedSubviews.compactMap { $0 as? CustomTabBarItemView }
    }
    
    func isHasNotifications() -> Bool {
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? CustomTabBarItemView, bIndex == 3 {
                return button.notifyView.isHidden
            }
        }
        return false
    }
    
    func showChatNotify() {
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? CustomTabBarItemView, bIndex == 3 {
                button.notifyView.isHidden = false
            }
        }
    }
    
    func hideChatNotify() {
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? CustomTabBarItemView, bIndex == 3 {
                button.notifyView.isHidden = true
            }
        }
    }
    
    func add(item: UITabBarItem) {
        self.items.append(item)
        
        guard let image = item.image, let selectedImage = item.selectedImage else { return }
        self.addButton(with: image, unselectedImage: selectedImage)
    }
    
    func remove(item: UITabBarItem) {
        if let index = self.items.firstIndex(of: item) {
            self.items.remove(at: index)
            let view = self.stackView.arrangedSubviews[index]
            self.stackView.removeArrangedSubview(view)
        }
    }
    
    func selectedIndex() -> Int {
        var index = 0
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? CustomTabBarItemView, button.isSelected {
                index = bIndex
            }
        }
        return index
    }
    
    func select(at index: Int, notifyDelegate: Bool = true) {
        guard delegate?.shouldSelect(self, shouldSelectItemAt: index) == true else {
            return
        }
        var previousIndex = 0
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? CustomTabBarItemView, button.isSelected {
               previousIndex = bIndex
            }
        }
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? CustomTabBarItemView {
                button.selectedIndex = index
                button.currentIndex = bIndex
                button.isSelected = bIndex == index
            }
        }
        
        if notifyDelegate {
            self.delegate?.cardTabBar(self, didSelectItemAt: index, previousItemAt: previousIndex)
        }
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
            self.updateAppearance()
        }
        
        updateAppearance()
    }
    
    @objc func buttonTapped(sender: CustomTabBarItemView) {
        if let index = stackView.arrangedSubviews.firstIndex(of: sender) {
            select(at: index)
        }
    }
}

fileprivate extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return hypot(self.x - point.x, self.y - point.y)
    }
}
