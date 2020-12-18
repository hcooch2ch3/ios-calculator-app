//
//  BinaryCalculator.swift
//  Calculator
//
//  Created by 임성민 on 2020/12/10.
//

import Foundation

class BinaryCalculator: BasicCalculable, BinaryCalculable {
    struct OperatorDetail {
        let symbol: String
        let priority: Int
        let operation: ((Int, Int) -> Int)?
    }
    
    enum BinaryCalculatorOperator {
        case add, subtract, and, or, xor, nor, nand, equal
    }
    
    // 사용자가 숫자를 터치하면 버퍼에 저장하고, 연산자를 터치하면 버퍼에 모인 숫자를 피연산자 스택에 저장하기 위함.
    private var operandBuffer: String = "0"
    
    // 연산자가 바로 직전에 푸쉬됐는지 확인하여, 연산자가 여러개 푸쉬 되는 것을 방지.
    private var isPushingOperatorJustBefore: Bool = false
    
    private var operatorStack: Stack<BinaryCalculatorOperator> = Stack<BinaryCalculatorOperator>()
    
    private var operandStack: Stack<Int> = Stack<Int>()
    
    private var operatorDetails: [BinaryCalculatorOperator: OperatorDetail] = [
        .add: OperatorDetail(symbol: "+", priority: 3, operation: {$1 + $0}),
        .subtract: OperatorDetail(symbol: "-", priority: 3, operation: {$1 - $0}),
        .and: OperatorDetail(symbol: "&", priority: 2, operation: {$1 & $0}),
        .or: OperatorDetail(symbol: "|", priority: 3, operation: {$1 | $0}),
        .xor: OperatorDetail(symbol: "^", priority: 3, operation: {$1 ^ $0}),
        .nor: OperatorDetail(symbol: "~|", priority: 3, operation: {~($1 | $0)}),
        .nand: OperatorDetail(symbol: "~&", priority: 2, operation: {~($1 & $0)}),
        .equal: OperatorDetail(symbol: "=", priority: 5, operation: nil)
    ]
    
    /// 0 또는 1을 입력받아서 버퍼에 저장하는 함수.
    ///
    /// - Parameter number: 0 또는 1
    /// - Throws:
    ///     - 0 또는 1 이외의 값이 입력되면 'CalculatorError.inputNumberError'.
    /// - Returns: 현재 버퍼에 저장되어있는 문자열.
    func enterNumber(_ number: Character) throws -> String {
        // 새로 입력된 값을 추가한 피연산자를 Int로 변환하여 유효여부를 확인하고, 유효하면 버퍼에 초기화
        let newOperand = operandBuffer + String(number)
        guard let validOperand = Int(newOperand, radix: 2) else {
            throw CalculatorError.inputNumberError
        }
        operandBuffer = String(validOperand, radix: 2)
        
        isPushingOperatorJustBefore = false
        
        return operandBuffer
    }
    
    /// 사용자가 연산자를 입력하면, 버퍼에 저장되어있는 숫자들을 피연산자로서 스택에 푸쉬하기 위한 함수.
    func pushOperand() {
        if let operand: Int = Int(operandBuffer, radix: 2) {
            operandStack.push(operand)
            
            self.operandBuffer = "0"
        }
    }
    
    /// 사용자가 연산자를 입력(터치)하면 스택에 연산자를 푸쉬하기 위한 함수.
    /// 넣으려는 연산자보다 우선순위가 먼저인 연산자는 pop하여 연산한다.
    ///
    /// - Parameter operator: 스텍에 넣을 연산자.
    /// - Throws:
    ///     - 피연산자가 부족할 경우(잘못된 피연산자 입력), 'CalculatorError.operandError'.
    private func pushOperator(_ `operator`: BinaryCalculatorOperator) throws {
        guard operandStack.size > 0 else { return }
        
        guard let pushedOperatorDetail = operatorDetails[`operator`] else { return }
        
        while let lastOperator = operatorStack.top {
            guard let lastOperatorDetail = operatorDetails[lastOperator] else { return }
            if lastOperatorDetail.priority > pushedOperatorDetail.priority {
                break
            }
            
            operatorStack.pop()
            
            guard let operand1 = operandStack.pop(), let operand2 = operandStack.pop() else {
                throw CalculatorError.operandError
            }
            guard let operate = lastOperatorDetail.operation else { return }
            let resultByLastOperator = operate(operand1, operand2)
            operandStack.push(resultByLastOperator)
        }
        
        operatorStack.push(`operator`)
        
        isPushingOperatorJustBefore = true
    }
    
    /// 더하기 연산자를 스택에 푸쉬하는 함수.
    ///
    /// - Throws:
    ///     - 피연산자가 부족할 경우(잘못된 피연산자 입력), 'CalculatorError.operandError'.
    ///     - pushOperator함수에서 발생한 에러를 전달.
    /// - Returns: 스택의 가장 최근 피연산자 값을 문자열로 반환.
    func add() throws -> String {
        if isPushingOperatorJustBefore {
            operatorStack.pop()
            operatorStack.push(.add)
        } else {
            pushOperand()
            
            do {
                try pushOperator(.add)
            } catch(let error) {
                throw error
            }
        }
        
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func subtract() throws -> String {
        if isPushingOperatorJustBefore {
            operatorStack.pop()
            operatorStack.push(.subtract)
        } else {
            pushOperand()
            
            do {
                try pushOperator(.subtract)
            } catch(let error) {
                throw error
            }
        }
        
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func and() throws -> String{
        if isPushingOperatorJustBefore {
            operatorStack.pop()
            operatorStack.push(.and)
        } else {
            pushOperand()
            
            do {
                try pushOperator(.and)
            } catch(let error) {
                throw error
            }
        }
        
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func or() throws -> String {
        if isPushingOperatorJustBefore {
            operatorStack.pop()
            operatorStack.push(.or)
        } else {
            pushOperand()
            
            do {
                try pushOperator(.or)
            } catch(let error) {
                throw error
            }
        }
        
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func xor() throws -> String {
        if isPushingOperatorJustBefore {
            operatorStack.pop()
            operatorStack.push(.xor)
        } else {
            pushOperand()
            
            do {
                try pushOperator(.xor)
            } catch(let error) {
                throw error
            }
        }
        
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func nor() throws -> String {
        if isPushingOperatorJustBefore {
            operatorStack.pop()
            operatorStack.push(.nor)
        } else {
            pushOperand()
            
            do {
                try pushOperator(.nor)
            } catch(let error) {
                throw error
            }
        }
        
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func nand() throws -> String {
        if isPushingOperatorJustBefore {
            operatorStack.pop()
            operatorStack.push(.nand)
        } else {
            pushOperand()
            
            do {
                try pushOperator(.nand)
            } catch(let error) {
                throw error
            }
        }
        
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func not() throws -> String {
        guard let operand = Int(operandBuffer, radix: 2) else {
            throw CalculatorError.operandError
        }
        
        let result = ~operand
        
        operandBuffer = String(result, radix: 2)
        
        return operandBuffer
    }
    
    
    func leftShift() throws -> String {
        guard let operand = Int(operandBuffer, radix: 2) else {
            throw CalculatorError.operandError
        }
        
        let result = operand << 1
        
        operandBuffer = String(result, radix: 2)
        
        return operandBuffer
    }
    
    func rightShift() throws -> String {
        guard let operand = Int(operandBuffer, radix: 2) else {
            throw CalculatorError.operandError
        }
        
        let result = operand >> 1
        
        operandBuffer = String(result, radix: 2)
        
        return operandBuffer
    }
    
    func toggleSign() -> String {
        guard operandBuffer != "0" else {
            return "0"
        }
        
        let startIndex = operandBuffer.startIndex
        if operandBuffer[startIndex] == "-" {
            let startAfterIndex = operandBuffer.index(after: startIndex)
            let operandBufferSubString = operandBuffer[startAfterIndex..<operandBuffer.endIndex]
            operandBuffer = String(operandBufferSubString)
        } else {
            operandBuffer = "-\(operandBuffer)"
        }
        
        return operandBuffer
    }
    
    func equal() throws -> String {
        guard isPushingOperatorJustBefore else {
            pushOperand()
            
            do {
                try pushOperator(.equal)
                
                operatorStack.pop()
                
                guard let lastOperand = operandStack.top else {
                    throw CalculatorError.operandError
                }
                
                return String(lastOperand, radix: 2)
            } catch(let error) {
                throw error
            }
        }
                
        guard let lastOperand = operandStack.top else {
            throw CalculatorError.operandError
        }
        
        return String(lastOperand, radix: 2)
    }
    
    func removeNumber() throws {
        guard let operand = operandStack.pop() else {
            throw CalculatorError.deleteNumber
        }
    }
    
    func clear() {
        operatorStack.removeAll()
        operandStack.removeAll()
        self.operandBuffer = "0"
        debugPrint("2️⃣: clear")
    }
    
}
