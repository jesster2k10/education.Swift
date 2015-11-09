//
//  ViewController.swift
//  calculator
//
//  Created by Родыгин Дмитрий on 21.10.15.
//  Copyright © 2015 Родыгин Дмитрий. All rights reserved.
//

import UIKit

var tempOneValue : Float? = 0
var tempTwoValue : Float? = 0
var tempSign : String = ""
var equalCheck : Bool = false
var signCheck : Bool = false
var dotCheck : Bool = false
var numberCheck : Bool = false

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var titleButtons: UIButton!
    @IBOutlet weak var displayLabel: UITextField!
    
    
    
    @IBAction func allButton(sender : UIButton) {
        let display : Float? = Float(displayLabel.text!)
        
        if let text = sender.titleLabel?.text {
            switch(text) {
            case "1","2","3","4","5","6","7","8","9","0": displayLabel.text?.appendContentsOf(text)
                                                          if (!numberCheck) { dotCheck = true }
                
            case "+", "-", "/", "*": //TO simplify:
                                    if (displayLabel.text != "") { displayLabel.placeholder = displayLabel.text }
            
                                    //If sign push twice:
                                    if (signCheck && displayLabel.text != "") {
                                        tempTwoValue = display
                                        displayLabel.placeholder = calculate(tempOneValue, tempTwoValue ,tempSign)
                                    }
                                    signCheck = true
                                    
                                    displayLabel.text = nil
                                    tempOneValue = Float(displayLabel.placeholder!)!
                                    tempSign = sender.titleLabel!.text!
                                    equalCheck = false
                                    numberCheck = false
                
            case "C": displayLabel.text = nil
                      displayLabel.placeholder = "0"
                      tempSign = ""
                      signCheck = false
                      numberCheck = false
                
            case ".": if (dotCheck) { displayLabel.text?.appendContentsOf(text) }
                      dotCheck = false
                      numberCheck = true
                
            default: if (!equalCheck && displayLabel.text != "") {
                        tempTwoValue = display
                        displayLabel.text = calculate(tempOneValue, tempTwoValue ,tempSign)
                        equalCheck = true }
                     else if(equalCheck && displayLabel.text != "") {
                        displayLabel.text = calculate(display, tempTwoValue ,tempSign)
                     }
                     signCheck = false
                     numberCheck = false
            }
        }
    }
    
    func calculate(oldValue : Float?, _ newValue : Float?, _ sign : String) -> String {
        switch(sign) {
        case "+": return String(newValue! + oldValue!)
        case "-": return String(oldValue! - newValue!)
        case "/": return String(oldValue! / newValue!)
        default: return String(newValue!)
        }
    }
}

