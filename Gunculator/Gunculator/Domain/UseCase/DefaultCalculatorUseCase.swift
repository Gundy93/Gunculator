//
//  DefaultCalculatorUseCase.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

import Foundation

struct DefaultCalculatorUseCase: CalculatorUseCase {
    
    var currentValue: Decimal
    
    mutating func operate(by `operator`: Operator, with operand: Decimal?) -> Decimal {
        switch `operator` {
        case .add, .subtract, .multifly, .divide:
            guard let operand else { break }
            calculate(by: `operator`, with: operand)
        case .clear:
            currentValue = .zero
        default:
            break
        }
        return currentValue
    }
    
    private mutating func calculate(by `operator`: Operator, with operand: Decimal) {
        switch `operator` {
        case .add:
            currentValue += operand
        case .subtract:
            currentValue -= operand
        case .multifly:
            currentValue *= operand
        case .divide:
            currentValue /= operand
        default:
            break
        }
    }
    
    mutating func setCurrentValue(_ number: Decimal) {
        currentValue = number
    }
}
