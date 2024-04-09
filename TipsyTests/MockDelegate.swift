//
//  MockDelegate.swift
//  TipsyTests
//
//  Created by Admin on 3.08.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
@testable import Tipsy

class MockDelegate: ResultsViewModelDelegate {
    var reloadedModel: CalculatorModel?
    var isDataReloaded = false
    
    func reloadModelData() {
        isDataReloaded = true
    }
}
