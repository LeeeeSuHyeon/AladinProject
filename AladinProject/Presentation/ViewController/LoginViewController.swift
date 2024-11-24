//
//  LoginViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView : LoginView
    
    init() {
        self.loginView = LoginView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = loginView
    }
}
