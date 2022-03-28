//
//  ConfrimationPresenter.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import Foundation

struct ConfrimationModel {
    let title: String
    let description: String
    let adjectiveButtonTitle: String
    let adjectiveAction: (() -> ())?
}

final class ConfrimationPresenter {
    
    private unowned let view: ConfrimationPresenterOutput
    private var model: ConfrimationModel
    private var isFinal: Bool = false
    
    
    init(_ view: ConfrimationPresenterOutput,
         _ model: ConfrimationModel) {
        self.view = view
        self.model = model
    }

    func viewDidLoad() {
        view.setupUI(model)
    }
    
    func viewDidAppear() {
        view.animatedPresent()
    }

}

extension ConfrimationPresenter: ConfrimationPresenterInput {
    func closeButtonTap() {
        view.animatedDismiss(completion: nil)
    }
    
    func adjectiveButtonTap() {
        model.adjectiveAction?()
        view.animatedDismiss { [weak self] in
            self?.model.adjectiveAction?()
        }
    }
    
    func cancelButtonTap() {
        view.animatedDismiss(completion: nil)
    }
}
