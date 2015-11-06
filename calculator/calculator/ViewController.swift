//
//  ViewController.swift
//  calculator
//
//  Created by Родыгин Дмитрий on 21.10.15.
//  Copyright © 2015 Родыгин Дмитрий. All rights reserved.
//

import UIKit

var tempValue : Int = 0
var tempSign : String = ""

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var titleButtons: UIButton!
    
    @IBAction func allButton(sender : UIButton) {
        if let text = sender.titleLabel?.text {
            switch(text) {
            case "1","2","3","4","5","6","7","8","9","0": displayLabel.text?.appendContentsOf(text)
            case "+", "-": tempValue = Int(displayLabel.text!)!
                           tempSign = sender.titleLabel!.text!
                           displayLabel.text = ""
            case "C": displayLabel.text = ""
            default: displayLabel.text = calculate(tempValue, Int(displayLabel.text!)! ,tempSign)
            }
        }
    }
}

func calculate(oldValue : Int, _ newValue : Int, _ sign : String) -> String {
    tempValue = oldValue
    switch(sign) {
        case "+": return String(newValue + oldValue)
        default: return "0"
    }
}