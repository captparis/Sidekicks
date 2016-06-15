//
//  ProfileTests.swift
//  Sidekicks
//
//  Created by mac rent on 22/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import XCTest
import UIKit
@testable import Sidekicks

var viewController: ProfileController!

//var model = Model()

var testTextField: UITextField = UITextField()

class ProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileController") as! ProfileController
        viewController.model = model
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImageData(){
        XCTAssertTrue(viewController.imageData.count == 0, "Image data should be empty before viewDidLoad")
        
        let _ = viewController.view
        
        XCTAssertTrue(viewController.imageData.count > 0, "The image data should contain strings")
    }
    
    func testProfileSave(){
        //given
        let testString = "test"
        testTextField.text = testString
        
        
        //when
        viewController.activityDidChange(testTextField)
        viewController.breedDidChange(testTextField)
        
        //then
        let pet = viewController.model.getSinglePet()
        XCTAssertTrue(pet.petFavActivity == testString, "Fav Activity value should have been changed")
        XCTAssertTrue(pet.petBreed == testString, "Breed value should have been changed")
    }
    
    
    
}
