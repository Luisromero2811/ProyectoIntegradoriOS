//
//  RegisterViewController.swift
//  ProyectoIntegradora
//
//  Created by user184502 on 4/22/21.
//  Copyright © 2021 utt. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SVProgressHUD
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var contrasenaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
   @IBAction func registerButtonAction(){
   
     performRegister()
    }
    

    private func setupUI(){
        view.endEditing(true)
        RegisterButton.layer.cornerRadius = 25
    }
    private func performRegister(){
        guard let nombre = nombreTextField.text, !nombre.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un nombre...", style:.warning).show()
            return
        }
        
        guard let correo = correoTextField.text, !correo.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un correo...", style:.warning).show()
            return
        }
        
        guard let contrasena = contrasenaTextField.text, !contrasena.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes escribir la contrasena...", style:.warning).show()
            return
        }
        // Crear request
       let request = RegisterRequest(Nombre: nombre, email: correo, password: contrasena)
        
        SVProgressHUD.show()
         
        AF.request(EndPoint.register, method: .post, parameters: request).responseJSON { (response: AFDataResponse<Any>) in
            
            SVProgressHUD.dismiss()
            
            if response.error != nil{
                print("Ocurrio un error...")
            }
            print("Respuesta . \(response)")
            
            
        }
        
         //performSegue(withIdentifier: "showHome", sender: nil)
        
        // iniciar sesion aqui
        
    }

}
