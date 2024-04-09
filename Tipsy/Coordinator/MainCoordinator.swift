//
//  MainCoordinator.swift
//  Tipsy
//
//  Created by Admin on 16.09.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    
    /// This method will be called by the calculator view model when the user
    /// completes a calculation. The coordinator then handle presenting the
    /// results screen with the provided calculator model data.
    /// - Parameter calculatorModel: The calculator model containing the results of the
    ///   calculation to display.
    func calculatedResult(calculatorModel: CalculatorModel)
}

class MainCoordinator: Coordinator, MainCoordinatorProtocol {

    //MARK: - Properties
    var rootViewController: UINavigationController
    private weak var delegate: ResultsViewModelDelegate?
    
    //MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.rootViewController = navigationController
    }
    
    //MARK: - Methods
    override func start() {
        let vc = CalculatorViewController.instantiate()
        
        delegate = vc.self
        vc.calculatorViewModel = CalculatorViewModel(coordinator: self)
        rootViewController.pushViewController(vc, animated: true)
    }

    //MARK: - MainCoordinator Protocol
    func calculatedResult(calculatorModel: CalculatorModel) {
        let child = ResultsCoordinator(navigationController: rootViewController, delegate: delegate, calculatorModel: calculatorModel)
        addChildCoordinator(child)
        child.start()
    }

}
