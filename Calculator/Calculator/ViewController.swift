//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var decimalButtons: [CircularButton]!
    @IBOutlet var binaryButtons: [CircularButton]!
    
    private var calculators: [CalculatorMode : BasicCalculable] = [
        .decimal : DecimalCalculator(),
        .binary : BinaryCalculator()
    ]
    
//    private var decimalCalculator = DecimalCalculator()
//    private var binaryCalculator = BinaryCalculator()
    
    private var calculatorMode: CalculatorMode = .decimal {
        didSet {
            if calculatorMode == .decimal {
                setUpDecimalUI()
            }
            else {
                setUpBinaryUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Set Up UI
    private func setUpDecimalUI() {
        for button in binaryButtons {
            button.isHidden = true
        }
        for button in decimalButtons {
            button.isHidden = false
        }
    }
    private func setUpBinaryUI() {
        for button in decimalButtons {
            button.isHidden = true
        }
        for button in binaryButtons {
            button.isHidden = false
        }
    }
    
    // MARK: - Basic Operator Button
    @IBAction func tapClearButton(_ sender: Any) {
        guard let calculator = calculators[self.calculatorMode] else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        calculator.clear()
    }
    private func clearDecimalCalculator() {
        
    }
    private func clearBinaryCalculator() {
        
    }
    @IBAction func tapSignButton(_ sender: Any) {
    }
    @IBAction func tapModeChangeButton(_ sender: Any) {
        self.calculatorMode = self.calculatorMode.changeMode()
    }
    @IBAction func tapSubtractButton(_ sender: Any) {
    }
    @IBAction func tapAddButton(_ sender: Any) {
    }
    @IBAction func tapEqualButton(_ sender: Any) {
    }
    
    // MARK: - decimal Calculator Button
    @IBAction func tapDecimalDivideButton(_ sender: Any) {
    }
    @IBAction func tapDecimalMultiplyButton(_ sender: Any) {
    }
    @IBAction func tapDecimalDotButton(_ sender: Any) {
    }
    @IBAction func tapDecimalNumberButton(_ sender: Any) {
        
    }
    
    // MARK: - binary Calculator Button
    @IBAction func tapBinaryLeftShiftButton(_ sender: Any) {
    }
    @IBAction func tapDecimalRightShiftButton(_ sender: Any) {
    }
    @IBAction func tapBinaryOrButton(_ sender: Any) {
    }
    @IBAction func tapBinaryNorButton(_ sender: Any) {
    }
    @IBAction func tapBinaryNotButton(_ sender: Any) {
    }
    @IBAction func tapBinaryAndButton(_ sender: Any) {
    }
    @IBAction func tapBinaryNandButton(_ sender: Any) {
    }
    @IBAction func tapBinaryXorButton(_ sender: Any) {
    }
    @IBAction func tapBinaryNumberButton(_ sender: Any) {
        
    }
    
    // MARK: - alert func
    private func showError(_ error: Error, handler: ((UIAlertAction) -> Void)?) {
        self.present(self.errorAlert(error, handler: handler), animated: true, completion: nil)
    }
}

