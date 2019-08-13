//
//  Hostelworld_TestUITests.swift
//  Hostelworld_TestUITests
//
//  Created by Mohsen Qaysi on 8/9/19.
//  Copyright © 2019 Mohsen Qaysi. All rights reserved.
//

import XCTest

class Hostelworld_TestUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testExample() {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testFristCell() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 0).tap()
        collectionViewsQuery.otherElements.collectionViews.cells.children(matching: .other).element.tap()
        
        let element = collectionViewsQuery.otherElements.collectionViews.cells.children(matching: .other).element
        element.swipeLeft()
        
        // check id the data were set correctlly on the detial view
        app.navigationBars["STF Vandrarhem Stigbergsliden"].otherElements["STF Vandrarhem Stigbergsliden"].tap()
        XCTAssertTrue(collectionViewsQuery.staticTexts["STF Vandrarhem Stigbergsliden"].exists)
        XCTAssertTrue(collectionViewsQuery.staticTexts["Stigbergsliden 10  Gothenburg Sweden"].exists)
        XCTAssertTrue(collectionViewsQuery.staticTexts["82"].exists)
        
        app.swipeUp()
        app.swipeUp()
        
       XCTAssertTrue(collectionViewsQuery.staticTexts["• Child Friendly\n• Credit Cards Accepted\n• No Curfew\n• Non Smoking\n• Pet Friendly\n• Taxes Included\n"].exists)
        
    }
    
    func testFristCellMapView() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 0).tap()
        collectionViewsQuery.cells.otherElements.containing(.link, identifier:"Legal").children(matching: .other).element.children(matching: .map).element.tap()
        
           let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textView).element
        
        if let value = textView.value as? String {
            XCTAssertEqual(value,"Public transportation: Take the tram number 3, 9 or 11 to 'Stigbergstorget', it takes about 10 min from the centralstation. Walk back down the hill app 100m, the hostel will be on your right side.\r\n\r\nCar: Drive towards 'centrum'. Follow the signs towards 'Fredrikshavn'. Chose exit 'Fiskhamnsmotet' and follow the sign to 'Majorna'. Turn left at the first traffic light to Karl Johansgatan and continue up the hill and down again, the street has now changed name to 'Stigbergsliden'. You find us on nr 10.")
        }
    }
}
