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
    var tempSign : String = ""
    var checkEqual = false
    //var checkSign = false
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
          //  let tempColor : CGColorRef = object!.layer.backgroundColor
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
        if (!checkButton) {
            if (firstValue != nil && secondValue != nil) {
                switch(tempSign) {
                case "+" : tempValue = firstValue! + secondValue!
                case "-" : tempValue = firstValue! - secondValue!
                case "×" : tempValue = firstValue! * secondValue!
                case "÷" : tempValue = firstValue! / secondValue!
                default: break
                }
                //checkSign = false
                checkButton = true
                displayLabel.text =  String(format: "%g", tempValue!)
            }
        }
        tempSign = lastSign
    }
    
    
    func signPress () {
        firstValue = Double(displayLabel.text!)
        checkButton = true
        checkEqual = false
        //checkSign = true
    }
    
    func clearDisplay () {
        firstValue = nil
        secondValue = nil
        checkEqual = false
        //checkSign = false
        checkButton = false
        displayLabel.text = "0"
        operationsLabel.text! = ""
    }
    
    func deleteLastSymbol() {
        displayLabel.text?.removeAtIndex(displayLabel.text!.endIndex.predecessor())
        if(displayLabel.text!.isEmpty) {
            displayLabel.text = "0"
        }
        checkButton = false
    }
    
    func checkDisplayLengh ( buttonLabel : String) {
        if (displayLabel.text?.characters.count < 10) {
            displayLabel.text?.appendContentsOf(buttonLabel)
        }
    }
    
    func operationDisplay() {
        if (!checkButton || checkEqual) {
            operationsLabel.text?.appendContentsOf(" " + displayLabel.text! + " " + lastSign)
        }
        else {
            operationsLabel.text?.removeAtIndex(operationsLabel.text!.endIndex.predecessor())
            operationsLabel.text?.appendContentsOf(lastSign)
        }
    }
    
    @IBOutlet weak var operationsLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBAction func allButton(sender : UIButton) {
        let display = displayLabel.text!
        
        setButtonBorder()
        
        if let buttonLabel = sender.titleLabel?.text {
            switch(buttonLabel) {
            case "1","2","3","4","5","6","7","8","9","0": if (display == "0" || checkButton) { displayLabel.text = "" }
                                                                 checkDisplayLengh(buttonLabel)
                                                          checkButton = false
            case "+", "-", "÷", "×": lastSign = buttonLabel
                                     operationDisplay()
                                     //checkEqual = false
                                     calculateIt()
                                     signPress()
                                     setButtonBorder(3, sender)
                
            case "¹/x": if (display != "0") { displayLabel.text = String(format: "%g", 1 / Double(display)!) }
                
            case "√": displayLabel.text = String(format: "%g", sqrt(Double(display)!))
                
            case "%" : secondValue = Double(display)
                       firstValue != nil ? (displayLabel.text = String(format: "%g", (secondValue! * firstValue!) / 100)) : (displayLabel.text = String((secondValue! * 1) / 100))
                
            case "x²": secondValue = Double(display)
                       displayLabel.text = String(format: "%g", secondValue! * secondValue!)
                
            case "C": clearDisplay()
                
            case "CE": displayLabel.text = "0"
                
            case "←": deleteLastSymbol()
                
            case "±": if (display[display.startIndex] != "-" && display != "0") { ( displayLabel.text?.insert("-", atIndex: display.startIndex)) }
                        else if (display[display.startIndex] == "-") { (displayLabel.text?.removeAtIndex(display.startIndex)) }
                
            case ",": if(!display.containsString(".")) {
                        checkDisplayLengh(".")
                      }
                
            case "=": calculateIt()
                      checkEqual = true
                      operationsLabel.text! = ""
            default: break
            }
        }
    }
}

