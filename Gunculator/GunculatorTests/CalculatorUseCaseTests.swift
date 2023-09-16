//
//  GunculatorTests.swift
//  GunculatorTests
//
//  Created by Gundy on 2023/09/16.
//

import XCTest
@testable import Gunculator

final class CalculatorUseCaseTests: XCTestCase {
    
    var sut: CalculatorUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = .none
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_currentValue가5일때_add와5를전달하여operate를호출하면_10을반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: 5)
        
        // when
        let result = sut.operate(by: .add, with: 5)
        
        // then
        XCTAssertEqual(result, 10)
    }
    
    func test_currentValue가10일때_subtract와5를전달하여operate를호출하면_5를반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: 10)
        
        // when
        let result = sut.operate(by: .subtract, with: 5)
        
        // then
        XCTAssertEqual(result, 5)
    }
    
    func test_currentValue가3일때_multifly와5를전달하여operate를호출하면_15를반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: 3)
        
        // when
        let result = sut.operate(by: .multifly, with: 5)
        
        // then
        XCTAssertEqual(result, 15)
    }
    
    func test_currentValue가10일때_divide와5를전달하여operate를호출하면_2를반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: 10)
        
        // when
        let result = sut.operate(by: .divide, with: 5)
        
        // then
        XCTAssertEqual(result, 2)
    }
    
    func test_currentValue가1023일때_clear와nil을전달하여operate를호출하면_0을반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: 1023)
        
        // when
        let result = sut.operate(by: .clear, with: nil)
        
        // then
        XCTAssertEqual(result, 0)
    }
    
    func test_currentValue가10일때_signChange와nil을전달하여operate를호출하면_음수를반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: 10)
        
        // when
        let result = sut.operate(by: .signChange, with: nil)
        
        // then
        XCTAssertLessThan(result, 0)
    }
    
    func test_currentValue가음수일때_signChange와nil을전달하여operate를호출하면_양수를반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: -10)
        
        // when
        let result = sut.operate(by: .signChange, with: nil)
        
        // then
        XCTAssertGreaterThan(result, 0)
    }
    
    func test_currentValue가1023일때_equals와nil을전달하여operate를호출하면_1023를반환한다() {
        // given
        sut = DefaultCalculatorUseCase(currentValue: 1023)
        
        // when
        let result = sut.operate(by: .equals, with: nil)
        
        // then
        XCTAssertGreaterThan(result, 1023)
    }
}
