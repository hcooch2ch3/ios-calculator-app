//
//  CalculatorLabel.swift
//  Calculator
//
//  Created by Wonhee on 2020/12/18.
//

import UIKit

class CalculatorLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInit()
    }
    
    func setInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .right
        self.font = self.font.withSize(55.0)
        self.textColor = UIColor.white
    }
}
