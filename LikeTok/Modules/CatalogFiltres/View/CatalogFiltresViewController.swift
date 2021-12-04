//
//  CatalogFiltresCatalogFiltresViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 04/12/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class CatalogFiltresViewController: BaseViewController {
	var presenter: CatalogFiltresPresenterInput!
    @IBOutlet weak var titleLabel: UILabel!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        titleLabel.text = Strings.Filtres.title
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CatalogFiltresViewController: CatalogFiltresPresenterOutput {

}
