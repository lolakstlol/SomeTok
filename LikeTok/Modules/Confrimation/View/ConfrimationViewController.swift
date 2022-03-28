//
//  ConfrimationViewController.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import UIKit

final class ConfrimationViewController: UIViewController {
    
    @IBOutlet private weak var topImage: UIImageView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var adjectiveButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    var presenter: ConfrimationPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    @IBAction private func closeButtonTap(_ sender: Any) {
        presenter.closeButtonTap()
    }
    
    @IBAction func adjectiveButtonTap(_ sender: Any) {
        presenter.adjectiveButtonTap()
    }
    
    @IBAction func cancelButtonTap(_ sender: Any) {
        presenter.cancelButtonTap()
    }
    
}

extension ConfrimationViewController: ConfrimationPresenterOutput {
    func setupUI(_ model: ConfrimationModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        adjectiveButton.setTitle(model.adjectiveButtonTitle, for: .normal)
        adjectiveButton.layer.cornerRadius = 10
        adjectiveButton.clipsToBounds = true
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func animatedPresent() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .black.withAlphaComponent(0.3)
        }
    }
    
    func animatedDismiss(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .clear
        } completion: { finished in
            self.dismiss(animated: true, completion: completion)
        }
    }
}
