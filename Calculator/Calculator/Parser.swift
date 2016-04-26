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
    
    func factor() -> ExprNode? {
        let token = self.currentToken
        
        switch token {
        case .Number(let value):
            self.eat(.Number(value))
            return NumberNode(token: token)
        case .LeftParenthesis:
            self.eat(.LeftParenthesis)
            let node = self.expr()
            self.eat(.RightParenthesis)
            return node
        default:
            break
        }
        
        return nil
    }
    
    func term() -> ExprNode? {
        var node = self.factor()
        
        while self.currentToken == Token.Multiply || self.currentToken == Token.Divide {
            let token = self.currentToken
            
            switch token {
            case .Multiply:
                self.eat(Token.Multiply)
            case .Divide:
                self.eat(Token.Divide)
            default:
                break
            }
            
            node = BinaryOpNode(op: token, left: node!, right: self.factor()!)
        }
        
        return node
    }
    
    func expr() -> ExprNode {
        var node = self.term()
        
        while self.currentToken == Token.Plus || self.currentToken == Token.Minus {
            let token = self.currentToken
            
            switch token {
            case .Plus:
                self.eat(Token.Plus)
            case .Minus:
                self.eat(Token.Minus)
            default:
                break
            }
            
            node = BinaryOpNode(op: token, left: node!, right: self.term()!)
        }
        
        return node!
    }
    
    func parse() -> ExprNode {
        return self.expr()
    }

}
















