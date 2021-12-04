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
        countryLabel.text = filtres.countries?.name ?? ""
        categoryLabel.text = filtres.categories?.name ?? ""
        cityLabel.text = filtres.cities?.name ?? ""
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func countryDidTap(_ sender: Any) {
        let vc = FilterCurrentAssembler.createModule(type: .country, completion: { data in
            self.filtres?.countries = data as! CountryDictionary
            self.setupTitles()
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cityDidTap(_ sender: Any) {
        let vc = FilterCurrentAssembler.createModule(type: .city, completion: { data in
            self.filtres?.cities = data as! CityDictionary
            self.setupTitles()
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func categoryDidTap(_ sender: Any) {
        let vc = FilterCurrentAssembler.createModule(type: .category, completion: { data in
            self.filtres?.categories = data as! CategoryDictionary
            self.setupTitles()
        })
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func acceptDidTap(_ sender: Any) {
        completion?(filtres)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonDidTap(_ sender: Any) {
        let newFiltres = CategoriesFiltres()
        completion?(newFiltres)
        navigationController?.popViewController(animated: true)
    }
    
    private func configure(with filtres: CategoriesFiltres) {
        countryLabel.text = filtres.countries?.name ?? ""
        cityTitleLabel.text = filtres.cities?.name ?? ""
        categoryLabel.text = filtres.categories?.name ?? ""
    }
}

extension CatalogFiltresViewController: CatalogFiltresPresenterOutput {

}
