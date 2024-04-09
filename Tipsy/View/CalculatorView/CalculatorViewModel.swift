//
//  CalculatorViewBrain.swift
//  Tipsy
//
//  Created by Admin on 6.05.23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
import Combine

protocol CalculatorViewModelProtocol {
    
    /// This CurrentValueSubject contains the percentage tip amount as a string.
    var percentage: CurrentValueSubject<String, Never> { get }

    /// This CurrentValueSubject contains the number of people splitting the bill as a string.
    var numberOfPeople: CurrentValueSubject<String, Never> { get }
    
    /// Sets the tip percentage based on the title of the selected tip button, expressed as a string
    /// - Parameter percentage: The tip percentage as a string
    func setTip(_ percentage: String)

    /// Sets the number of people that the bill will be split among.
    /// - Parameter numOfPeople: The number of people the bill is split between
    func setNumberOfPeople(_ numOfPeople: Double)
    
    /// Calculates the final bill amount per person by applying the tip percentage to the total bill, dividing by the number of people, and rounding to 2 decimal places. Emits the updated model through the calcListener publisher.
    /// - Parameter billAmount: The total bill amount
    func calculateAmountPerPerson(_ billAmount: String)
}

class CalculatorViewModel: CalculatorViewModelProtocol {

    //MARK: - Properties
    var percentage: CurrentValueSubject<String, Never> = CurrentValueSubject("0")
    var numberOfPeople: CurrentValueSubject<String, Never> = CurrentValueSubject("1")
    private weak var coordinator: MainCoordinatorProtocol?
    
    //MARK: - Initializer
    init(coordinator: MainCoordinatorProtocol?) {
        self.coordinator = coordinator
        
    }
    
    //MARK: - CalculatorViewModelProtocol
    func setTip(_ percentage: String) {
        self.percentage.send(percentage)
    }
    
    func setNumberOfPeople(_ numOfPeople: Double) {
        numberOfPeople.send(String(Int(numOfPeople)))
    }
    
    func calculateAmountPerPerson(_ billAmount: String) {
        guard let billAmount = Double(billAmount) else { return }
        
        let tip = (Double(percentage.value.dropLast()) ?? 0) / 100
        let total = (tip * billAmount) + billAmount
        let formatedBillAmount = String(format: "%.2f", total / (Double(numberOfPeople.value) ?? 1))
        let calc = CalculatorModel(numOfPeople: numberOfPeople.value, percentage: percentage.value, billAmount: formatedBillAmount)
        coordinator?.calculatedResult(calculatorModel: calc)
    }
    
}

