//
//  ViewController.swift
//  calculator
//
//  Created by Родыгин Дмитрий on 21.10.15.
//  Copyright © 2015 Родыгин Дмитрий. All rights reserved.
//

import UIKit

extension Double {
    var square : Double {return self * self}
}

class ViewController: UIViewController {
    
    var firstValue : Double? = nil
    var secondValue : Double? = nil
    var tempValue : Double? = nil
    var lastSign : String = ""
    var checkButton = false
    var checkEqual = false
    
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
    
    func calculateIt (sign : String) {
        checkEqual ? (firstValue = Double(displayLabel.text!)) : (secondValue = Double(displayLabel.text!))
        checkButton = true
        
        switch(sign) {
        case "√" : tempValue = sqrt(Double(displayLabel.text!)!)
        case "x²" : tempValue = Double(displayLabel.text!)!.square
        case "%" : firstValue != nil ? (tempValue = (secondValue! * firstValue!) / 100) : (tempValue = (secondValue! * 1) / 100)
        case "¹/x": displayLabel.text! != "0" ? (tempValue = 1 / Double(displayLabel.text!)!) : (displayLabel.text = "Error")
        default: break
        }
        if (firstValue != nil && secondValue != nil) {
            switch(sign) {
            case "+" : tempValue = firstValue! + secondValue!
            case "-" : tempValue = firstValue! - secondValue!
            case "×" : tempValue = firstValue! * secondValue!
            case "÷" : tempValue = firstValue! / secondValue!
            default: break
            }
        }
        if (tempValue != nil) {
            displayLabel.text = String(format: "%g", tempValue!)
        }
    }
    
    func signPress () {
        firstValue = Double(displayLabel.text!)
        checkButton = true
        checkEqual = false
    }
    
    func clearDisplay () {
        firstValue = nil
        secondValue = nil
        tempValue = nil
        lastSign = ""
        checkButton = false
        checkEqual = false
        displayLabel.text = "0"
        operationsLabel.text! = ""
    }
    
    func deleteLastSymbol() {
        displayLabel.text?.removeAtIndex(displayLabel.text!.endIndex.predecessor())
        if(displayLabel.text!.isEmpty) {
            displayLabel.text = "0"
        }
    }
    
    func checkDisplayLengh ( buttonLabel : String) {
        if (displayLabel.text?.characters.count < 10) {
            displayLabel.text?.appendContentsOf(buttonLabel)
        }
    }
    
    func operationDisplay(lblButton : String) {
        if (!checkButton || operationsLabel.text == "") {
            operationsLabel.text?.appendContentsOf(" " + displayLabel.text! + " " + lblButton)
        }
        else {
            operationsLabel.text?.removeAtIndex(operationsLabel.text!.endIndex.predecessor())
            operationsLabel.text?.appendContentsOf(lblButton)
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
            case "+", "-", "÷", "×": operationDisplay(buttonLabel)
                                     tempValue = Double(display)!
                                     if (!checkButton && !checkEqual) {
                                        calculateIt(lastSign)
                                     }
                                     lastSign = buttonLabel
                                     signPress()
                                     setButtonBorder(3, sender)
                
            case "√", "%", "¹/x", "x²": calculateIt(buttonLabel)
                                        lastSign = buttonLabel
                                        checkEqual = true
                
            case "C": clearDisplay()
                
            case "CE": displayLabel.text = "0"
                
            case "←": deleteLastSymbol()
                
            case "±": if (display[display.startIndex] != "-" && display != "0") {
                         displayLabel.text?.insert("-", atIndex: display.startIndex)
                      }
                      else if (display[display.startIndex] == "-") {
                         displayLabel.text?.removeAtIndex(display.startIndex)
                      }
                
            case ",": if(!display.containsString(".") && !checkEqual) {
                        checkDisplayLengh(".")
                      }
                
            case "=": calculateIt(lastSign)
                      checkEqual = true
                      operationsLabel.text! = ""
            default: break
            }
        }
    }
}

