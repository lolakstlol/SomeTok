//
//  CatalogCatalogViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 27/11/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class CatalogViewController: BaseViewController {
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [CategoriesDatum] = []
    var presenter: CatalogPresenterInput!
    var selectedType: CategoriesType = .digital
    var filtres: CategoriesFiltres?

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        filterButton.setTitle("", for: .normal)
        searchView.layer.cornerRadius = 10
        setupTextFieldTap()
        setupCollectionView()
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.navigationBar.isHidden = true
        
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        let categoryCell = UINib.init(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil)
        collectionView.register(categoryCell, forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
        let switcher = UINib.init(nibName: String(describing: CategoriesTypeCollectionViewCell.self), bundle: nil)
        collectionView.register(switcher, forCellWithReuseIdentifier: String(describing: CategoriesTypeCollectionViewCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupTextFieldTap() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.searchView.addGestureRecognizer(gesture)
        searchTextField.isUserInteractionEnabled = false
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        presenter.searchDidTap()
    }

    @IBAction func filtresDidTap(_ sender: Any) {
        presenter.filtresDidTap()
    }
}

extension CatalogViewController: CatalogPresenterOutput {
    func openFiltres() {
        let vc = CatalogFiltresAssembler.createModule(currentFiltres: filtres) { newFiltres in
            self.filtres = newFiltres
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showCategories(categories: [CategoriesDatum]) {
        dataSource = categories
        collectionView.reloadData()
}
    
    func openSerachScreen() {
        navigationController?.pushViewController(MainSearchAssembler.createModule(), animated: true)
    }
}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.bounds.width, height: 34)
        } else {
            return CGSize(width: view.bounds.width, height: 246)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 0)
        }
}

extension CatalogViewController: CategoriesTypeCollectionViewCellOutput {
    func didChangeType(type: CategoriesType) {
        presenter.didChangeType(type: type)
        selectedType = type
    }
}

extension CatalogViewController: UICollectionViewDelegate {
    
}

extension CatalogViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
         //   if let filtres = self.filtres {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesTypeCollectionViewCell",
                                                              for: indexPath) as! CategoriesTypeCollectionViewCell
                cell.configure(withType: selectedType)
                cell.delegate = self
                return cell
//            } else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesTypeCollectionViewCell",
//                                                              for: indexPath) as! CategoriesTypeCollectionViewCell
//                cell.configure(withType: selectedType)
//                cell.delegate = self
//            }
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell",
                                                          for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: dataSource[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
