//
//  CalculatorDataStructure.swift
//  Calculator
//
//  Created by 张佳圆 on 4/22/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import Foundation

enum Token {
    case Number(Double)
    case EOF
    case Plus
    case Minus
    case Multiply
    case Divide
    case LeftParenthesis
    case RightParenthesis
    case SquareRoot
}

extension Character {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}