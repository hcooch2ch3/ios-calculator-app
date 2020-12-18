//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet var decimalButtons: [CircularButton]!
    @IBOutlet var binaryButtons: [CircularButton]!
    
    private let minusSign = "-"
    private let zeroString = "0"
    private let dotSign = "."
    private let digitNumber = 9
    
    private var calculators: [CalculatorMode : BasicCalculable] = [
        .decimal : DecimalCalculator(),
        .binary : BinaryCalculator()
    ]
    
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
    
    private var isPositiveNumber: Bool = true {
        didSet {
            if isPositiveNumber {
//                deleteMinusNumberSign()
            }
            else {
//                addMinusNumberSign()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSwipeNumberView()
    }
    
    // MARK: - Set Up UI
    private func setUpSwipeNumberView() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeNumberView(_:)))
        swipeGesture.direction = .left
        self.numberLabel.addGestureRecognizer(swipeGesture)
    }
    @objc func swipeNumberView(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.deleteNumber()
        }
    }
    
    private func deleteNumber() {
        guard let calculator = calculators[self.calculatorMode] else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        var numberText = calculator.deleteNumber()
        numberText = trimmingNumberText(numberText)
        setNumberLabelText(numberText)
    }
    private func trimmingNumberText(_ text: String) -> String {
        var trimText = text
        if trimText.hasPrefix("0.") {
            return trimText
        }
        if trimText.hasPrefix(zeroString) {
            trimText.remove(at: trimText.startIndex)
        }
        return trimText
    }
    private func setNumberLabelText(_ text: String) {
        numberLabel.text = text
    }
    
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
        setNumberLabelText(zeroString)
    }
    @IBAction func tapSignButton(_ sender: Any) {
        self.isPositiveNumber = !self.isPositiveNumber
    }
    @IBAction func tapModeChangeButton(_ sender: Any) {
        self.calculatorMode = self.calculatorMode.changeMode()
    }
    @IBAction func tapSubtractButton(_ sender: Any) {
        guard let calculator = calculators[self.calculatorMode] else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            var numberText = try calculator.subtract()
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    @IBAction func tapAddButton(_ sender: Any) {
        guard let calculator = calculators[self.calculatorMode] else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            var numberText = try calculator.add()
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    @IBAction func tapEqualButton(_ sender: Any) {
        guard let calculator = calculators[self.calculatorMode] else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            var numberText = try calculator.equal()
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    
    // MARK: - decimal Calculator Button
    @IBAction func tapDecimalDivideButton(_ sender: Any) {
        guard let calculator = calculators[self.calculatorMode] as? DecimalCalculator else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            var numberText = try calculator.divide()
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    @IBAction func tapDecimalMultiplyButton(_ sender: Any) {
        guard let calculator = calculators[self.calculatorMode] as? DecimalCalculator else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            var numberText = try calculator.multiply()
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    @IBAction func tapDecimalDotButton(_ sender: Any) {
        guard let calculator = calculators[self.calculatorMode] as? DecimalCalculator else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            var numberText = try calculator.enterNumber(dotSign)
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    @IBAction func tapDecimalNumberButton(_ sender: UIButton)  {
        guard let calculator = calculators[self.calculatorMode] else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            guard try canInputNumber() else {
                return self.showError(CalculatorError.overflowDigit, handler: nil)
            }
            var numberText = try calculator.enterNumber(String(sender.tag))
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    private func canInputNumber() throws -> Bool {
        guard let numberText = numberLabel.text else {
            throw CalculatorError.getText
        }
        var digit = digitNumber
        if numberText.contains(dotSign) {
            digit += 1
        }
        if numberText.contains(minusSign) {
            digit += 1
        }
        
        return numberText.count < digit
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
    @IBAction func tapBinaryNumberButton(_ sender: UIButton) {
        guard let calculator = calculators[self.calculatorMode] else {
            return self.showError(CalculatorError.getCalculator, handler: nil)
        }
        do {
            guard try canInputNumber() else {
                return self.showError(CalculatorError.overflowDigit, handler: nil)
            }
            var numberText = try calculator.enterNumber(String(sender.tag))
            numberText = trimmingNumberText(numberText)
            setNumberLabelText(numberText)
        } catch {
            self.showError(error, handler: nil)
        }
    }
    
    // MARK: - alert func
    private func showError(_ error: Error, handler: ((UIAlertAction) -> Void)?) {
        self.present(self.errorAlert(error, handler: handler), animated: true, completion: nil)
    }
}

