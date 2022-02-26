//
//  AboutPersonalPostViewController.swift
//  LikeTok
//
//  Created by Daniel on 26.02.22.
//

import UIKit

final class AboutPersonalPostViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    
    var presenter: AboutPersonalPostPresenterInput!

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
    
    @IBAction private func nextButtonTap(_ sender: Any) {
        presenter.nextButtonTap()
    }
    
}

extension AboutPersonalPostViewController: AboutPersonalPostPresenterOutput {
    func setupUI() {
        doneButton.setTitle(Strings.UploadAbout.next, for: .normal)
        titleLabel.text = Strings.UploadAbout.title
        doneButton.layer.cornerRadius = 10
        doneButton.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func animatedPresent() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .black.withAlphaComponent(0.3)
        }
    }
    
    func animatedDismiss() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .clear
        } completion: { finished in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func onNextButtonTap() {
        doneButton.setTitle(Strings.UploadAbout.close, for: .normal)
    }
}
