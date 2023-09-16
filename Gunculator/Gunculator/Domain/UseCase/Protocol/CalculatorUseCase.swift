//
//  CalculatorUseCase.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

import Foundation

protocol CalculatorUseCase {
    
    var currentValue: Decimal { get set }
    
    mutating func operate(by `operator`: Operaotor, with operand: Decimal?) -> Decimal
}
