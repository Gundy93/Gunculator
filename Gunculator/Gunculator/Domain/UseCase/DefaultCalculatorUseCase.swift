//
//  DefaultCalculatorUseCase.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

import Foundation

struct DefaultCalculatorUseCase: CalculatorUseCase {
    
    var currentValue: Decimal = .zero
    
    func operate(by operator: Operaotor, with operand: Decimal?) -> Decimal {
        return .zero
    }
}
