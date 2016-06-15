//
//  HomeTests.swift
//  Sidekicks
//
//  Created by mac rent on 22/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import XCTest
import UIKit
import CoreData
@testable import Sidekicks

var homeController: HomeController!
var model = Model.sharedInstance

class HomeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeController") as! HomeController
        homeController.model = model
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCollectionViewSetup(){
        XCTAssertNil(homeController.imagesCollection)
        
        let _ = homeController.view
        
        XCTAssertTrue(homeController.imagesCollection != nil, "Image gallery should have been instantiated")
        XCTAssertTrue(homeController.imagesCollection.numberOfSections() == 1, "Collection should only have one section")
        XCTAssertTrue(homeController.imagesCollection.numberOfItemsInSection(1) > 0, "There should be at least one image in the gallery")
    }
    
    func testCreatePet(){
        //when
        homeController.petName = UITextField()
        homeController.petStatusBar = UITextField()
        let _ = homeController.view
        homeController.setPetDetails()

        
        //then
        XCTAssert(model.checkForPet(), "At least one pet should exist")
        
    }
    
    
    
    
    
}
