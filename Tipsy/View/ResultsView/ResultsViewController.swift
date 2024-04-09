//
//  SecondVc.swift
//  Tipsy
//
//  Created by Admin on 5.05.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit
import Combine

class ResultsViewController: UIViewController, LoadFromStoryboard {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var settingsLabel: UILabel!
    
    // MARK: - Properties
    var resultsViewModel: ResultsViewModelProtocol?
    private var cancellables: [AnyCancellable] = []
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
    }
    
    //MARK: - Private
    private func setUpBinders() {
        resultsViewModel?.calculatorModel.sink { [weak self] calcModel in
            guard let self else { return }
            
            self.totalLabel.text = calcModel.billAmount
            self.settingsLabel.text = "Split between \(calcModel.numOfPeople) people, with \(calcModel.percentage) tip."
        }.store(in: &cancellables)
        
    }

    // MARK: - IBActions
    @IBAction func recalculateButton(_ sender: UIButton) {
        resultsViewModel?.reloadData()
    }
    
}
