//
//  SettingsViewController.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private var dataSourse: [(title: String, action: () -> ())] = []
    
    var presenter: SettingsPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func backButtonTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsViewController: SettingsPresenterOutput {
    func showConfrimationScreen(_ view: ConfrimationViewController) {
        view.modalPresentationStyle = .overCurrentContext
        present(view, animated: true, completion: nil)
    }
    
    func onLogout() {
        tabBarController?.view.removeFromSuperview()
    }
    
    func setupUI(_ dataSourse: [(String, action: () -> ())]) {
        self.dataSourse = dataSourse
        titleLabel.text = "Настройки"
        tableView.register(nibOfClass: SettingsTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSourse[indexPath.row].action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTableViewCell.self), for: indexPath) as! SettingsTableViewCell
        cell.setup(dataSourse[indexPath.row].title)
        return cell
    }
    
}
