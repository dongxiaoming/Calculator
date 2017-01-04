//
//  CalculatorBrain.swift
//  calculator
//
//  Created by dongluis on 2017/01/03.
//  Copyright © 2017 dongxiaoming. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand (operand: Double) {
        accumulator = operand
    }

    var operations: Dictionary<String, Operation> = [
        "∏": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "sin": Operation.UnaryOperation(sin),
        "+": Operation.BinaryOperation{$0+$1},
        "-": Operation.BinaryOperation{$0-$1},
        "×": Operation.BinaryOperation{$0*$1},
        "÷": Operation.BinaryOperation{$0/$1},
        "=": Operation.Equals    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    private var pending: PendingBinaryOerationInfo?
    
    struct PendingBinaryOerationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOerationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = (pending!.binaryFunction((pending!.firstOperand),accumulator))
            pending = nil
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
