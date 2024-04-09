//
//  ResultsCoordinator.swift
//  Tipsy
//
//  Created by Admin on 16.09.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

protocol ResultsCoordinatorProtocol: AnyObject {
    
    /// This method will handle popping the navigation stack to return to the calculator
    /// screen and resetting the view model state.
    func backToFreshCalculation()
    
    /// Finish The Coordinator !!!
    /// The base class automatically handles memory management:
    func finish()
}

class ResultsCoordinator: Coordinator, ResultsCoordinatorProtocol {
    
    //MARK: - Properties
    var navigationController: UINavigationController
    private weak var delegate: ResultsViewModelDelegate?
    private let calculatorModel: CalculatorModel
    
    //MARK: - Initializer
    init(navigationController: UINavigationController, delegate: ResultsViewModelDelegate?, calculatorModel: CalculatorModel) {
        self.navigationController = navigationController
        self.delegate = delegate
        self.calculatorModel = calculatorModel
    }

    //MARK: - Methods
    override func start() {
        let vc = ResultsViewController.instantiate()
        vc.resultsViewModel = ResultsViewModel(calculatorModel: calculatorModel, delegate: delegate, coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    //MARK: - ResultsCoordinator Protocol
    func backToFreshCalculation() {
        delegate?.reloadModelData()
        finish()
        navigationController.popViewController(animated: true)
    }

}
