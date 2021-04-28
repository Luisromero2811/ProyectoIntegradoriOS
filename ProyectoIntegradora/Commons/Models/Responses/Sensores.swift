//
//  Sensores.swift
//  ProyectoIntegradora
//
//  Created by user184502 on 4/27/21.
//  Copyright © 2021 utt. All rights reserved.
//

import Foundation

struct Sensores:Codable {
    let t: Int
    let d: Datos
   
}

struct Datos:Codable {
    let data: Sensor
    let topic: String
    let event: String
}

struct Sensor:Codable {
    let Humendad: Int
    let NidelP: Int
    let NivelS: Int
}
