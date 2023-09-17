//
//  ViewModel.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

import Foundation

final class CalculatorViewModel {
    
    weak var delegate: CalculatorViewModelDelegate?
    private var useCase: CalculatorUseCase
    private var currentOperator: Operator? {
        didSet {
            delegate?.viewModel(willDisplaySign: currentOperator?.rawValue)
        }
    }
    private(set) var inputted: String = String() {
        didSet {
            delegate?.viewModel(willDisplayNumber: text)
        }
    }
    private var text: String? {
        let text = inputted.isEmpty ? "0" : inputted
        guard let decimal = Decimal(string: text) else { return text }
        
        return numberFormatter.string(from: decimal as NSNumber)
    }
    private(set) var expressions: [String] = []
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.maximumFractionDigits = 10
        
        return numberFormatter
    }()
    
    init(useCase: CalculatorUseCase = DefaultCalculatorUseCase(currentValue: .zero)) {
        self.useCase = useCase
    }
    
    func input(_ number: String) {
        if currentOperator == .equals {
            currentOperator = nil
            inputted.removeAll()
        }
        guard validate() else { return }
        switch number {
        case ".":
            guard inputted.contains(".") == false else { return }
            if inputted.isEmpty {
                inputted = "0"
            }
        case "0":
            guard inputted != "0" else { return }
        default:
            break
        }
        inputted += number
    }
    
    private func validate() -> Bool {
        let maximumDigits = inputted.contains(".") ? 15 : 14
        
        return inputted.count <= maximumDigits
    }
    
    func operate(by `operator`: Operator) {
        switch `operator` {
        case .backspace:
            removeLast()
        case .clear:
            clear()
            delegate?.viewModelDidClear()
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
        currentOperator = nil
    }
    
    private func changeSign() {
        if inputted.first == "-" {
            inputted.removeFirst()
        } else if inputted.isEmpty == false {
            inputted = "-" + inputted
        }
    }
    
    private func makeResult() {
        calculate(by: .equals)
        inputted = String(describing: useCase.currentValue)
    }
    
    private func calculate(by `operator`: Operator?) {
        defer { currentOperator = `operator` }
        guard let number = Decimal(string: inputted) else { return }
        guard let current = currentOperator,
              current != .equals else {
            useCase.setCurrentValue(number)
            inputted.removeAll()
            return
        }
        let leftOperand = useCase.currentValue
        let result = useCase.operate(by: current, with: number)
        
        appendExpression(lhs: leftOperand, sign: current, rhs: number, result: result)
    }
    
    private func appendExpression(lhs: Decimal, sign: Operator, rhs: Decimal, result: Decimal) {
        guard let lhs = numberFormatter.string(from: lhs as NSNumber),
              let rhs = numberFormatter.string(from: rhs as NSNumber),
              let result = numberFormatter.string(from: result as NSNumber) else { return }
        let sign = sign.rawValue
        let expression = "\(lhs) \(sign) \(rhs) = \(result)"
        
        expressions.append(expression)
        delegate?.viewModel(willAppend: expression)
        inputted.removeAll()
    }
}
