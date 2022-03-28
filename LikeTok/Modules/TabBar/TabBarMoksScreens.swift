//
//  TabBarMoksScreens.swift
//  LikeTok
//
//  Created by Artem Holod on 4.11.21.
//

import Foundation
import UIKit

final class AddViewController: UIViewController {
    
    private var label: UILabel = {
       let label = UILabel()
        label.text = "В разработке..."
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        label.center = view.center
    }
}

final class ChatViewController: UIViewController {
    
    private var label: UILabel = {
       let label = UILabel()
        label.text = "В разработке..."
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        label.center = view.center
    }
}

//final class ProfileViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .gray
//    }
//}
