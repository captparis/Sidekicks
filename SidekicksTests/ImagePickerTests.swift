//
//  ImagePickerTests.swift
//  Sidekicks
//
//  Created by mac rent on 22/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import XCTest
import UIKit
@testable import Sidekicks

var pickerController: ImagePickerController!

class ImagePickerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        pickerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PickerController") as! ImagePickerController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testChangeFilter(){
        //given
        let random = Int(arc4random_uniform(999) + 4)
        
        //when
        pickerController.changeFilter(random)
        
        //then
        XCTAssertTrue(pickerController.filterCounter == 4, "Counter should revert to maximum number of 4 when provided number greater than 4")
    }
    
    func testFilterManagerWithoutImage(){
        //given
        XCTAssertNil(pickerController.filterManager.blurFilter, "Filters should start as nil")
        XCTAssertNil(pickerController.filterManager.bloomFilter)
        XCTAssertNil(pickerController.filterManager.vignetteFilter)
        XCTAssertNil(pickerController.filterManager.sepiaFilter)
        
        //when
        let _ = pickerController.view
        pickerController.viewWillAppear(true)
        
        //then
        XCTAssertNil(pickerController.filterManager.blurFilter, "Filters should still be nil if no image is provided at viewWillAppear")
        XCTAssertNil(pickerController.filterManager.bloomFilter)
        XCTAssertNil(pickerController.filterManager.vignetteFilter)
        XCTAssertNil(pickerController.filterManager.sepiaFilter)
    }
    
    func testFilterManagerWithImage(){
        //given
        pickerController.newImage = UIImage(named: "bird")
        XCTAssertNil(pickerController.filterManager.blurFilter, "Filters should start as nil")
        XCTAssertNil(pickerController.filterManager.bloomFilter)
        XCTAssertNil(pickerController.filterManager.vignetteFilter)
        XCTAssertNil(pickerController.filterManager.sepiaFilter)
        
        //when
        let _ = pickerController.view
        pickerController.viewWillAppear(true)
        
        //then
        XCTAssertTrue(pickerController.filterManager.blurFilter != nil, "Filters should be initialised if an image is provided at viewWillAppear")
        XCTAssertTrue(pickerController.filterManager.bloomFilter != nil)
        XCTAssertTrue(pickerController.filterManager.vignetteFilter != nil)
        XCTAssertTrue(pickerController.filterManager.sepiaFilter != nil)
    
    }
    
   
    
}
