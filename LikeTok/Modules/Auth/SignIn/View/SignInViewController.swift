//
//  SignInSignInViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 27/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class SignInViewController: BaseViewController {
    
    @IBOutlet weak var loginTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var securyButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createAccountbutton: UIButton!
    @IBOutlet weak var recoveryPassButton: UIButton!
    
    var presenter: SignInPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func securyButtonDidTap(_ sender: Any) {
        
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        if let mail = loginTextField.text,
           let pass = passwordTextField.text {
        presenter.loginDidTap(email: mail, pass: pass)
        } else {
           // handle
        }
    }
    
    @IBAction func createAccountDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPasswordRecoveryTap(_ sender: Any) {
        presenter.onPasswordRecoveryTap()
    }
}

extension SignInViewController: SignInPresenterOutput {
    func showPasswordRecovery() {
        let vc = PasswordRecoveryFirstAssembler.createModule()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView() {
        passwordTextField.placeholder = Strings.SignUP.PlaceHolder.password
        loginTextField.placeholder = Strings.SignUP.PlaceHolder.login
        titleLabel.text = Strings.SignIn.title
        loginButton.layer.cornerRadius = 10
        passwordTextField.textColor = Assets.blackText.color
        loginTextField.textColor = Assets.blackText.color
        passwordTextField.isSecureTextEntry = true
        securyButton.setTitle("", for: .normal)
        createAccountbutton.setTitle(Strings.SignIn.createAccount, for: .normal)
        recoveryPassButton.setTitle(Strings.SignIn.resetPassword, for: .normal)
        loginButton.setTitle(Strings.SignUP.continueButton, for: .normal)
    }
    

}
