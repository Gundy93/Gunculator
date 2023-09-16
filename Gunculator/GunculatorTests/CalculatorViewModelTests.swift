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
}
