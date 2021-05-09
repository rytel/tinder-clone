//
//  RegisterVC.swift
//  tinder clone
//
//  Created by Rafał Rytel on 08/05/2021.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backpressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
