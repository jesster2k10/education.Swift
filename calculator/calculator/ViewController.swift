//
//  ViewController.swift
//  calculator
//
//  Created by Родыгин Дмитрий on 21.10.15.
//  Copyright © 2015 Родыгин Дмитрий. All rights reserved.
//

import UIKit

var tempOneValue : Int? = 0
var tempTwoValue : Int? = 0
var tempSign : String = ""
var equalCheck : Bool = false
var signCheck : Bool = false


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
        let display : Int? = Int(displayLabel.text!)
        
        if let text = sender.titleLabel?.text {
            switch(text) {
            case "1","2","3","4","5","6","7","8","9","0": displayLabel.text?.appendContentsOf(text)
                
            case "+", "-": //TO simplify:
                           if (displayLabel.text != "") { displayLabel.placeholder = displayLabel.text }
            
                           displayLabel.text = nil
                           //If sign push twice:
                           if (signCheck) {
                                tempTwoValue = display
                                displayLabel.placeholder = calculate(tempOneValue, tempTwoValue ,tempSign)
                           }
                           signCheck = true
                           
                           tempOneValue = Int(displayLabel.placeholder!)!
                           tempSign = sender.titleLabel!.text!
                           equalCheck = false
                
            case "C": displayLabel.text = nil
                      displayLabel.placeholder = "0"
                      tempSign = ""
                      signCheck = false
            default: if (!equalCheck && displayLabel.text != "") {
                        tempTwoValue = display
                        displayLabel.text = calculate(tempOneValue, tempTwoValue ,tempSign)
                        equalCheck = true }
                     else if(equalCheck && displayLabel.text != "") {
                        displayLabel.text = calculate(display, tempTwoValue ,tempSign)
                     }
                     signCheck = false
            }
        }
    }
    
    func calculate(oldValue : Int?, _ newValue : Int?, _ sign : String) -> String {
        switch(sign) {
        case "+": return String(newValue! + oldValue!)
        case "-": return String(oldValue! - newValue!)
        default: return String(newValue!)
        }
    }
}

