//
//  ViewController.swift
//  calculator
//
//  Created by dongxiaoming on 4/19/15.
//  Copyright (c) 2015 dongxiaoming. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = true
    }
    private var brain = CalculatorBrain()

    @IBAction private func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathmatialSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathmatialSymbol)
            displayValue = brain.result
        }
    }
    
}

