//
//  CatalogFiltresCatalogFiltresViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 04/12/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class CatalogFiltresViewController: BaseViewController {
    @IBOutlet weak var countryTitleLabel: UILabel!
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    var presenter: CatalogFiltresPresenterInput!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var countyMoreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityMoreButton: UIButton!
    @IBOutlet weak var categoryMoreButton: UIButton!
    var completion: ((CategoriesFiltres?) -> Void)?
    var filtres: CategoriesFiltres?
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        titleLabel.text = Strings.Filtres.title
        countryTitleLabel.text = Strings.Filtres.country
        cityTitleLabel.text = Strings.Filtres.city
        categoryTitleLabel.text = Strings.Filtres.category
        cancelButton.setTitle(Strings.Filtres.clear, for: .normal)
        acceptButton.setTitle(Strings.Filtres.accept, for: .normal)
        acceptButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        cancelButton.titleLabel?.textColor = Assets.darkGrayText.color
        cancelButton.layer.borderWidth = 1.5
        cancelButton.layer.borderColor = Assets.darkGrayText.color.cgColor
        setupTitles()
    }
    
    private func setupTitles() {
        guard let filtres = filtres else {
            return
        }
        countryLabel.text = filtres.countries
        categoryLabel.text = filtres.categories
        cityLabel.text = filtres.cities
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func countryDidTap(_ sender: Any) {
        
    }
    @IBAction func cityDidTap(_ sender: Any) {
        
    }
    
    @IBAction func categoryDidTap(_ sender: Any) {
        
    }
    
    @IBAction func acceptDidTap(_ sender: Any) {
        completion?(filtres)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonDidTap(_ sender: Any) {
        completion?(nil)
        navigationController?.popViewController(animated: true)
    }
    
    private func configure(with filtres: CategoriesFiltres) {
        countryLabel.text = filtres.countries
        cityTitleLabel.text = filtres.cities
        categoryLabel.text = filtres.categories
    }
}

extension CatalogFiltresViewController: CatalogFiltresPresenterOutput {

}
