//
//  ViewController.swift
//  Calculator-MVC
//
//  Created by Martin Vacas on 9/8/17.
//  Copyright © 2017 Martin Vacas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTipping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTipping {
            let currentlyTextInDisplay = display.text!
            display.text = currentlyTextInDisplay + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTipping = true
        }
    }

    //Computed Variable
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text! = String(newValue)
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        let mathSymbol = sender.currentTitle!
        
        switch mathSymbol {
            
        case "π":
            displayValue = Double.pi
            
        case "√":
            displayValue = sqrt(displayValue)
            userIsInTheMiddleOfTipping = false
            
        default:
            break
        }
    }
    
}

