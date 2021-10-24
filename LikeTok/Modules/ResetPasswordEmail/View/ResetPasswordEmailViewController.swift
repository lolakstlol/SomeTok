//
//  ResetPasswordResetPasswordViewController.swift
//  LikeTok
//
//  Created by Danik on 22/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class ResetPasswordEmailViewController: BaseViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var resumeButton: UIButton!
    @IBOutlet private weak var emailTextField: InsetTextField!
    
    private let keyboardObserver = KeyboardObserver()
    private var isKeyboardAppears: Bool = false
    private lazy var tapWhenKeyboardAppears = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    
    var presenter: ResetPasswordEmailPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        addKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
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

    
    private func configure() {
        titleLabel.text = Strings.ResetPassword.Email.title
        titleLabel.textColor = Assets.blackText.color
        
        textLabel.text = Strings.ResetPassword.Email.text
        textLabel.textColor = Assets.darkGrayText.color
        
        emailTextField.backgroundColor = Assets.lightGray.color
        emailTextField.textColor = Assets.blackText.color
        
        resumeButton.setTitle(Strings.ResetPassword.Email.resume, for: .normal)
        resumeButton.setTitleColor(Assets.whiteText.color, for: .normal)
        resumeButton.tintColor = Assets.whiteText.color
        resumeButton.backgroundColor = Assets.mainRed.color
        resumeButton.layer.cornerRadius = 10
    }
    
    private func keyboardWillHide(_ info: KeyboardObserver.KeyboardInfo) {
         view.removeGestureRecognizer(tapWhenKeyboardAppears)
         
         if isKeyboardAppears {
             isKeyboardAppears = false
             self.view.frame.origin.y = 0
            
             UIView.animate(withDuration: 0.4) {
                 self.view.setNeedsLayout()
             }
         }
    }

     private func keyboardWillShow(_ info: KeyboardObserver.KeyboardInfo) {
         view.addGestureRecognizer(tapWhenKeyboardAppears)

         if !isKeyboardAppears {
             isKeyboardAppears = true
             view.frame.origin.y -= info.keyboardBounds.height

             UIView.animate(withDuration: 0.4) {
                 self.view.setNeedsLayout()
             }
         }
     }


    @IBAction func onResumeButtonTap(_ sender: Any) {
        guard let email = emailTextField.text else {
            return
        }
        presenter.resetPassword(email)
    }
}

extension ResetPasswordEmailViewController: ResetPasswordEmailPresenterOutput {
    func onResetPassword() {
        
    }
}
