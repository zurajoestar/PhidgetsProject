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
    
    //variables like in Quizlerr
    let allQuestions = QuestionBank()

    
    //variables for mainstoryboard
    var redScore : Int = 0
    var greenScore : Int = 0
    
    
    //things from mainstoryboard
    @IBOutlet weak var questionScreen: UILabel!
    @IBOutlet weak var redScoreLabel: UILabel!
    @IBOutlet weak var greenScoreLabel: UILabel!
    
    
    //for the phidget
    let buttonArray = [DigitalInput(), DigitalInput()]
    let ledArray = [DigitalOutput(), DigitalOutput()]
    var isPlayerReady : Bool = true
    
    
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
            if(isPlayerReady == true) {
                print("isRedReddy if works")
                isPlayerReady = false
                try ledArray[1].setState(false)
                try ledArray[0].setState(true)
                    }
                redScore = redScore + 1
                updateUIred()
            }
            else{
                print("Button Not Pressed")
            
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
                if(isPlayerReady == true) {
                    print("isReady if works")
                    isPlayerReady = false
                    try ledArray[0].setState(false)
                    try ledArray[1].setState(true)
                }
                
                greenScore = greenScore + 1
                updateUIgreen()
            }
            else{
                print("Button Not Pressed")
            }
        } catch let err as PhidgetError{
            print("Phidget Error " + err.description)
        } catch{
            //catch other errors here
        }
    }
    
    func updateUIred() {
        DispatchQueue.main.async {
            self.redScoreLabel.text = "Score: \(self.redScore)"
        }
    }

    func updateUIgreen() {
        DispatchQueue.main.async {
            self.greenScoreLabel.text = "Score: \(self.greenScore)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[0]
        questionScreen.text = firstQuestion.questionText
        
        
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

