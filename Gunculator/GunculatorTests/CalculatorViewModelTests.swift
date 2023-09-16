//
//  CalculatorViewModelTests.swift
//  GunculatorTests
//
//  Created by Gundy on 2023/09/16.
//

import XCTest
@testable import Gunculator

final class CalculatorViewModelTests: XCTestCase {
    
    var sut: CalculatorViewModel!

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_input에_5를전달하면_inputted가5가된다() {
        // given
        sut = CalculatorViewModel()
        
        // when
        sut.input("5")
        
        // then
        XCTAssertEqual(sut.inputted, "5")
    }
    
    func test_input에_차례대로1_2_3을전달하면_inputted가123이된다() {
        // given
        sut = CalculatorViewModel()
        
        // when
        for number in 1...3 {
            sut.input("\(number)")
        }
        
        // then
        XCTAssertEqual(sut.inputted, "123")
    }
    
    func test_inputted가123일때_operate에backspace를전달하면_inputted가12가된다() {
        // given
        sut = CalculatorViewModel()
        for number in 1...3 {
            sut.input("\(number)")
        }
        
        // when
        sut.operate(by: .backspace)
        
        // then
        XCTAssertEqual(sut.inputted, "12")
    }
    
    func test_inputted가123일때_operate에signChange를전달하면_inputted가마이너스123이된다() {
        // given
        sut = CalculatorViewModel()
        for number in 1...3 {
            sut.input("\(number)")
        }
        
        // when
        sut.operate(by: .signChange)
        
        // then
        XCTAssertEqual(sut.inputted, "-123")
    }
    
    func test_123을입력하고add를전달한뒤_123을입력하고equals를전달하면_inputted가246이된다() {
        // given
        sut = CalculatorViewModel()
        for number in 1...3 {
            sut.input("\(number)")
        }
        sut.operate(by: .add)
        
        // when
        for number in 1...3 {
            sut.input("\(number)")
        }
        sut.operate(by: .equals)
        
        // then
        XCTAssertEqual(sut.inputted, "246")
    }
    
    func test_divide를전달한뒤_0을입력하고equals를전달하면_inputted가NaN이된다() {
        // given
        sut = CalculatorViewModel()
        for number in 1...3 {
            sut.input("\(number)")
        }
        sut.operate(by: .divide)
        
        // when
        sut.input("0")
        sut.operate(by: .equals)
        
        // then
        XCTAssertEqual(sut.inputted, "NaN")
    }
}
