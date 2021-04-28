//
//  WelcomeViewController.swift
//  ProyectoIntegradora
//
//  Created by user184502 on 4/22/21.
//  Copyright © 2021 utt. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

    private func setupUI(){
        loginButton.layer.cornerRadius = 25
    }

}
