//
//  ResultsViewModel.swift
//  Tipsy
//
//  Created by Admin on 1.08.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
import Combine

protocol ResultsViewModelProtocol {
    
    /// This CurrentValueSubject contains the CalculatorModel which holds all of the data needed to display the results.
    var calculatorModel: CurrentValueSubject<CalculatorModel, Never> { get }
    
    /// Reloads the view model data and triggers an update of the subscribed views.
    func reloadData()
}

protocol ResultsViewModelDelegate: AnyObject {
    
    /// Reloads calculator model data
    func reloadModelData()
}

class ResultsViewModel: ResultsViewModelProtocol {

    //MARK: - Properties
    private weak var delegate: ResultsViewModelDelegate?
    var calculatorModel: CurrentValueSubject<CalculatorModel, Never>
    private weak var coordinator: ResultsCoordinatorProtocol?
    
    //MARK: - Initializator
    init(calculatorModel: CalculatorModel, delegate: ResultsViewModelDelegate?, coordinator: ResultsCoordinatorProtocol?) {
        self.calculatorModel = CurrentValueSubject(calculatorModel)
        self.delegate = delegate
        self.coordinator = coordinator
    }
    
    //MARK: - ResultsViewModelProtocol
    func reloadData() {
        coordinator?.backToFreshCalculation()
    }
    
}
