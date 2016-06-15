//
//  HomeController.swift
//  Sidekicks
//
//  Created by Jacob Paris on 2/04/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var petStatusBar: UITextField!
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var globalGalleryBtn: UIButton!
    @IBOutlet weak var favouritesGalleryBtn: UIButton!
    @IBOutlet weak var petName: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    
    
    @IBAction func globalGalleryPress(sender: AnyObject) {
        swapGalleryView(true)
    }
    
    @IBAction func favouritesGalleryPress(sender: AnyObject) {
        swapGalleryView(false)
    }
    
    @IBAction func cameraButtonPress(sender: AnyObject) {
        performSegueWithIdentifier("homeToImagePicker", sender: nil)
    }
    //var imageData: [String] = [String]()
    var imageCounter: Int = 0
    
    var model = Model.sharedInstance
    
    var favouriteView: Bool = false
    
    var selectedImage = UIImage()
    var selectedImageName = String()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preparing for segue")
        if segue.identifier == "homeToImage"{
            let controller = segue.destinationViewController as! ImageViewController
            controller.imageToDisplay = selectedImage
            controller.imageName = selectedImageName
            if favouriteView {
                controller.isFavouriteView = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petStatusBar.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        setUser()
        // Do any additional setup after loading the view, typically from a nib.
        globalGalleryBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        favouritesGalleryBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        cameraButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        imagesCollection.reloadData()
        
        if favouriteView {
            favouritesGalleryBtn.setImage(UIImage(named: "favouriteViewSelected"), forState: .Normal)
            globalGalleryBtn.setImage(UIImage(named: "map"), forState: .Normal)
        }
        else {
            favouritesGalleryBtn.setImage(UIImage(named: "favouriteView"), forState: .Normal)
            globalGalleryBtn.setImage(UIImage(named: "mapSelected"), forState: .Normal)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        setPetDetails()
        imagesCollection.reloadData()
        //self.collectionView!.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToImage(){
        [self .performSegueWithIdentifier("homeToImage", sender: self)]
    }
    
    
    //Fill gallery with all images outlined in the string array
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! MyImageCell
        cell.backgroundColor = UIColor.blackColor()
        if (!favouriteView){
            if self.imageCounter >= model.images.count {
                self.imageCounter = 0
            }
            cell.image.image = model.images[self.imageCounter]
            self.imageCounter += 1
        }
        else {
            if self.imageCounter >= model.likedImages.count {
                self.imageCounter = 0
            }
            cell.image.image = model.likedImages[self.imageCounter]
            self.imageCounter += 1
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        var index = indexPath.row
        if (index >= model.images.count){
            index -= model.images.count
        }
        if (!favouriteView){
            selectedImage = model.images[index]
            selectedImageName = model.imageNames[index]
            goToImage()
        }
        else {
            selectedImage = model.likedImages[index]
            selectedImageName = model.likedGalleryNames[index]
            goToImage()
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if favouriteView {
             return model.likedImages.count
        }
        else {
            return 24
        }
       
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func textFieldDidChange(textField: UITextField){
        let pet = model.getSinglePet()
        pet.petStatus = textField.text!
        model.updateDatabase()
    }
    
    
    //Pet profile
    func setPetDetails(){
        
        //Check if initial pet has been created - if not, create
            var pet: Pet
            if (!model.checkForPet()){
                print ("No Pet found, creating a default pet")
                pet = model.createPet("Twig", breed: "Abysinnian", status: "Lounging around", favActivity: "Eating cables")
            }
            else {
                print ("At least one pet found, using first pet for profile view")
                //let rowToSelect: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                pet = model.getSinglePet()
            }
            
            petName.text = pet.petName
            petStatusBar.text = pet.petStatus
        
        
    }
    
    func swapGalleryView(isGlobal: Bool){
        imageCounter = 0
        if isGlobal && favouriteView == true {
            favouriteView = false
            imagesCollection.reloadData()
            favouritesGalleryBtn.setImage(UIImage(named: "favouriteView"), forState: .Normal)
            globalGalleryBtn.setImage(UIImage(named: "mapSelected"), forState: .Normal)
        }
        else if !isGlobal && favouriteView == false {
            favouriteView = true
            model.getLikedImages()
            imagesCollection.reloadData()
            favouritesGalleryBtn.setImage(UIImage(named: "favouriteViewSelected"), forState: .Normal)
            globalGalleryBtn.setImage(UIImage(named: "map"), forState: .Normal)
            
        }
        
    }
    
    
    //Core Data functions - practicing alternate way to use CoreData
    
    func setUser(){
        let moc = DataController().managedObjectContext
        
        let userEntity = NSEntityDescription.insertNewObjectForEntityForName("UserEntity", inManagedObjectContext: moc) as! User
        
        userEntity.setValue("Jacob", forKey: "firstName")
        userEntity.setValue("Paris", forKey: "lastName")
        
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        fetch()
    }
    
    func fetch(){
        let moc = DataController().managedObjectContext
        let userFetch = NSFetchRequest(entityName: "UserEntity")
        
        do {
            let fetchedUser = try moc.executeFetchRequest(userFetch) as! [User]
            print (fetchedUser.first!.firstName!)
        }
        
        catch {
            fatalError("Failed to fetch user: \(error)")
        }
    }


}

