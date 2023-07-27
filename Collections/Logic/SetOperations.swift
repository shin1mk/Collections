//
//  SetOperations.swift
//  Collections
//
//  Created by SHIN MIKHAIL on 16.07.2023.
//

import Foundation

class SetOperations {
    func findMatchingCharacters(textFull: String, textCharacters: String) -> String {
        let matchingCharacters = Set(textFull).intersection(Set(textCharacters))
        return matchingCharacters.map { String($0) }.joined(separator: "")
    }
    
    func findNonMatchingCharacters(textFull: String, textCharacters: String) -> String {
        let nonMatchingCharactersInTextFull = Set(textFull).subtracting(Set(textCharacters))
        let nonMatchingCharactersInTextCharacters = Set(textCharacters).subtracting(Set(textFull))
        let allNonMatchingCharacters = nonMatchingCharactersInTextFull.union(nonMatchingCharactersInTextCharacters)
        return allNonMatchingCharacters.map { String($0) }.joined(separator: "")
    }
    
    func findUniqueCharacters(textFull: String, textCharacters: String) -> String {
        let uniqueCharacters = Set(textFull).subtracting(Set(textCharacters))
        return uniqueCharacters.map { String($0) }.joined(separator: "")
    }
}
