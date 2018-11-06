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

    
//    let button0 = DigitalInput()
//    let button1 = DigitalInput()
//    let led2 = DigitalOutput()
//    let led3 = DigitalOutput()
    
    
    let buttonArray = [DigitalInput(), DigitalInput()]
    let ledArray = [DigitalOutput(), DigitalOutput()]
    var redButtonPressed : Bool = false
    var greenButtonPressed : Bool = false
    
    //variables for mainstoryboard
    
    var numberpressedred : Int = 0
    var numberpressedgreen : Int = 0
    
    
    @IBOutlet weak var pressedredbutton: UILabel!
    @IBOutlet weak var pressedgreenbutton: UILabel!
    
    
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
    
    //state change for button 0
    func state_change_button0(sender:DigitalInput, state:Bool){
        do{
            if(state == true){
                print("Button Pressed")
                try ledArray[0].setState(true)
                numberpressedred = numberpressedred + 1
                updateUIred()

            }
            else{
                print("Button Not Pressed")
                try ledArray[0].setState(false)
            
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    
    //state change for button 1
    func state_change_button1(sender:DigitalInput, state:Bool){
        do{
            if(state == true){
                print("Button Pressed")
                try ledArray[1].setState(true)
                numberpressedgreen = numberpressedgreen + 1
                updateUIgreen()
            }
            else{
                print("Button Not Pressed")
                try ledArray[1].setState(false)
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    func updateUIred() {
        pressedredbutton.text = "Score: \(numberpressedred)"
    }
    
    func updateUIgreen() {
        pressedgreenbutton.text = "Score: \(numberpressedgreen)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            //enable server
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            
            //address, add handler, open digital BUTTONS
            for i in 0..<buttonArray.count{
                try buttonArray[i].setDeviceSerialNumber(528040)
                try buttonArray[i].setHubPort(i)
                try buttonArray[i].setIsHubPortDevice(true)
                let _ = buttonArray[i].attach.addHandler(attach_handler)
                try buttonArray[i].open()
            }
            
            
            //address, add handler, open LEDs
            for i in 0..<ledArray.count{
                try ledArray[i].setDeviceSerialNumber(528040)
                try ledArray[i].setHubPort(i+2)
                try ledArray[i].setIsHubPortDevice(true)
                let _ = ledArray[i].attach.addHandler(attach_handler)
                try ledArray[i].open()
            }
            
            let _ = buttonArray[0].stateChange.addHandler(state_change_button0)
            let _ = buttonArray[1].stateChange.addHandler(state_change_button1)
            

            
        } catch let err as PhidgetError {
            print("Phidget Error " + err.description)
        } catch {
            //other errors here
        }
    }


}

