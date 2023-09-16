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
    
    init(useCase: CalculatorUseCase = DefaultCalculatorUseCase(currentValue: .zero)) {
        self.useCase = useCase
    }
    
    func input(_ number: String) {}
    
    func operate(by `operator`: Operator) {}
}
