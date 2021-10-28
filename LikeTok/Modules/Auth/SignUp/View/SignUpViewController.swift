//
//  SignUpSignUpViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class SignUpViewController: BaseViewController {
	var presenter: SignUpPresenterInput!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var privacySwitch: UISwitch!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var loginTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var secureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    @IBAction func securityButtonDidTap(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        sender.setImage( passwordTextField.isSecureTextEntry ? UIImage(named: "password") : UIImage(named: "password") , for: .normal)
    }
}

extension SignUpViewController: SignUpPresenterOutput {
    func setupView() {
        privacySwitch.isOn = false
        emailTextField.placeholder = Strings.SignUP.PlaceHolder.mail
        passwordTextField.placeholder = Strings.SignUP.PlaceHolder.password
        loginTextField.placeholder = Strings.SignUP.PlaceHolder.login
        titleLabel.text = Strings.SignUP.title
        privacyLabel.text = Strings.SignUP.privacy
        registerButton.setTitle(Strings.SignUP.continueButton, for: .normal)
        loginButton.setTitle(Strings.SignUP.loginButton, for: .normal)
        registerButton.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
        loginButton.titleLabel?.textColor = Assets.darkGrayText.color
        loginButton.layer.borderWidth = 1.5
        loginButton.layer.borderColor = Assets.darkGrayText.color.cgColor
        emailTextField.textColor = Assets.blackText.color
        passwordTextField.textColor = Assets.blackText.color
        loginTextField.textColor = Assets.blackText.color
        passwordTextField.isSecureTextEntry = true
        secureButton.setTitle("", for: .normal)
    }
}
