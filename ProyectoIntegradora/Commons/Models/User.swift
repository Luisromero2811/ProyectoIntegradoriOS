//
//  User.swift
//  ProyectoIntegradora
//
//  Created by user184502 on 4/23/21.
//  Copyright © 2021 utt. All rights reserved.
//

import Foundation

struct  User: Codable {
    let email: String
    let Nombre: String
   
    
    
}

struct Player:Codable{
    var name:String
    var token: String = ""
   
   
    
    init(_ name:String,_ token:String){
        self.name = name
        self.token = token
        
    }
  
}
