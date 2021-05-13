//
//  SignUpVC.swift
//  tinder clone
//
//  Created by Rafał Rytel on 08/05/2021.
//

import UIKit
import ProgressHUD

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- button
    @IBAction func signInPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.validateFields()
        self.signIn {
            //switch view
        } onError: { error in
            ProgressHUD.showError(error)
        }
    }
    @IBAction func signUpPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- func
    func signIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        ProgressHUD.show()
        Api.User.signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!) {
            ProgressHUD.dismiss()
            onSuccess()
        } onError: { error in
            onError(error)
        }
    }
    func validateFields() {
        guard let email = self.emailTextField.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
