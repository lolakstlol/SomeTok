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
    var presenter: CatalogPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        filterButton.setTitle("", for: .normal)
        searchView.layer.cornerRadius = 10
        setupTextFieldTap()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTextFieldTap() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.searchView.addGestureRecognizer(gesture)
        searchTextField.isUserInteractionEnabled = false
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        presenter.searchDidTap()
    }

}

extension CatalogViewController: CatalogPresenterOutput {
    func openSerachScreen() {
        navigationController?.pushViewController(MainSearchAssembler.createModule(), animated: true)
    }
}
