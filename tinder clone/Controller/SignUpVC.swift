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
        guard let imageSelected = self.image else {
            print("Avatar is nil")
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }

        Auth.auth().createUser(withEmail: "test2@gmail.com", password: "123456") { AuthDataResult, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let authData = AuthDataResult {
                print(authData.user.email)
                
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "profileImageUrl": "",
                    "status": ""
                ]
                
                let storageRef = Storage.storage().reference(forURL: "gs://tinderclone-d9d0c.appspot.com/")
                let storageProfileRef = storageRef.child("users").child(authData.user.uid)
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                storageProfileRef.putData(imageData, metadata: metadata) { StorageMetadata, error in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    storageProfileRef.downloadURL { url, error in
                        if let metaImageUrl = url?.absoluteString {
                            print(metaImageUrl)
                            dict["profileImageUrl"] = metaImageUrl
                            
                            Database.database(url: "https://tinderclone-d9d0c-default-rtdb.europe-west1.firebasedatabase.app").reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: { (error, ref) in
                                if error == nil {
                                    print("Done")
                                }
                            })
                        }
                    }
                }
                
            }
        }
    }
    
    // MARK:- func
    
    func setupAvatar() {
        avatarImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatarImage.addGestureRecognizer(tapGesture)
    }
    
    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
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
