//
//  CircularButton.swift
//  Calculator
//
//  Created by Wonhee on 2020/12/18.
//

import UIKit

class CircularButton: UIButton {    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height * 0.5
        self.clipsToBounds = true
    }
}
