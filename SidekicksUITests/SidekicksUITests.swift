//
//  SidekicksUITests.swift
//  SidekicksUITests
//
//  Created by John Gregg on 2/04/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import XCTest

class SidekicksUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Test if loading screen works before calling other tests
    //Important that other tests run after this or will fail as they will not wait before attempting to move forward
    /*func testLoad(){
        let app = XCUIApplication()
        
        //Set up check for label after loading screen, confirms home screen
        let label = app.staticTexts["Your Sidekicks"]
        
        let exists = NSPredicate(format: "exists==true")
        
        expectationForPredicate(exists, evaluatedWithObject: label, handler:nil)
        
        //Wait 4 seconds before giving up on home screen load
        waitForExpectationsWithTimeout (4, handler:nil)
        
        confirmButtons()
    }
    
    //Confirm number of buttons
    func confirmButtons() {
        
        let app = XCUIApplication()
        
        let window = XCUIApplication().childrenMatchingType(.Window).elementBoundByIndex(0)
        
        confirmGrid()
        
        //Move to profile view
        window.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Button).matchingIdentifier("Button").elementBoundByIndex(1).tap()
        
        //Confirms only two buttons on profile page (home and upload)
        XCTAssertEqual(app.buttons.count, 2)
        
        //Move back to home view
        window.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.childrenMatchingType(.Button).matchingIdentifier("Button").elementBoundByIndex(0).tap()
        
        //Move to image view
        window.childrenMatchingType(.Other).elementBoundByIndex(2).childrenMatchingType(.Other).element.tap()
        
        //Confirms no buttons in image view
        XCTAssertEqual(app.buttons.count, 0)
        
        // Move back to home view
        window.childrenMatchingType(.Other).elementBoundByIndex(3).childrenMatchingType(.Other).element.tap()
        
    }
    
    //Confirm we have a grid of 21 cells on the home page
    func confirmGrid(){
        let app = XCUIApplication()
        XCTAssertEqual(app.collectionViews.cells.count, 21)
    }*/
}
