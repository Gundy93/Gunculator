//
//  DefaultCalculatorUseCase.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

import Foundation

struct DefaultCalculatorUseCase: CalculatorUseCase {
    
    var currentValue: Decimal
    
    func operate(by operator: Operaotor, with operand: Decimal?) -> Decimal {
        return .zero
    }
}
