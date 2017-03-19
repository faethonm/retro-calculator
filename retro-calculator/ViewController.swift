//
//  ViewController.swift
//  retro-calculator
//
//  Created by Faethon Milikouris on 3/19/17.
//  Copyright © 2017 Faethon Milikouris. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Equals  = "="
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soundUrl = Bundle.main.url(forResource: "btn", withExtension: "wav")
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl!)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(btn: UIButton){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    
    @IBAction func onDividePressed(btn: UIButton){
        processOperation(opr: (Operation.Divide))
    }
    
    @IBAction func onMultiplyPressed(btn: UIButton){
        processOperation(opr: (Operation.Multiply))
    }
    
    @IBAction func onSubtractPressed(btn: UIButton){
        processOperation(opr: (Operation.Subtract))
    }
    
    @IBAction func onAddPressed(btn: UIButton){
        processOperation(opr: (Operation.Add))
    }
    
    @IBAction func onEqualPressed(btn: UIButton){
        processOperation(opr: (currentOperation))
    }
    
    func processOperation(opr: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                if opr == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if opr == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if opr == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if opr == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                leftValStr = result
                outputLbl.text = result
            }
            currentOperation = opr
        } else {
            // first time
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = opr
            
        }
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }


}

