//
//  RegisterRequest.swift
//  ProyectoIntegradora
//
//  Created by user184502 on 4/23/21.
//  Copyright © 2021 utt. All rights reserved.
//

import Foundation

struct RegisterRequest: Codable {
    let Nombre: String
    let email: String
    let password: String
}
