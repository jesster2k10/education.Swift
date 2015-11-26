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
    
    func setButtonBorder (size : CGFloat = 0.0,_ object : UIButton? = nil) {
        for view in self.view.subviews
        {
            if ((object) != nil) {
                object?.layer.borderWidth = size
            }
            else {
                view.isKindOfClass(UIButton)
                view.layer.borderWidth = size
                view.layer.borderColor = UIColor.blackColor().CGColor
            }
        }
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
    
    func deleteLastSymbol() {
        displayLabel.text?.removeAtIndex(displayLabel.text!.endIndex.predecessor())
        if(displayLabel.text!.isEmpty) {
            displayLabel.text = "0"
        }
        checkButton = false
    }
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBAction func allButton(sender : UIButton) {
        let display = displayLabel.text!
        setButtonBorder()
        if let buttonLabel = sender.titleLabel?.text {
            switch(buttonLabel) {
            case "1","2","3","4","5","6","7","8","9","0": if (display == "0" || checkButton) { displayLabel.text = "" }
                                                                 displayLabel.text?.appendContentsOf(buttonLabel)
                                                                 checkButton = false
                
            case "+", "-", "/", "*": if (checkSign && !checkButton) {
                                        calculateIt()
                                        firstValue = Double(display)
                                     }
                                     signPress()
                                     lastSign = buttonLabel
                                     setButtonBorder(2, sender)
                
            case "1/x": if (display != "0") { displayLabel.text = String( 1 / Double(display)!) }
                
            case "sq": displayLabel.text = String( sqrt(Double(display)!))
                
            case "%" : secondValue = Double(display)
                       firstValue != nil ? (displayLabel.text = String((secondValue! * firstValue!) / 100)) : (displayLabel.text = String((secondValue! * 1) / 100))
                
            case "x2": secondValue = Double(display)
                       displayLabel.text = String(secondValue! * secondValue!)
                
            case "C": clearDisplay()
                
            case "CE": displayLabel.text = "0"
                
            case "<-": deleteLastSymbol()
                
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

