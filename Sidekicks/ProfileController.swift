//
//  HomeController.swift
//  Sidekicks
//
//  Created by Jacob Paris on 8/04/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate {

    var imageData: [String] = [String]()
    var imageCounter: Int = 0
    
    var model = Model.sharedInstance
    
    @IBOutlet weak var favActivityField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favActivityField.addTarget(self, action: "activityDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        breedField.addTarget(self, action: "breedDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        // Do any additional setup after loading the view, typically from a nib.
        imageData = ["guineapig", "guineapig2", "guineapig3", "guineapig4", "guineapig5"]
        
        favActivityField.delegate = self
        breedField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        setProfileDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! MyImageCell
        cell.backgroundColor = UIColor.blackColor()
        var currImage:String = ""
        currImage = self.imageData[self.imageCounter]
        self.imageCounter += 1
        if self.imageCounter >= self.imageData.count {
            self.imageCounter = 0
        }
        cell.profileImage.image = UIImage(named: currImage)
        return cell
    }
    
    //Function to set up profile fields before showing
    func setProfileDetails(){
        //Does not need to check for existing pet as this is done in HomeController
        let pet = model.getSinglePet()
        favActivityField.text = pet.petFavActivity
        breedField.text = pet.petBreed
    }
    
    
    //Functions to update CoreData with changes to profile fields
    func activityDidChange(textField: UITextField){
        let pet = model.getSinglePet()
        pet.petFavActivity = textField.text!
        model.updateDatabase()
    }
    
    func breedDidChange(textField: UITextField){
        let pet = model.getSinglePet()
        pet.petBreed = textField.text!
        model.updateDatabase()
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 21
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }


}

