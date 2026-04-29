//
//  LoginViewController.swift
//  Moviefy
//
//  Created by Jibryll Brinkley on 4/29/26.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Login"
        loginButton.setTitle("Login with TMDb", for: .normal)
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("Login tapped")
    }
}
