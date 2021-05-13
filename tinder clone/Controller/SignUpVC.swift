//
//  RegisterVC.swift
//  tinder clone
//
//  Created by Rafał Rytel on 08/05/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class SignUpVC: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var image: UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAvatar()
        
    }
    
    // MARK:- buttons
    
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        self.validateFields()
        self.signUp()
        
    }
    
    // MARK:- func
    
    func setupAvatar() {
        avatarImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatarImage.addGestureRecognizer(tapGesture)
    }
    
    func validateFields() {
        guard let username = self.fullNameTextField.text, !username.isEmpty else {
            print("Please enter an username")
            ProgressHUD.showError("Please enter an username")
            return
        }
        guard let email = self.emailTextField.text, !username.isEmpty else {
            print("Please enter an email")
            ProgressHUD.showError("Please enter an email")

            return
        }
        guard let password = self.passwordTextField.text, !username.isEmpty else {
            print("Please enter an password")
            ProgressHUD.showError("Please enter an password")

            return
        }
    }
    
    func signUp() {
        
        Api.User.signUp(withUsername: self.fullNameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!, image: self.image) {
            print("Done")

        } onError: { errorMessage in
            print(errorMessage)
        }

        
    }
    
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            avatarImage.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            avatarImage.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
