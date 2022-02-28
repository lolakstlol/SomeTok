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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var loginTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var secureButton: UIButton!
    
    private let keyboardObserver = KeyboardObserver()
    private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        addKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func addKeyboardObservers() {
        keyboardObserver.keyboardWillShow = { [weak self] info in
            guard let self = self else { return }
            self.keyboardWillShow(info)
        }

        keyboardObserver.keyboardWillHide = { [weak self] info in
            guard let self = self else { return }
            self.keyboardWillHide(info)
        }
    }
   
    private func keyboardWillHide(_ info: KeyboardObserver.KeyboardInfo) {
         view.removeGestureRecognizer(tapWhenKeyboardAppears)
         presenter.hideKeyboard()

    }

    private func keyboardWillShow(_ info: KeyboardObserver.KeyboardInfo) {
         view.addGestureRecognizer(tapWhenKeyboardAppears)
         presenter.showKeyboard(info)
    }
    
    @IBAction func signUpDidTap(_ sender: Any) {
        if let name = loginTextField.text,
           let mail = emailTextField.text,
           let password = passwordTextField.text,
           privacySwitch.isOn {
            presenter.signUP(email: mail, name: name, pass: password)
        } else {
            // HANDLE
        }
    }
    
    @IBAction func securityButtonDidTap(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        sender.setImage( passwordTextField.isSecureTextEntry ? UIImage(named: "password") : UIImage(named: "password") , for: .normal)
    }
    
    @IBAction func loginDidTap(_ sender: Any) {
        presenter.loginDidTap()
    }
    
}

extension SignUpViewController: SignUpPresenterOutput {
    
    func onSignInFailure(_ error: String) {
        showToast(error, toastType: .failured)
    }
    
    func showCodeConfirm(model: SignUpUserModel, completion: @escaping EmptyClosure) {
        let vc = AuthCodeAssembler.createModule(model: model) {
            completion()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func signIn(completion: @escaping EmptyClosure) {
        let vc = SignInAssembler.createModule {
            completion()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupView() {
        privacySwitch.isOn = false
        emailTextField.placeholder = Strings.SignUP.PlaceHolder.mail
        passwordTextField.placeholder = Strings.SignUP.PlaceHolder.password
        loginTextField.placeholder = Strings.SignUP.PlaceHolder.login
        titleLabel.text = Strings.SignUP.title
        let mainString = Strings.SignUP.privacy
        let stringToColor = Strings.SignUP.privacyDetected
        let range = (mainString as NSString).range(of: stringToColor)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Assets.mainRed.color, range: range)
        privacyLabel.attributedText = mutableAttributedString
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
    
    func onShowKeyboard(_ insets: UIEdgeInsets) {
         scrollView.contentInset = insets
         scrollView.scrollIndicatorInsets = insets

         UIView.animate(withDuration: 0.4) {
             self.view.setNeedsLayout()
         }
    }
    
    func onHideKeyboard(_ insets: UIEdgeInsets) {

         scrollView.contentInset = insets
         scrollView.scrollIndicatorInsets = insets
        
         UIView.animate(withDuration: 0.4) {
             self.view.setNeedsLayout()
         }
    }
}
