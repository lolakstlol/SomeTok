//
//  FilterCurrentFilterCurrentViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 04/12/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class FilterCurrentViewController: BaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    var presenter: FilterCurrentPresenterInput!
    @IBOutlet weak var tableView: UITableView!
    var filterType: FilterType?
    var cityDataSource: [CityDictionary] = []
    var countiesDataSource: [CountryDictionary] = []
    var categoriesDataSorce: [CategoryDictionary] = []
    let apiWorker: SearchApiWorker = SearchApiWorker()
    var completion: ((Any?) -> Void)?
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupTableView()
        loadDict()
    }

    private func setupTableView() {
        let cell = UINib.init(nibName: String(describing: DictionaryListTableViewCell.self), bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "DictionaryListTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        loadDict()
    }
    
    private func loadDict() {
        guard let filter = filterType else { return }
        switch filter {
        case .city:
            apiWorker.getCityDictionaty(name: searchTextField.text ?? "") { result in
                switch result {
                case .success(let response):
                    self.cityDataSource = response?.data.data ?? []
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        case .country:
            apiWorker.getCountryDictionaty(name: searchTextField.text ?? "") { result in
                switch result {
                case .success(let response):
                    self.countiesDataSource = response?.data ?? []
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        case .category:
            apiWorker.getCategoriesDictionaty(name: searchTextField.text ?? "") { result in
                switch result {
                case .success(let response):
                    self.categoriesDataSorce = response?.data ?? []
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension FilterCurrentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filter = filterType else { return }
        switch filter {
        case .city:
            completion?(cityDataSource[indexPath.row] as Any)
        case .country:
            completion?(countiesDataSource[indexPath.row] as Any)
        case .category:
            completion?(categoriesDataSorce[indexPath.row] as Any)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filter = filterType else { return 0 }
        switch filter {
        case .city:
            return cityDataSource.count
        case .country:
            return countiesDataSource.count
        case .category:
            return categoriesDataSorce.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryListTableViewCell") as! DictionaryListTableViewCell
        if let filter = filterType {
            switch filter {
            case .city:
                cell.setTitle(text: cityDataSource[indexPath.row].name)
            case .country:
                cell.setTitle(text: countiesDataSource[indexPath.row].name)
            case .category:
                cell.setTitle(text: categoriesDataSorce[indexPath.row].name)
            }
        }
        return cell
    }
}

extension FilterCurrentViewController: FilterCurrentPresenterOutput {

}
