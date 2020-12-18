//
//  UIViewControllerExtension.swift
//  Calculator
//
//  Created by Wonhee on 2020/12/18.
//

import UIKit

extension UIViewController {
    func errorAlert(_ error: Error, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        var errorMessage: String?
        if let calculatorError = error as? CalculatorError {
            errorMessage = calculatorError.localizedDescription
        }
        else {
            errorMessage = CalculatorError.unknown.localizedDescription
        }
        
        let alert = UIAlertController(title: "오류", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(okAction)
        return alert
    }
}
