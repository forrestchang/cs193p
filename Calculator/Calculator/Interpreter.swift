////
////  Interpreter.swift
////  Calculator
////
////  Created by 张佳圆 on 4/22/16.
////  Copyright © 2016 Tisoga. All rights reserved.
////
//
//import Foundation
//
//extension Character {
//    func unicodeScalarCodePoint() -> UInt32 {
//        let characterString = String(self)
//        let scalars = characterString.unicodeScalars
//        
//        return scalars[scalars.startIndex].value
//    }
//}
//
//enum TokenType {
//    case Operand(Double)
//    case UnaryOperation(String)
//    case BinaryOperation(String)
//}
//
//enum OperationType: String {
//    case Plus = "+"
//    case Minus = "−"
//    case Multiply = "×"
//    case Divide = "÷"
//    case LeftParenthesis = "("
//    case RightParenthesis = ")"
//    case SquareRoot = "√"
//}
//
//struct Token {
//    var type: String
//    var value: String?
//    
//    init(type: String, value: String?) {
//        self.type = type
//        self.value = value
//    }
//}
//
//class Lexer {
//    var text: String
//    var position: Int
//    var currentChar: Character?
//    
//    init(text: String) {
//        self.text = text
//        self.position = 0
//        self.currentChar = self.text[text.startIndex.advancedBy(self.position)]
//    }
//    
//    func error() -> String {
//        return "Error"
//    }
//    
//    func advance() {
//        self.position += 1
//        if self.position > self.text.characters.count - 1 {
//            self.currentChar = nil
//        } else {
//            self.currentChar = self.text[self.text.startIndex.advancedBy(self.position)]
//        }
//    }
//    
//    func skipWhitespace() {
//        while self.currentChar != nil && self.currentChar == " " {
//            self.advance()
//        }
//    }
//    
//    func operand() -> Double {
//        var result = ""
//        while self.currentChar != nil && (isDigit(self.currentChar!) || self.currentChar == ".") {
//            result = "\(result)\(self.currentChar)"
//            self.advance()
//        }
//        return Double(result)!
//    }
//    
//    func keywords() -> Token {
//        var result = ""
//        while self.currentChar != nil && (isAlnum(self.currentChar!) || self.currentChar == "_") {
//            result = "\(result)\(self.currentChar)"
//            self.advance()
//        }
//        
//        if result == "√" {
//            return Token(type: String(OperationType.SquareRoot), value: OperationType.SquareRoot.rawValue)
//        } else {
//            return Token(type: "\(result)", value: result)
//        }
//        
//    }
//    
//    func getNextToken() -> Token {
//        checkLoop: while self.currentChar != nil {
//            if self.currentChar == " " {
//                self.skipWhitespace()
//                continue checkLoop
//            }
//            
//            if isDigit(self.currentChar!) || self.currentChar == "." {
//                return Token(type: "Operand", value: String(self.operand()))
//            }
//            
//            if self.currentChar == "+" {
//                self.advance()
//                return Token(type: String(OperationType.Plus), value: OperationType.Plus.rawValue)
//            }
//            
//            if self.currentChar == "−" {
//                self.advance()
//                return Token(type: String(OperationType.Minus), value: OperationType.Minus.rawValue)
//            }
//            
//            if self.currentChar == "×" {
//                self.advance()
//                return Token(type: String(OperationType.Multiply), value: OperationType.Multiply.rawValue)
//            }
//            
//            if self.currentChar == "÷" {
//                self.advance()
//                return Token(type: String(OperationType.Divide), value: OperationType.Divide.rawValue)
//            }
//            
//            if self.currentChar == "(" {
//                self.advance()
//                return Token(type: String(OperationType.LeftParenthesis), value: OperationType.LeftParenthesis.rawValue)
//            }
//            
//            if self.currentChar == ")" {
//                self.advance()
//                return Token(type: String(OperationType.RightParenthesis), value: OperationType.RightParenthesis.rawValue)
//            }
//            
//            if isAlnum(self.currentChar!) || self.currentChar == "_" {
//                return self.keywords()
//            }
//            
//        }
//        return Token(type: "EOF", value: nil)
//        
//    }
//    
//    func isDigit(char: Character) -> Bool {
//        if Double(String(char)) != nil {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    func isAlnum(char: Character) -> Bool {
//        let unicodeValue = char.unicodeScalarCodePoint()
//        if (unicodeValue >= 48 && unicodeValue <= 57) || (unicodeValue >= 65 && unicodeValue <= 122) {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//}
//
//protocol AST {
//    
//}
//
//struct Number: AST {
//    var token: String
//    var value: Double
//    
//    init(token: Token) {
//        self.token = token.type
//        self.value = Double(token.value!)!
//    }
//}
//
//struct BinaryOperation {
//    var letf: Token
//    var right: Token
//    var op: Token
//    var token: Token
//    
//    init(left: Token, op: Token, right: Token) {
//        self.letf = left
//        self.token = op
//        self.op = op
//        self.right = right
//    }
//}
//
//class Parser {
//    var lexer: Lexer
//    var currentToken: Token
//    
//    init(lexer: Lexer) {
//        self.lexer = lexer
//        self.currentToken = self.lexer.getNextToken()
//    }
//    
//    func error() -> String {
//        return "Error"
//    }
//    
//    func eat(tokenType: String) {
//        if self.currentToken.type == tokenType {
//            self.currentToken = self.lexer.getNextToken()
//        } else {
//            self.error()
//        }
//    }
//    
//    func factor() -> Token? {
//        let token = self.currentToken
//        
//        if token.type == "Operand" {
//            self.eat("Operand")
//            return Token(type: "Operand", value: String(token.value))
//        } else if token.type == String(OperationType.LeftParenthesis) {
//            self.eat(String(OperationType.LeftParenthesis))
//            let node = self.expr()
//            self.eat(String(OperationType.RightParenthesis))
//            return node
//        }
//        return nil
//    }
//    
//    func term() -> Token? {
//        var node = self.factor()
//        
//        while self.currentToken.type == String(OperationType.Divide) || self.currentToken.type == String(OperationType.Multiply) {
//            let token = self.currentToken
//            if token.type == String(OperationType.Multiply) {
//                self.eat(String(OperationType.Multiply))
//            } else if token.type == String(OperationType.Divide) {
//                self.eat(String(OperationType.Divide))
//            }
//            
//            node = BinaryOperation(left: node!, op: token, right: self.factor()!) as? Token
//        }
//        
//        return node
//    }
//    
//    func expr() -> Token? {
//        let node = self.term()
//        
//        while self.currentToken.type == String(OperationType.Plus) || self.currentToken.type == String(OperationType.Minus) {
//            let token = self.currentToken
//            if token.type == String(OperationType.Plus) {
//                self.eat(String(OperationType.Plus))
//            } else if token.type == String(OperationType.Minus) {
//                self.eat(String(OperationType.Minus))
//            }
//        }
//        
//        return node
//    }
//    
//    func parse() -> Token? {
//        return self.expr()
//    }
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
