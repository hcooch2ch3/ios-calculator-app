//
//  CalculatorMode.swift
//  Calculator
//
//  Created by Wonhee on 2020/12/18.
//

import Foundation

enum CalculatorMode {
    case decimal
    case binary
    
    func changeMode() -> CalculatorMode {
        switch self {
        case .decimal:
            return .binary
        case .binary:
            return .decimal
        }
    }
}
