//
//  ButtonExtension.swift
//  Calculator
//
//  Created by Wonhee on 2020/12/18.
//

import UIKit

extension UIButton {
    func makeButtonCircular() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
        
        
        
        //        self.layer.cornerRadius = self.frame.height * 0.5
//        self.layer.cornerRadius = self.bounds.size.height * 0.5
//        self.clipsToBounds = true
//        self.layer.masksToBounds = true
    }
}
