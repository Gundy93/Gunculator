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
}
