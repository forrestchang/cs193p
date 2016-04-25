//
//  Parser.swift
//  Calculator
//
//  Created by 张佳圆 on 4/22/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import Foundation

enum ParserError: ErrorType {
    case ExpectedNumber
    case ExpectedIdentifier
    case ExpectedCharacter(Character)
    case ExpectedExpression
    case UndefinedOperator(String)
}

class Parser {
    let tokens: [Token]
    var index = 0
    
    let operatorPrecedence: [String: Int] = [
        "+": 20,
        "−": 20,
        "×": 40,
        "÷": 40
    ]
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    var tokenAvaliable: Bool {
        return index < tokens.count
    }
    
    func peekCurrentToken() -> Token {
        return tokens[index]
    }
    
    func popCurrentToken() -> Token {
        index += 1
        return tokens[index]
    }
    
    func parseNumber() throws -> ExprNode {
        guard case let Token.Number(value) = popCurrentToken() else {
            throw ParserError.ExpectedNumber
        }
        return  NumberNode(value: value)
    }
    
    func parseExpression() throws -> ExprNode {
        
    }
    
    func parseParens() throws -> ExprNode {
        guard case Token.LeftParenthesis = popCurrentToken() else {
            throw ParserError.ExpectedCharacter("(")
        }
        
        let exp = try parseExpression()
        
        guard case Token.RightParenthesis = popCurrentToken() else {
            throw ParserError.ExpectedCharacter(")")
        }
        
        return exp
    }
    
    func parsePrimary() throws -> ExprNode {
        switch (peekCurrentToken()) {
        case .Number:
            return try parseNumber()
        case .LeftParenthesis:
            return try parseParens()
        default:
            throw ParserError.ExpectedExpression
        }
    }
    
    func getCurrentTokenPrecedence() throws -> Int {
        guard tokenAvaliable else {
            return -1
        }
        
        guard case let Token.Other(op) = peekCurrentToken() else {
            return -1
        }
        
        return precedence
    }
}
















