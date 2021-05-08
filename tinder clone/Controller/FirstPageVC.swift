//
//  ViewController.swift
//  tinder clone
//
//  Created by Rafał Rytel on 07/05/2021.
//

import UIKit

class FirstPageVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInFacebookButton: UIButton!
    @IBOutlet weak var signInGoogleButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signInFacebookButton.layer.cornerRadius = 5
        signInGoogleButton.layer.cornerRadius = 5
        createAccountButton.layer.cornerRadius = 5

    }


}

