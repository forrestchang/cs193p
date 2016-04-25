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
    case Other
}

extension Character {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}

// CFG
// expr -> term | expr add_op term
// term -> factor | term mult_op factor
// factor -> id | number | ( expr )
// add_op -> + | -
// mult_op -> * | /

protocol ExprNode: CustomStringConvertible {
    
}

struct NumberNode: ExprNode {
    let value: Double
    var description: String {
        return "NumberNode(\(value))"
    }
}

struct IdNode: ExprNode {
    let name: String
    var description: String {
        return "IdNode(\(name))"
    }
}

struct BinaryOpNode: ExprNode {
    let op: String
    let left: ExprNode
    let right: ExprNode
    var description: String {
        return "BinaryOpNode(\(op), left: \(left), right: \(right))"
    }
}


