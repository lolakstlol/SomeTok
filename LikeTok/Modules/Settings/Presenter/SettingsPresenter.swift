
//  SettingsPresenter.swift
//  LikeTok
//
//  Created by Daniel on 23.03.22.
//

import Foundation

final class SettingsPresenter: NSObject {
    
    private unowned let view: SettingsPresenterOutput
    
    private lazy var dataSource: [(String, action: () -> ())] =
                                    [("Уведомления", {
                                        self.notificationsAction()}),
                                    ("Смена пароля", {
                                        self.changePasswordAction()}),
                                    ("Выйти из аккаунта", {
                                        self.logoutAction()}),
                                    ("Удалить аккаунт", {
                                        self.deleteAccountAction()})
    ]

    init(_ view: SettingsPresenterOutput) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupUI(dataSource)
    }

    func notificationsAction() {
        debugPrint("Уведомления")
    }
            
    func changePasswordAction() {
        debugPrint("Смена пароля")
    }
    
    func logoutAction() {
        let model = ConfrimationModel(title: "Выйти из аккаунта", description: "Вам потребуется заново ввести ваши логин и пароль, чтобы снова войти. Вы хотите продолжить?", adjectiveButtonTitle: "Выйти") { [weak self] in
            self?.logout()
        }
        let confrimationView = ConfrimationAssembler.createModule(model: model)
        view.showConfrimationScreen(confrimationView)
    }
    
    func deleteAccountAction() {
        let model = ConfrimationModel(title: "Удалить аккаунт", description: "Если вы удалите свой аккаунт, то ваш профиль, все фото, видео, комментарии, отметки 'Нравится' и подписчики также будут безвозвратно удалены.", adjectiveButtonTitle: "Удалить") { [weak self] in
            self?.delete()
        }
        let confrimationView = ConfrimationAssembler.createModule(model: model)
        view.showConfrimationScreen(confrimationView)
    }
}

private extension SettingsPresenter {
    
    func logout() {
        NotificationCenter.default.post(name: .userLoggedOut, object: self)
    }
    
    func delete() {
        
    }
}

extension SettingsPresenter: SettingsPresenterInput {

}
