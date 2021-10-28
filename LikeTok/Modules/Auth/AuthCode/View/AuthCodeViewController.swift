//
//  AuthCodeAuthCodeViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 26/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class AuthCodeViewController: BaseViewController {
	var presenter: AuthCodePresenterInput!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getNewCodeButton: UIButton!
    @IBOutlet private var firstNumberTextField: NumberTextField!
    @IBOutlet private var secondNumberTextField: NumberTextField!
    @IBOutlet private var thirdNumberTextField: NumberTextField!
    @IBOutlet private var fouthNumberTextField: NumberTextField!
    
    @IBOutlet private var bottomButtonConstraint: NSLayoutConstraint!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNumberTextField.layer.cornerRadius = firstNumberTextField.frame.height / 2
        secondNumberTextField.layer.cornerRadius = firstNumberTextField.frame.height / 2
        thirdNumberTextField.layer.cornerRadius = firstNumberTextField.frame.height / 2
        fouthNumberTextField.layer.cornerRadius = firstNumberTextField.frame.height / 2
    }
    
    private func setupTextFields() {
        firstNumberTextField.tag = 1
        secondNumberTextField.tag = 2
        thirdNumberTextField.tag = 3
        fouthNumberTextField.tag = 4
        [firstNumberTextField, secondNumberTextField, thirdNumberTextField, fouthNumberTextField].forEach { textField in
            textField?.layer.cornerRadius = 14.0
            textField?.delegate = self as? NumberTextFieldDelegate
            textField?.delegate = self
            textField?.keyboardType = .numberPad
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        self.bottomButtonConstraint.constant = keyboardViewEndFrame.height - self.view.safeAreaInsets.bottom
            + 25
        view.layoutSubviews()
    }
    
    @objc private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomButtonConstraint.constant = 25
        view.layoutSubviews()
    }
    
    private func codeComplete() {
        guard !(firstNumberTextField.text?.isEmpty ?? true),
              !(secondNumberTextField.text?.isEmpty ?? true),
              !(thirdNumberTextField.text?.isEmpty ?? true),
              !(fouthNumberTextField.text?.isEmpty ?? true) else { return }
        
        var code = ""
        [firstNumberTextField, secondNumberTextField, thirdNumberTextField, fouthNumberTextField].forEach { textField in
            code += textField.text ?? ""
        }
        
        presenter.codeReceived(code: code)
    }
    
    @IBAction func getNewCode(_ sender: Any) {
        presenter.getNewCode()
    }
    
}

extension AuthCodeViewController: AuthCodePresenterOutput {
    func setTimerTitle(text: String) {
        timerLabel.text = text
    }
    
    func enableResendButton(isEnebled: Bool) {
        getNewCodeButton.isEnabled = isEnebled
    }
    
    func setupView() {
        firstNumberTextField.layer.borderWidth = 0.5
        secondNumberTextField.layer.borderWidth = 0.5
        thirdNumberTextField.layer.borderWidth = 0.5
        fouthNumberTextField.layer.borderWidth = 0.5
        firstNumberTextField.layer.borderColor = UIColor(red: (18/255.0), green: (18/255.0), blue: (29/255.0), alpha: 0.1).cgColor
        secondNumberTextField.layer.borderColor = UIColor(red: (18/255.0), green: (18/255.0), blue: (29/255.0), alpha: 0.1).cgColor
        thirdNumberTextField.layer.borderColor = UIColor(red: (18/255.0), green: (18/255.0), blue: (29/255.0), alpha: 0.1).cgColor
        fouthNumberTextField.layer.borderColor = UIColor(red: (18/255.0), green: (18/255.0), blue: (29/255.0), alpha: 0.1).cgColor
        getNewCodeButton.layer.borderColor = Assets.darkGrayText.color.cgColor
        getNewCodeButton.layer.borderWidth = 1.5
        getNewCodeButton.layer.cornerRadius = 10
        timerLabel.text = "00:59"
        titleLabel.text = Strings.AuthCode.title
        getNewCodeButton.setTitle(Strings.AuthCode.getNewCode, for: .normal)
        title = Strings.AuthCode.navigationTitle
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        setupTextFields()
        setupKeyboardObservers()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Assets.backButton.image, style: .plain, target: self, action: #selector(backButton))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}

extension AuthCodeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string != "" {
            if textField.text == "" {
                textField.text = string
                if let nextResponder: UIResponder? = textField.superview?.viewWithTag(textField.tag + 1) {
                    nextResponder?.becomeFirstResponder()
                }
                if textField.tag == 4 {
                    codeComplete()
                }
            } else {
                if let nextResponder: UIResponder? = textField.superview?.viewWithTag(textField.tag + 1) {
                    nextResponder?.becomeFirstResponder()
                    let nextTextfield = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField
                    nextTextfield?.text = string
                    if nextTextfield?.tag == 4 {
                        codeComplete()
                    }
                }
            }
            return false
        } else {
            textField.text = string
            if let nextResponder: UIResponder? = textField.superview?.viewWithTag(textField.tag - 1) {
                nextResponder?.becomeFirstResponder()
            }
            return false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return !((textField.text?.count ?? .zero) > 1)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

protocol NumberTextFieldDelegate : UITextFieldDelegate {
    func didPressBackspace(_ textField: NumberTextField)
}

class NumberTextField: UITextField {
    override func deleteBackward() {
        super.deleteBackward()
        self.didPressBackspace(self)
    }
    
    private func didPressBackspace(_ textField: NumberTextField) {
        if let nextResponder: UIResponder? = textField.superview?.viewWithTag(textField.tag - 1) {
            nextResponder?.becomeFirstResponder()
            if let nextTextField = nextResponder as? NumberTextField {
                nextTextField.text = ""
            }
        }
    }
}
