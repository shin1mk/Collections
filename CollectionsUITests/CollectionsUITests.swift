//
//  CollectionsUITests.swift
//  CollectionsUITests
//
//  Created by SHIN MIKHAIL on 06.07.2023.
//

import XCTest

class MainControllerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testOpenSetViewController() {
        let setCell = app.tables.staticTexts["Set"]
        XCTAssertTrue(setCell.waitForExistence(timeout: 3))
        setCell.tap()
        
        _ = app.navigationBars.staticTexts["SetViewController"]
        
        let firstTextField = app.textFields["firstTextField"]
        let secondTextField = app.textFields["secondTextField"]
        
        firstTextField.tap()
        firstTextField.typeText("hello")
        secondTextField.tap()
        secondTextField.typeText("world")
        
        let showMatchingCharactersButton = app.buttons["showMatchingCharactersButton"]
        showMatchingCharactersButton.tap()
    }
}
