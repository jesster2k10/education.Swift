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
    var dotCheck = false
    
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
    
    
    func signPress () {
        if (checkSign) {
            secondValue = Double(displayLabel.text!)
        }
        else if (!checkSign) {
            firstValue = Double(displayLabel.text!)
        }
        checkEqual = false
        checkSign = true
        checkButton = true
        dotCheck = false

    }
    
    func clearDisplay () {
        firstValue = nil
        secondValue = nil
        checkEqual = false
        checkSign = false
        checkButton = false
        dotCheck = false
        displayLabel.text = "0"
    }
        
    @IBOutlet weak var displayLabel: UILabel!
    @IBAction func allButton(sender : UIButton) {
        //let display = displayLabel.text!
        if let buttonLabel = sender.titleLabel?.text {
            switch(buttonLabel) {
            case "1","2","3","4","5","6","7","8","9","0": if (displayLabel.text == "0") { displayLabel.text = "" }
                                                          if (checkButton) { displayLabel.text = "" }
                                                          displayLabel.text?.appendContentsOf(buttonLabel)
                                                          checkButton = false
            case "+", "-", "/", "*", "%": if (checkSign && !checkButton) {
                                            calculateIt()
                                            firstValue = Double(displayLabel.text!)}
                                          signPress()
                                          lastSign = buttonLabel
            case "C": clearDisplay()
            case ".": if(!dotCheck) { displayLabel.text?.appendContentsOf(".")
                        dotCheck = true}
            case "=": calculateIt()
            default: break
            }
        }
    }
    
}

