//
//  AuthPersonalDataAuthPersonalDataViewController.swift
//  LikeTok
//
//  Created by Artem Holod on 31/10/2021.
//  Copyright © 2021 LikeTok. All rights reserved.
//

import UIKit

final class AuthPersonalDataViewController: BaseViewController {
	var presenter: AuthPersonalDataPresenterInput!

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

}

extension AuthPersonalDataViewController: AuthPersonalDataPresenterOutput {

}
