//
//  Lexer.swift
//  Calculator
//
//  Created by 张佳圆 on 4/22/16.
//  Copyright © 2016 Tisoga. All rights reserved.
//

import Foundation

class Lexer {
    var text: String
    var position: Int = 0
    var currentChar: Character?
    
    init(text: String) {
        self.text = text
        self.position = 0
        self.currentChar = self.text[self.text.startIndex.advancedBy(self.position)]
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
    
    func operand() throws -> Token {
        var result = ""
        
        while self.currentChar != nil && (isDigit(self.currentChar!) || self.currentChar! == ".") {
            result = "\(result)\(self.currentChar!)"
            self.advance()
        }
        
        if let number = Double(result) {
            return Token.Number(number)
        } else {
            throw ParserError.ExpectedError
        }
    }
    
    func getNextToken() throws -> Token {
        while self.currentChar != nil {
            let currentChar = self.currentChar!
            
            if currentChar == " " {
                self.skipWhitespace()
                continue
            }
            
            if isDigit(currentChar) || currentChar == "." {
                do {
                    let result = try self.operand()
                    return result
                } catch {
                    throw ParserError.ExpectedError
                }
            }
            
            if currentChar == "+" {
                self.advance()
                return Token.Plus
            }
            
            if currentChar == "−" {
                self.advance()
                return Token.Minus
            }
            
            if currentChar == "×" {
                self.advance()
                return Token.Multiply
            }
            
            if currentChar == "÷" {
                self.advance()
                return Token.Divide
            }
            
            if currentChar == "(" {
                self.advance()
                return Token.LeftParenthesis
            }
            
            if currentChar == ")" {
                self.advance()
                return Token.RightParenthesis
            }
        }
        
        return Token.EOF
    }
    
    func isDigit(char: Character) -> Bool {
        if char.unicodeScalarCodePoint() >= 48 && char.unicodeScalarCodePoint() <= 57 {
            return true
        } else {
            return false
        }
    }
}