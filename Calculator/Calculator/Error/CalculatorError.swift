//
//  CalculatorError.swift
//  Calculator
//
//  Created by Wonhee on 2020/12/18.
//

import Foundation

enum CalculatorError: Error {
    case divisionByZero
    case operandError
    case inputNumberError
    case getCalculator
    case unknown
}

extension CalculatorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .divisionByZero:
            return "0으로 나눌 수 없습니다.\n다른 수로 나눠 주세요."
        case .operandError:
            return "피연산자가 부족해 계산을 계속할 수 없습니다."
        case .inputNumberError:
            return "잘못된 수가 입력되었습니다.\n다시 입력해 주세요."
        case .getCalculator:
            return ""
        case .unknown:
            return "알 수 없는 오류가 발생했습니다.\n잠시 후 다시 시도해 주세요."
        }
    }
}
