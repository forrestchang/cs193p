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
    case ExpectedError
}

class Parser {
    var lexer: Lexer
    var currentToken: Token
    
    init(lexer: Lexer) throws {
        self.lexer = lexer
        self.currentToken = try self.lexer.getNextToken()
    }
    
    func eat(tokenType: Token) throws {
        if self.currentToken == tokenType {
            self.currentToken = try self.lexer.getNextToken()
        }
    }
    
    func factor() throws -> Double? {
        let token = self.currentToken
        
        switch token {
        case .Number(let value):
            try self.eat(.Number(value))
            return NumberNode(token: token).value
        case .LeftParenthesis:
            try self.eat(.LeftParenthesis)
            let result = try self.expr()
            try self.eat(.RightParenthesis)
            return result
        default:
            throw ParserError.ExpectedError
        }

    }
    
    func term() throws -> Double {
        var result = try self.factor()
        
        while self.currentToken == Token.Multiply || self.currentToken == Token.Divide {
            let token = self.currentToken
            
            switch token {
            case .Multiply:
                try self.eat(Token.Multiply)
                result = try result! * self.factor()!
            case .Divide:
                try self.eat(Token.Divide)
                result = try result! / self.factor()!
            default:
                throw ParserError.ExpectedError
            }
            
        }
        
        return result!
    }
    
    func expr() throws -> Double {
        var result = try self.term()
        
        while self.currentToken == Token.Plus || self.currentToken == Token.Minus {
            let token = self.currentToken
            
            switch token {
            case .Plus:
                try self.eat(Token.Plus)
                result = try result + self.term()
            case .Minus:
                try self.eat(Token.Minus)
                result = try result - self.term()
            default:
                throw ParserError.ExpectedError
            }
            
        }
        
        return result
    }

}
















