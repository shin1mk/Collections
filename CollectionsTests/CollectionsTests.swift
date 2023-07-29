//
//  CollectionsTests.swift
//  CollectionsTests
//
//  Created by SHIN MIKHAIL on 06.07.2023.
//

import XCTest
@testable import Collections

final class ArrayOperationsTests: XCTestCase {
    var arrayOperations: ArrayOperations!

    override func setUpWithError() throws {
        try super.setUpWithError()
        arrayOperations = ArrayOperations()
    }

    override func tearDownWithError() throws {
        arrayOperations = nil
        try super.tearDownWithError()
    }

    func testGenerateIntArray() {
        let expectation = XCTestExpectation(description: "Generate int array")
        arrayOperations.generateIntArray { timeInSeconds in
            XCTAssertGreaterThan(timeInSeconds, 0, "Generating int array should take some time")
            expectation.fulfill()
        }
    }
}

final class SetOperationsTests: XCTestCase {
    var setOperations: SetOperations!

    override func setUpWithError() throws {
        try super.setUpWithError()
        setOperations = SetOperations()
    }

    override func tearDownWithError() throws {
        setOperations = nil
        try super.tearDownWithError()
    }

    // Test findMatchingCharacters
    func testSetMatchChars() throws {
        let text1 = "Temp"
        let text2 = "amper"
        let expectedResult = "emp"
        
        let setOperationsResult = setOperations.findMatchingCharacters(textFull: text1, textCharacters: text2)
        
        let expectedSet = Set(expectedResult)
        let resultSet = Set(setOperationsResult)
        XCTAssertEqual(expectedSet, resultSet)
    }

    // Test findNonMatchingCharacters
    func testSetNotMatchChars() throws {
        let text1 = "Temp"
        let text2 = "amper"
        let expectedResult = "Tar"
        
        let setOperationsResult = setOperations.findNonMatchingCharacters(textFull: text1, textCharacters: text2)
        
        let expectedSet = Set(expectedResult)
        let resultSet = Set(setOperationsResult)
        XCTAssertEqual(expectedSet, resultSet)
    }

    // Test findUniqueCharacters
    func testSetUniqueChars() throws {
        let text1 = "Temp"
        let text2 = "amper"
        let expectedResult = "T"
        
        let setOperationsResult = setOperations.findUniqueCharacters(textFull: text1, textCharacters: text2)
        
        XCTAssertEqual(expectedResult, setOperationsResult)
    }
}

final class DictionaryOperationsTests: XCTestCase {
    var dictionaryOperations: DictionaryOperations!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dictionaryOperations = DictionaryOperations()
        dictionaryOperations.generateDictionaryArray()
    }

    override func tearDownWithError() throws {
        dictionaryOperations = nil
        try super.tearDownWithError()
    }

    func testFindNotExistingElenemtInDictionary() throws {
        let expectation = self.expectation(description: "Find Not Existing Element in Dictionary")

        dictionaryOperations.findNotExistingElenemtInDictionary { (time, flag) in
            XCTAssertEqual(flag, 0, "The flag should be 0 as the element does not exist")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
