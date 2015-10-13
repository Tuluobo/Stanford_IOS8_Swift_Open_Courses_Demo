//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by WangHao on 15/9/26.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op:CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String, (Double,Double) -> Double)
        
        var description:String {
            get{
                switch self{
                case .Operand(let operand):return "\(operand)"
                case .UnaryOperation(let symbol, _):return "\(symbol)"
                case .BinaryOperation(let symbol, _):return "\(symbol)"
                }
            }
        }
    }
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init(){
        func learnOp(op:Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷") { $1/$0 })
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−") { $1-$0 })
        learnOp(Op.UnaryOperation("√",sqrt))
    }
    
    func pushOperand(operand:Double)->Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol:String)->Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    
    func evaluate() -> Double? {
        let (result,remainder) = self.evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    private func evaluate(ops:[Op]) -> (result: Double?,remainingOps:[Op]) {
        if !ops.isEmpty {
            var remainOps = ops
            let op = remainOps.removeLast()
            switch op{
                case .Operand(let operand):
                    return (operand,remainOps)
                case .UnaryOperation(_, let operation):
                    let operandEvaluation = self.evaluate(remainOps)
                    if let operand = operandEvaluation.result{
                        return (operation(operand),operandEvaluation.remainingOps)
                    }
                case .BinaryOperation(_, let operation):
                    let op1Evaluation = self.evaluate(remainOps)
                    if let operand1 = op1Evaluation.result {
                        let op2Evaluation = self.evaluate(op1Evaluation.remainingOps)
                        if let operand2 = op2Evaluation.result{
                            return (operation(operand1,operand2),op2Evaluation.remainingOps)
                        }
                    }
            }
            
        }
        return (nil,ops)
    }
}