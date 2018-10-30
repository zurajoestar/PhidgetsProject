//
//  ViewController.swift
//  PhidgetsProject
//
//  Created by Cristina Lopez on 2018-10-30.
//  Copyright © 2018 Cristina Lopez. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {

    
    let button0 = DigitalInput()
    let button1 = DigitalInput()
    let led2 = DigitalOutput()
    let led3 = DigitalOutput()
    let ledArray = [DigitalOutput(), DigitalOutput()]
    let buttonArray = [DigitalInput(), DigitalInput()]
    
    func attach_handler(sender: Phidget){
        do{
            
            let hubPort = try sender.getHubPort()
            
            if(hubPort == 0){
                print("Button 0 Attached")
            }
            else if (hubPort == 1){
                print("Button 1 Attached")
            }
            else if (hubPort == 2){
                print("LED 2 Attached")
            }
            else{
                print("LED 3 Attached")
            }
            
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            //enable server
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            //address digital input
            try button0.setHubPort(0)
            try button1.setHubPort(1)
            try led2.setHubPort(2)
            try led3.setHubPort(3)
            
            //address, add handler, open digital inputs
            for i in 0..<buttonArray.count{
                try buttonArray[i].setHubPort(i)
                try buttonArray[i].setIsHubPortDevice(true)
                let _ = buttonArray[i].attach.addHandler(attach_handler)
                try buttonArray[i].open()
            }
            
            //address, add handler, open digital outputs
            for i in 2..<ledArray.count{
                try ledArray[i].setHubPort(i)
                try ledArray[i].setIsHubPortDevice(true)
                let _ = ledArray[i].attach.addHandler(attach_handler)
                try ledArray[i].open()
            }
            
        } catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        } catch {
            //other errors here
        }
    }


}

