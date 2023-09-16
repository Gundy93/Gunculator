//
//  ViewModel.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

import Foundation

final class CalculatorViewModel {
    
    private var useCase: CalculatorUseCase
    private var currentOperator: Operator?
    private(set) var inputted: String = String()
    private(set) var expressions: [String] = []
    private let numberFormatter: NumberFormatter = NumberFormatter()
    
    init(useCase: CalculatorUseCase = DefaultCalculatorUseCase(currentValue: .zero)) {
        self.useCase = useCase
    }
    
    func input(_ number: String) {
        if number == "0" {
            guard inputted != "0" else { return }
        }
        inputted += number
    }
    
    func operate(by `operator`: Operator) {
        switch `operator` {
        case .backspace:
            removeLast()
        case .clear:
            clear()
        case .signChange:
            changeSign()
        case .equals:
            makeResult()
        default:
            calculate(by: `operator`)
        }
    }
    
    private func removeLast() {
        let _ = inputted.popLast()
    }
    
    private func clear() {
        let _ = useCase.operate(by: .clear, with: nil)
        inputted.removeAll()
        expressions.removeAll()
    }
    
    private func changeSign() {
        if inputted.first == "-" {
            inputted.removeFirst()
        } else {
            inputted = "-" + inputted
        }
    }
    
    private func makeResult() {
        calculate(by: nil)
        guard let result = numberFormatter.string(from: useCase.currentValue as NSNumber) else { return }
        
        inputted = result
    }
    
    private func calculate(by `operator`: Operator?) {
        defer { currentOperator = `operator` }
        guard let number = Double(inputted) else { return }
        let decimal = Decimal(number)
        guard let current = currentOperator else {
            useCase.setCurrentValue(decimal)
            inputted.removeAll()
            return
        }
        let leftOperand = useCase.currentValue
        let result = useCase.operate(by: current, with: decimal)
        
        appendExpression(lhs: leftOperand, sign: current, rhs: decimal, result: result)
    }
    
    private func appendExpression(lhs: Decimal, sign: Operator, rhs: Decimal, result: Decimal) {
        guard let lhs = numberFormatter.string(from: lhs as NSNumber),
              let rhs = numberFormatter.string(from: rhs as NSNumber),
              let result = numberFormatter.string(from: result as NSNumber) else { return }
        let sign = sign.rawValue
        let expression = "\(lhs) \(sign) \(rhs) = \(result)"
        
        expressions.append(expression)
        inputted.removeAll()
    }
}
