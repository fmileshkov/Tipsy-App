//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Combine

class CalculatorViewController: UIViewController, ResultsViewModelDelegate, LoadFromStoryboard {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var billTextField: UITextField!
    @IBOutlet private weak var zeroPctButton: UIButton!
    @IBOutlet private weak var tenPctButton: UIButton!
    @IBOutlet private weak var twentyPctButton: UIButton!
    @IBOutlet private weak var splitNumberLabel: UILabel!
    
    // MARK: - Properties
    private var cancellables: [AnyCancellable] = []
    var calculatorViewModel: CalculatorViewModelProtocol?
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
    }

    //MARK: - Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    private func setUpBinders() {
        calculatorViewModel?.numberOfPeople.sink { [weak self] numOfPeople in

            self?.splitNumberLabel.text = numOfPeople
        }.store(in: &cancellables)
    }
    
    func reloadModelData() {
        billTextField.text = ""
        splitNumberLabel.text = "1"
        buttonsSetUp()
    }
    
    private func buttonsSetUp() {
        billTextField.endEditing(false)
        twentyPctButton.isSelected = false
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
    }

    // MARK: - IBActions
    @IBAction private func tipChanged(_ sender: UIButton) {
        guard let currentTitle = sender.currentTitle else { return }
        
        buttonsSetUp()
        sender.isSelected = true
        calculatorViewModel?.setTip(currentTitle)
    }
    
    @IBAction private func stepperValueChanged(_ sender: UIStepper) {
        calculatorViewModel?.setNumberOfPeople(sender.value)
    }
    
    @IBAction private func calculateButton(_ sender: UIButton) {
        guard let billAmount = billTextField.text else { return }
        
        calculatorViewModel?.calculateAmountPerPerson(billAmount)
    }
    
}
