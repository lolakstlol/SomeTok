//
//  CustomTabBarItemView.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 26.10.21.
//

import UIKit

final class CustomTabBarItemView: UIView {
    
    private var iconImagenCenterYConstraint: NSLayoutConstraint!
    private var selectedImage: UIImage?
    private var unselectedImage: UIImage?
    
    private let feedIcons: [UIImage] = [Assets.TabBar.home.image,
                                        Assets.TabBar.search.image,
                                        Assets.TabBar.new.image,
                                        Assets.TabBar.chat.image]
    private let averageIcons: [UIImage] = [Assets.TabBar.home.image,
                                           Assets.TabBar.search.image,
                                           Assets.TabBar.new.image,
                                           Assets.TabBar.chat.image]
    
    private lazy var iconImage: UIImageView = {
        return UIImageView()
    }()
    
    lazy var notifyView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0
        view.layer.cornerRadius = 5
        view.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)
        return view
    }()
    
    var isSelected: Bool = false {
        didSet {
            reloadApperance()
        }
    }
    
    var selectedIndex: Int?
    var currentIndex: Int?

    init(forItem item: UITabBarItem) {
        super.init(frame: .zero)
        iconImage.image = item.image
        selectedImage = item.selectedImage ?? item.image
        unselectedImage = item.image
        setupUI()
    }
    
    init(image: UIImage?, selected: UIImage?) {
        super.init(frame: .zero)
        iconImage.image = image
        selectedImage = selected ?? image
        unselectedImage = image
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        addSubview(iconImage)
        iconImage.addSubview(notifyView)
        notifyView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        notifyView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        notifyView.trailingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: -5).isActive = true
        notifyView.topAnchor.constraint(equalTo: iconImage.topAnchor, constant: 5).isActive = true
        notifyView.translatesAutoresizingMaskIntoConstraints = false
        notifyView.isHidden = true
        iconImage.contentMode = .scaleAspectFit
        iconImagenCenterYConstraint?.isActive = false
        iconImagenCenterYConstraint = iconImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        iconImagenCenterYConstraint.isActive = true
        iconImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 39).isActive = true
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.tintColor = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
        layoutIfNeeded()
        setUnSelectedImage()
    }
    
    func reloadApperance() {
        if let selectedIndex = selectedIndex, let currentIndex = currentIndex {
            unselectedImage = selectedIndex == 0 ? feedIcons[currentIndex] : averageIcons[currentIndex]
        }
        
        isSelected ? setSelectedImage() : setUnSelectedImage()
    }
    
    private func setSelectedImage() {
        iconImage.image = selectedImage
        notifyView.layer.borderWidth = 1.5
    }
    
    private func setUnSelectedImage() {
        iconImage.image = unselectedImage
        notifyView.layer.borderWidth = 0
    }
}

