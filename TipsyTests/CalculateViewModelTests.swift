//
//  TipsyTests.swift
//  TipsyTests
//
//  Created by Admin on 1.08.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import XCTest
import Combine
@testable import Tipsy

final class CalculateViewModelTests: XCTestCase {
    
    //MARK: - Properties
    var viewModel: CalculatorViewModel!
    
    //MARK: - SetUp
    override func setUp() {
        viewModel = CalculatorViewModel()
    }
    
    //MARK: - Test methods
    func testSetTip() {
        // Given
        
        // When
        viewModel.setTip("10")
        
        // Then
        XCTAssertEqual(viewModel.percentage.value, "10")
    }
    
    func testSetNumberOfPeople() {
        // Given
        
        // When
        viewModel.setNumberOfPeople(2.5)
        
        // Then
        XCTAssertEqual(viewModel.numberOfPeople.value, "2")
    }
    
    func testCalculateAmountPerPerson() {
        // Given
        
        // When
        viewModel.calculateAmountPerPerson("200")
        
        // Then
        XCTAssertEqual(viewModel.calcModel.value?.billAmount, "200.00")
    }
    
}
