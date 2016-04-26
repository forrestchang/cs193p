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
    
    func get() -> Double? {
        switch self {
        case .Number(let number):
            return number
        default:
            break
        }
        
        return nil
    }
}

func ==(a: Token, b: Token) -> Bool {
    switch (a, b) {
    case (.Number, .Number):
        return true
    case (.EOF, .EOF):
        return true
    case (.Plus, .Plus):
        return true
    case (.Minus, .Minus):
        return true
    case (.Multiply, .Multiply):
        return true
    case (.Divide, .Divide):
        return true
    case (.LeftParenthesis, .LeftParenthesis):
        return true
    case (.RightParenthesis, .RightParenthesis):
        return true
    case (.SquareRoot, .SquareRoot):
        return true
    default:
        return false
    }
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
    
    init(token: Token) {
        self.value = token.get()!
    }
}

struct IdNode: ExprNode {
    let name: String
    var description: String {
        return "IdNode(\(name))"
    }
}

struct BinaryOpNode: ExprNode {
    let op: Token
    let left: ExprNode
    let right: ExprNode
    var description: String {
        return "BinaryOpNode(left: \(left), \(op), right: \(right))"
    }
}


