//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var decimalButtons: [CircularButton]!
    @IBOutlet var binaryButtons: [CircularButton]!
    
    private var decimalCalculator = DecimalCalculator()
    private var binaryCalculator = BinaryCalculator()
    
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
    
    // MARK: Set Up UI
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
    
    // MARK: Basic Operator Button
    @IBAction func tapClearButton(_ sender: Any) {
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
    
    // MARK: decimal Calculator Button
    
    // MARK: binary Calculator Button
}

