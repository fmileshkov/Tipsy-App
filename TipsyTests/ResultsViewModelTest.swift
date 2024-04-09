//
//  ResultsViewModelTest.swift
//  TipsyTests
//
//  Created by Admin on 2.08.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import XCTest
import Combine
@testable import Tipsy

final class ResultsViewModelTest: XCTestCase {

    //MARK: - Properties
    var viewModel: ResultsViewModelProtocol!
    var mockDelegate: MockDelegate!

    //MARK: - SetUp
    override func setUp() {
        mockDelegate = MockDelegate()
        viewModel = ResultsViewModel(calculatorModel: CalculatorModel(numOfPeople: "2", percentage: "10", billAmount: "200"), delegate: mockDelegate)
    }

    func testReloadData() {
        // Given
        
        // When
        viewModel.reloadData()
        
        // Then
        XCTAssertEqual(mockDelegate.isDataReloaded, true)
    }

    //MARK: - Test methods

    func testInit() {
        // Given

        // When

        // Then
        XCTAssertEqual(viewModel.calculatorModel.value.percentage, "10")
        XCTAssertEqual(viewModel.calculatorModel.value.billAmount, "200")
        XCTAssertEqual(viewModel.calculatorModel.value.numOfPeople, "2")
    }


}
