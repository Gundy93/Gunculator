//
//  CalculatorViewModelDelegate.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

protocol CalculatorViewModelDelegate {
    
    func viewModel(willDisplay inputted: String)
    func viewModel(willAppend expression: String)
}
