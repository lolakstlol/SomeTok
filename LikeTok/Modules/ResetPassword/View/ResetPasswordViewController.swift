//
//  ResetPasswordResetPasswordViewController.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class ResetPasswordViewController: BaseViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var emailTextField: InsetTextField!
    @IBOutlet private weak var resumeButton: UIButton!
    
    var presenter: ResetPasswordPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    private func configure() {
        titleLabel.text = Strings.ResetPassword.title
        textLabel.text = Strings.ResetPassword.text
        textLabel.textColor = Assets.darkGrayText.color
        emailTextField.placeholder = Strings.ResetPassword.email
        resumeButton.setTitle(Strings.ResetPassword.resume, for: .normal)
    }

}

extension ResetPasswordViewController: ResetPasswordPresenterOutput {

}
