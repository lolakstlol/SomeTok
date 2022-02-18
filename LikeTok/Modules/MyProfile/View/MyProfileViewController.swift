//
//  MyProfileViewController.swift
//  LikeTok
//
//  Created by Daniel on 17.02.22.
//

import UIKit

enum ContentType: String {
    case advertisment = "material_products"
    case personal = "digital_products"
}

final class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var referalButton: UIButton!
    @IBOutlet weak var balanceButton: UIButton!
    
    @IBOutlet weak var advertismentButton: UIButton!
    @IBOutlet weak var advertismentBottomView: UIView!
    
    @IBOutlet weak var personalButton: UIButton!
    @IBOutlet weak var personalBottomView: UIView!
    
    var presenter: MyProfilePresenterInput!
    
    private var data: [UIColor] = [.blue, .black, .red, .magenta, .brown, .darkGray, .yellow, .red, .yellow, .green, .link, .magenta]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Дмитрий SMM"
        
        let dotsBarButtonItem = UIBarButtonItem(image: Assets.moreHorizontal.image, style: .plain, target: self, action: #selector(dotsButtonTap))
        navigationItem.rightBarButtonItems = [dotsBarButtonItem]
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ProfileCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupButtons() {
        editButton.layer.cornerRadius = 5
        editButton.clipsToBounds = true
        editButton.layer.borderColor = Assets.borderButton.color.cgColor
        editButton.layer.borderWidth = 1.5
        
        referalButton.layer.cornerRadius = 5
        referalButton.clipsToBounds = true
        referalButton.layer.borderColor = Assets.borderButton.color.cgColor
        referalButton.layer.borderWidth = 1.5
        
        balanceButton.layer.cornerRadius = 5
        balanceButton.clipsToBounds = true
        balanceButton.layer.borderColor = Assets.borderButton.color.cgColor
        balanceButton.layer.borderWidth = 1.5
    }
    
    private func update(with type: ContentType) {
        UIView.animate(withDuration: 0.3) {
            switch type {
            case .advertisment:
                self.advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
                self.advertismentBottomView.backgroundColor = Assets.mainRed.color
                self.personalButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
                self.personalBottomView.backgroundColor = .clear
            case .personal:
                self.personalButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
                self.personalBottomView.backgroundColor = Assets.mainRed.color
                self.advertismentButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
                self.advertismentBottomView.backgroundColor = .clear
            }
        }
    }
    
    @IBAction func advertismentButtonTap(_ sender: Any) {
        update(with: .advertisment)
    }
    
    @IBAction func personalButtonTap(_ sender: Any) {
        update(with: .personal)
    }
    
    @objc private func dotsButtonTap() {
        
    }
    
}

extension MyProfileViewController: MyProfilePresenterOutput {
    
}

extension MyProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id, for: indexPath) as! ProfileCollectionViewCell
//        cell.configure(data: data[indexPath.row])
        cell.backgroundColor = data[indexPath.row]
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        interactor.likedMeMatchingType(userId: data[indexPath.row].userId)
//        delegate?.openLikedMeMatching()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / Constants.itemsInLine - Constants.interItemSpacing
        return CGSize(width: widthPerItem, height: widthPerItem / Constants.imageRatio)
    }

    func collectionView(_: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if interactor.loadMore(index: indexPath.row) {
//            loadLikedMe(showLoading: false)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension MyProfileViewController {
    private enum Constants {
        static let itemsInLine: CGFloat = 3
        static let imageRatio: CGFloat = 9/16
        static let interItemSpacing: CGFloat = 2
    }
}

