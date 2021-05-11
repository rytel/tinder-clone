//
//  RegisterVC.swift
//  tinder clone
//
//  Created by Rafał Rytel on 08/05/2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignUpVC: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: "test@gmail.com", password: "123456") { AuthDataResult, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let authData = AuthDataResult {
                print(authData.user.email)
                
                let dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "profileImageUrl": "",
                    "status": ""
                ]
                
                Database.database(url: "https://tinderclone-d9d0c-default-rtdb.europe-west1.firebasedatabase.app").reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: { (error, ref) in
                    if error == nil {
                        print("Done")
                    }
                })
            }
            
        }
    }
    
}
