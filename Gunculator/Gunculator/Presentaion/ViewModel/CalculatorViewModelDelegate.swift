//
//  CalculatorViewModelDelegate.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

protocol CalculatorViewModelDelegate {
    
    func viewModel(willDisplayNumber inputted: String?)
    func viewModel(willDisplaySign inputted: String?)
    func viewModel(willAppend expression: String)
    func viewModelDidClear()
}
