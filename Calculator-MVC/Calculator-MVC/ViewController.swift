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
    
    private var model = CalculatorModel()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTipping {
            model.setOperand(displayValue)
            userIsInTheMiddleOfTipping = false
        }
        
        if let mathSymbol = sender.currentTitle {
            model.performOperation(mathSymbol)
        }
        
        if let result = model.result {
            displayValue = result
        }
        
        

    }
    
}

