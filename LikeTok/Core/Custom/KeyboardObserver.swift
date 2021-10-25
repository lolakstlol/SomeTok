//
//  KeyboardObserver.swift
//  LikeTok
//
//  Created by Daniil Stelchenko on 25.10.21.
//

import Foundation
import UIKit

class KeyboardObserver {
    
    struct KeyboardInfo {
        let beginRect: CGRect
        let endRect: CGRect

        let animationDuration: TimeInterval
        let animationOptions: UIView.AnimationOptions
        let localUser: Bool

        var keyboardBounds: CGRect {
            CGRect(x: 0, y: 0, width: endRect.size.width, height: endRect.size.height)
        }

        var keyboardCenterBegin: CGPoint {
            CGPoint(x: beginRect.midX, y: beginRect.midY)
        }

        var keyboardCenterEnd: CGPoint {
            CGPoint(x: endRect.midX, y: endRect.midY)
        }

        init(begin: CGRect, end: CGRect, duration: TimeInterval, options: UIView.AnimationOptions, local: Bool) {
            beginRect = begin
            endRect = end
            animationDuration = duration
            animationOptions = options
            localUser = local
        }
    }

    var keyboardWillShow: ((_ info: KeyboardInfo) -> Void)? {
        didSet {
            if keyboardWillShow != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
            } else {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            }
        }
    }

    var keyboardDidShow: ((_ info: KeyboardInfo) -> Void)? {
        didSet {
            if keyboardDidShow != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowNotification), name: UIResponder.keyboardDidShowNotification, object: nil)
            } else {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
            }
        }
    }

    var keyboardWillHide: ((_ info: KeyboardInfo) -> Void)? {
        didSet {
            if keyboardWillShow != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
            } else {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            }
        }
    }

    var keyboardDidHide: ((_ info: KeyboardInfo) -> Void)? {
        didSet {
            if keyboardDidHide != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHideNotification), name: UIResponder.keyboardDidHideNotification, object: nil)
            } else {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
            }
        }
    }

    var keyboardWillChangeFrame: ((_ info: KeyboardInfo) -> Void)? {
        didSet {
            if keyboardWillChangeFrame != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrameNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            } else {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            }
        }
    }

    var keyboardDidChangeFrame: ((_ info: KeyboardInfo) -> Void)? {
        didSet {
            if keyboardDidChangeFrame != nil {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeFrameNotification), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
            } else {
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
            }
        }
    }
}

private
extension KeyboardObserver {
    @objc
    func keyboardWillShowNotification(notification: Notification) {
        keyboardWillShow?(keyboardObserverInfoFromDictionary(userInfo: notification.userInfo!))
    }

    @objc
    func keyboardDidShowNotification(notification: Notification) {
        keyboardDidShow?(keyboardObserverInfoFromDictionary(userInfo: notification.userInfo!))
    }

    @objc
    func keyboardWillHideNotification(notification: Notification) {
        keyboardWillHide?(keyboardObserverInfoFromDictionary(userInfo: notification.userInfo!))
    }

    @objc
    func keyboardDidHideNotification(notification: Notification) {
        keyboardDidHide?(keyboardObserverInfoFromDictionary(userInfo: notification.userInfo!))
    }

    @objc
    func keyboardWillChangeFrameNotification(notification: Notification) {
        keyboardWillChangeFrame?(keyboardObserverInfoFromDictionary(userInfo: notification.userInfo!))
    }

    @objc func keyboardDidChangeFrameNotification(notification: Notification) {
        keyboardDidChangeFrame?(keyboardObserverInfoFromDictionary(userInfo: notification.userInfo!))
    }

    func keyboardObserverInfoFromDictionary(userInfo: [AnyHashable: Any]) -> KeyboardInfo {
        let begin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let end = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let options = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UIView.AnimationOptions.RawValue
        let local: Bool = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] != nil)

        return KeyboardInfo(begin: begin,
                            end: end,
                            duration: duration,
                            options: UIView.AnimationOptions(rawValue: options),
                            local: local)
    }
}
