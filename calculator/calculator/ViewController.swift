//
//  ViewController.swift
//  calculator
//
//  Created by Родыгин Дмитрий on 21.10.15.
//  Copyright © 2015 Родыгин Дмитрий. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstValue : Double? = nil
    var secondValue : Double? = nil
    var tempValue : Double? = nil
    var lastSign : String = ""
    var checkEqual = false
    var checkSign = false
    var checkButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateIt () {
        checkEqual ? (firstValue = Double(displayLabel.text!)) : (secondValue = Double(displayLabel.text!))
        if (firstValue != nil && secondValue != nil) {
            switch(lastSign) {
            case "+" : tempValue = firstValue! + secondValue!
            case "-" : tempValue = firstValue! - secondValue!
            case "*" : tempValue = firstValue! * secondValue!
            case "/" : tempValue = firstValue! / secondValue!
            default: break
            }
        checkSign = false
        checkEqual = true
        checkButton = true
        displayLabel.text =  String(tempValue!)
        }
    }
    
    
    func signPress () {
        if (checkSign) {
            secondValue = Double(displayLabel.text!)
        }
        else if (!checkSign) {
            firstValue = Double(displayLabel.text!)
        }
        checkSign = true
        checkButton = true
        checkEqual = false
    }
    
    func clearDisplay () {
        firstValue = nil
        secondValue = nil
        checkEqual = false
        checkSign = false
        checkButton = false
        displayLabel.text = "0"
    }
        
    @IBOutlet weak var displayLabel: UILabel!
    @IBAction func allButton(sender : UIButton) {
        let display = displayLabel.text!
        if let buttonLabel = sender.titleLabel?.text {
            switch(buttonLabel) {
            case "1","2","3","4","5","6","7","8","9","0", "000": if (display == "0" || checkButton) { displayLabel.text = "" }
                                                                 if (display == "0" && buttonLabel == "000") { displayLabel.text = "0" }
                                                                 else {
                                                                 displayLabel.text?.appendContentsOf(buttonLabel)
                                                                 }
                                                                 checkButton = false
            case "+", "-", "/", "*": if (checkSign && !checkButton) {
                                        calculateIt()
                                        firstValue = Double(display)
                                     }
                                     signPress()
                                     lastSign = buttonLabel
            case "%" : secondValue = Double(display)
                       firstValue != nil ? (displayLabel.text = String((secondValue! * firstValue!) / 100)) : (displayLabel.text = String((secondValue! * 1) / 100))
            case "C": clearDisplay()
            case "+/-": if (display[display.startIndex] != "-" && display != "0") { ( displayLabel.text?.insert("-", atIndex: display.startIndex)) }
                        else if (display[display.startIndex] == "-") { (displayLabel.text?.removeAtIndex(display.startIndex)) }
            case ".": if(!display.containsString(".")) {
                        displayLabel.text?.appendContentsOf(".")
                      }
            case "=": calculateIt()
            default: break
            }
        }
    }
    
}

