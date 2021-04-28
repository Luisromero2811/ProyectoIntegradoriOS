//
//  EndPoint.swift
//  ProyectoIntegradora
//
//  Created by user184502 on 4/23/21.
//  Copyright © 2021 utt. All rights reserved.
//

import Foundation


struct EndPoint {
    static let domain = "http://3.143.15.255:3333"
    static let login = EndPoint.domain + "/Login"
    static let register = EndPoint.domain + "/Registro"
    static let llenar = EndPoint.domain + "/LlenarP"
    static let cancelar_llenado = EndPoint.domain + "/LlenarP/Cancel"
    static let regado = EndPoint.domain + "/Regado/Encendido"
    static let regado_apagado = EndPoint.domain + "/Regado/Apagado"
}
