//
//  HomeViewController.swift
//  ProyectoIntegradora
//
//  Created by user184502 on 4/26/21.
//  Copyright © 2021 utt. All rights reserved.
//

import UIKit
import Starscream
import Alamofire
import SVProgressHUD
import NotificationBannerSwift


class HomeViewController: UIViewController,WebSocketDelegate {

  
   private var socket:WebSocket!
   private var isConnected = false
   private var topic:String? = nil
   private var pingTimer:Timer?
    
    var tokens: String = ""
   override func viewDidLoad() {
       super.viewDidLoad()
       
       wsconnect()
        verUser()
   
   }
    
   
   func wsconnect(){
       //var request = URLRequest(url: URL(string: "wss://echo.websocket.org")!)
       var request = URLRequest(url: URL(string: "ws://ec2-3-143-15-255.us-east-2.compute.amazonaws.com:3333/adonis-ws?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2MDc4YzI2NTEzM2Q5NjA5MzE0NTc0NjEiLCJpYXQiOjE2MTg4NTQxNDV9.yt7tDoDgpuMy57mqWZcvTv_uzwGNfiSnYr5A9nbFp2I")!)
       request.timeoutInterval = 5
       socket = WebSocket(request: request)
       socket.delegate = self
       socket.connect()
    
   }
   
   func wsdisconnect(){
       socket.disconnect()
   }
   
   
   
   @IBAction func conectarATopic(_ sender: Any) {
       joinTopic("NivelP")
       
   }
   
   func didReceive(event: WebSocketEvent, client: WebSocket) {
       
       switch event {
           case .connected(let headers):
               isConnected = true
               print("websocket is connected: \(headers)")
               //self.tfConnection.text = "websocket is connected: \(headers)"
               self.event("onMessage", data: "Hola a todos")
               self.pingTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ping), userInfo: nil, repeats: true)
               self.pingTimer?.fire()
           case .disconnected(let reason, let code):
               isConnected = false
               print("websocket is disconnected: \(reason) with code: \(code)")
           case .text(let string):
               print("Received text: \(string)")
           case .binary(let data):
               print("Received data: \(data)")
           case .ping(_):
               break
           case .pong(_):
               break
           case .viabilityChanged(_):
               break
           case .reconnectSuggested(_):
               break
           case .cancelled:
               isConnected = false
           case .error(_):
               isConnected = false
           
           }
   }
   
   @objc func ping() {
       self.sendData(type: 8, data: nil)
   }
   func joinTopic(_ topic:String){
       self.sendData(type: 1, data: ["topic":topic])
       self.topic = topic
   }
   
   func leaveTopic(_ topic:String){
       self.sendData(type: 2, data: ["topic":topic])
       self.topic = nil
   }
   
   func event(_ event:String, data:String){
       self.sendData(type: 7, data: ["topic":self.topic ?? "", "event":event  ,"data":data])
   }
   
   func onNewData(_ data:Data) {
       //let decoder = JSONDecoder()
       do {
           let text = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
           print("data received to text: \(text)")
           //lblTextReceived.text = "data received to text: \(text)"
       }catch {
           print("Error de serializacion")
       }
   }
   
   
   func sendData(type:Int, data:[String:Any]?){
       let packet = ["t":type,"d":data ?? [:]] as [String : Any]
       do {
           let data = try JSONSerialization.data(withJSONObject: packet, options: .fragmentsAllowed)
           socket.write(data: data)
       }catch {
           print("Error de serializacion")
       }
   }
    
    
    func verUser(){
        
        if let data = UserDefaults.standard.data(forKey: "User")  {
        do {
            // Create JSON Decoder
            let decoder = JSONDecoder()
            // Decode Note
            let users = try? decoder.decode(Player.self, from: data)

            
            self.tokens = users!.token
            

 
        } catch {
            print("Unable to Decode Note (\(error))")
        }
        
            
    }
        

}
    
    @IBAction func ButtonActionLlenar() {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.tokens)",
            "Accept": "application/json"]
        
        let request = [
            "valor":100
        ]
            
            SVProgressHUD.show()
        AF.request(EndPoint.llenar, method: .post, parameters:request,headers:headers).responseJSON { (response: AFDataResponse<Any>) in
             
             SVProgressHUD.dismiss()
            
            print("\(response.result)")
             if response.error != nil{
                print("Ocurrio un error...\(response)")
                 return
             }
            

        
    }
    
}
    
    @IBAction func ButtonActionApagar_Llenado() {
        let headers: HTTPHeaders = [
                "Authorization": "Bearer \(self.tokens)",
                "Accept": "application/json"]
            
            let request = [
                "valor":""
            ]
                
                SVProgressHUD.show()
        AF.request(EndPoint.cancelar_llenado, method: .post, parameters:request,headers:headers).responseJSON { (response: AFDataResponse<Any>) in
                 
                 SVProgressHUD.dismiss()
                
                print("\(response.result)")
                 if response.error != nil{
                    print("Ocurrio un error...\(response)")
                     return
                 }
                

            
        }
    }
    
    @IBAction func ButtonActionRegar() {
        let headers: HTTPHeaders = [
                "Authorization": "Bearer \(self.tokens)",
                "Accept": "application/json"]
            
            let request = [
                "valor":100
            ]
                
                SVProgressHUD.show()
        AF.request(EndPoint.regado, method: .post, parameters:request,headers:headers).responseJSON { (response: AFDataResponse<Any>) in
                 
                 SVProgressHUD.dismiss()
                
                print("\(response.result)")
                 if response.error != nil{
                    print("Ocurrio un error...\(response)")
                     return
                 }
                

            
        }
    }
    
    
    @IBAction func ButtonActionRegar_Apagar() {
        let headers: HTTPHeaders = [
                "Authorization": "Bearer \(self.tokens)",
                "Accept": "application/json"]
            
            let request = [
                "valor":100
            ]
                
                SVProgressHUD.show()
        AF.request(EndPoint.regado_apagado, method: .post, parameters:request,headers:headers).responseJSON { (response: AFDataResponse<Any>) in
                 
                 SVProgressHUD.dismiss()
                
                print("\(response.result)")
                 if response.error != nil{
                    print("Ocurrio un error...\(response)")
                     return
                 }
                

            
        }
    }
    
    
   
    
    @IBAction func ButtonActionSalir(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
