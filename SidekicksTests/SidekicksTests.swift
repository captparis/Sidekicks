//
//  SidekicksTests.swift
//  SidekicksTests
//
//  Created by John Gregg on 2/04/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import XCTest
@testable import Sidekicks

class SidekicksTests: XCTestCase {
    
    var flickrController: FlickrSearchViewController!
    
    override func setUp() {
        super.setUp()
        //let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        //flickrController = storyboard.instantiateInitialViewController() as! FlickrSearchViewController!
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONRetrieval(){
        //XCTAssert(true)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
