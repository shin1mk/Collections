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
        let expectation = XCTestExpectation()
        arrayOperations.generateIntArray { timeInSeconds in
            XCTAssertGreaterThan(timeInSeconds, 0)
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
    //findMatchingCharacters
    func testSetMatchingCharacters() throws {
        let text1 = "hello"
        let text2 = "world"
        let expectedResult = "lo"
        let setOperationsResult = setOperations.findMatchingCharacters(textFull: text1, textCharacters: text2)
        let expectedSet = Set(expectedResult)
        let resultSet = Set(setOperationsResult)
        XCTAssertEqual(expectedSet, resultSet)
    }
    //findNonMatchingCharacters
    func testSetNotMatchingCharacters() throws {
        let text1 = "hello"
        let text2 = "world"
        let expectedResult = "rhwde"
        let setOperationsResult = setOperations.findNonMatchingCharacters(textFull: text1, textCharacters: text2)
        let expectedSet = Set(expectedResult)
        let resultSet = Set(setOperationsResult)
        XCTAssertEqual(expectedSet, resultSet)
    }
    //findUniqueCharacters
    func testSetUniqueCharacters() throws {
        let text1 = "hello"
        let text2 = "world"
        let expectedResult = "eh"
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
        let expectation = self.expectation(description: "Find Not Existing")
        dictionaryOperations.findNotExistingElenemtInDictionary { (time, flag) in
            XCTAssertEqual(flag, 0, "does not exist")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
