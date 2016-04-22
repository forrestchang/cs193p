//
//  Interpreter.swift
//  Calculator
//
//  Created by 张佳圆 on 4/22/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import Foundation

extension Character {
    func unicodeScalarCodePoint() -> UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}


struct Token {
    var type: String
    var value: String?
    
    init(type: String, value: String?) {
        self.type = type
        self.value = value
    }
}

class Lexer {
    var text: String
    var position: Int
    var currentChar: Character?
    
    init(text: String) {
        self.text = text
        self.position = 0
        self.currentChar = self.text[text.startIndex.advancedBy(self.position)]
    }
    
    func error() -> String {
        return "Error"
    }
    
    func advance() {
        self.position += 1
        if self.position > self.text.characters.count - 1 {
            self.currentChar = nil
        } else {
            self.currentChar = self.text[self.text.startIndex.advancedBy(self.position)]
        }
    }
    
    func skipWhitespace() {
        while self.currentChar != nil && self.currentChar == " " {
            self.advance()
        }
    }
    
    func operand() -> Double {
        var result = ""
        while self.currentChar != nil && (isDigit(self.currentChar!) || self.currentChar == ".") {
            result = "\(result)\(self.currentChar)"
            self.advance()
        }
        return Double(result)!
    }
    
    func keywords() -> Token {
        var result = ""
        while self.currentChar != nil && (isAlnum(self.currentChar!) || self.currentChar == "_") {
            result = "\(result)\(self.currentChar)"
            self.advance()
        }
        
        if result == "√" {
            return Token(type: "SquareRoot", value: "√")
        } else {
            return Token(type: "\(result)", value: result)
        }
        
    }
    
    func getNextToken() -> Token {
        checkLoop: while self.currentChar != nil {
            if self.currentChar == " " {
                self.skipWhitespace()
                continue checkLoop
            }
            
            if isDigit(self.currentChar!) || self.currentChar == "." {
                return Token(type: "Operand", value: String(self.operand()))
            }
            
            if self.currentChar == "+" {
                self.advance()
                return Token(type: "Plus", value: "+")
            }
            
            if self.currentChar == "−" {
                self.advance()
                return Token(type: "Minus", value: "−")
            }
            
            if self.currentChar == "×" {
                self.advance()
                return Token(type: "Multiply", value: "×")
            }
            
            if self.currentChar == "÷" {
                self.advance()
                return Token(type: "Divide", value: "÷")
            }
            
            if self.currentChar == "(" {
                self.advance()
                return Token(type: "LeftParenthesis", value: "(")
            }
            
            if self.currentChar == ")" {
                self.advance()
                return Token(type: "RightParenthesis", value: ")")
            }
            
            if isAlnum(self.currentChar!) || self.currentChar == "_" {
                return self.keywords()
            }
            
        }
        return Token(type: "EOF", value: nil)
        
    }
    
    func isDigit(char: Character) -> Bool {
        if Double(String(char)) != nil {
            return true
        } else {
            return false
        }
    }
    
    func isAlnum(char: Character) -> Bool {
        let unicodeValue = char.unicodeScalarCodePoint()
        if (unicodeValue >= 48 && unicodeValue <= 57) || (unicodeValue >= 65 && unicodeValue <= 122) {
            return true
        } else {
            return false
        }
    }
    
}
