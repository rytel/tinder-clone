//
//  User.swift
//  tinder clone
//
//  Created by Rafał Rytel on 13/05/2021.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import ProgressHUD

class UserApi {
    func signUp(withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { AuthDataResult, error in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = AuthDataResult {
                print(authData.user.email)
                
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "username": username,
                    "profileImageUrl": "",
                    "status": ""
                ]
                
                guard let imageSelected = image else {
                    ProgressHUD.showError("Please choose your profile image")
                    return
                }
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                    return
                }
                
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
                                    onSuccess()
                                } else {
                                    onError(error!.localizedDescription)
                                }
                            })
                        }
                    }
                }
                
            }
        }
    }
}
