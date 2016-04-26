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
    var lexer: Lexer
    var currentToken: Token
    
    init(lexer: Lexer) {
        self.lexer = lexer
        self.currentToken = self.lexer.getNextToken()
    }
    
    func eat(tokenType: Token) {
        if self.currentToken == tokenType {
            self.currentToken = self.lexer.getNextToken()
        }
    }
    
    func factor() -> Double? {
        let token = self.currentToken
        
        switch token {
        case .Number(let value):
            self.eat(.Number(value))
            return NumberNode(token: token).value
        case .LeftParenthesis:
            self.eat(.LeftParenthesis)
            let result = self.expr()
            self.eat(.RightParenthesis)
            return result
        default:
            break
        }
        
        return nil
    }
    
    func term() -> Double {
        var result = self.factor()
        
        while self.currentToken == Token.Multiply || self.currentToken == Token.Divide {
            let token = self.currentToken
            
            switch token {
            case .Multiply:
                self.eat(Token.Multiply)
                result = result! * self.factor()!
            case .Divide:
                self.eat(Token.Divide)
                result = result! / self.factor()!
            default:
                break
            }
            
        }
        
        return result!
    }
    
    func expr() -> Double {
        var result = self.term()
        
        while self.currentToken == Token.Plus || self.currentToken == Token.Minus {
            let token = self.currentToken
            
            switch token {
            case .Plus:
                self.eat(Token.Plus)
                result = result + self.term()
            case .Minus:
                self.eat(Token.Minus)
                result = result - self.term()
            default:
                break
            }
            
        }
        
        return result
    }

}
















