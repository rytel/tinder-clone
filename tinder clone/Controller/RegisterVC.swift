//
//  RegisterVC.swift
//  tinder clone
//
//  Created by Rafał Rytel on 08/05/2021.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImage.layer.cornerRadius = 40
        avatarImage.clipsToBounds = true
        signUpButton.layer.cornerRadius = 5
        signInButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
}
