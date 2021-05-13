//
//  ForgotPasswordVC.swift
//  tinder clone
//
//  Created by Rafał Rytel on 09/05/2021.
//

import UIKit
import ProgressHUD
class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK:- button
    @IBAction func backPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPasswordPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        Api.User.resetPassword(email: email) {
            self.view.endEditing(true)
            ProgressHUD.showSuccess(SUCCESS_PASSWORD_RESET)
            self.navigationController?.popViewController(animated: true)
        } onError: { error in
            ProgressHUD.showError(error)
        }

    }
    



}
