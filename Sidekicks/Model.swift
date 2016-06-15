//
//  Model.swift
//  Sidekicks
//
//  Created by mac rent on 13/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Model {
    
    var imageData: [String] = [String]()
    
    var images: [UIImage] = [UIImage]()
    
    var likedImages: [UIImage] = [UIImage]()
    
    //Special array of names used to keep track of names of only the liked images
    var likedGalleryNames: [String] = [String]()
    
    var imageNames: [String] = [String]()
    
    var likedImageNames: [String:Bool] = [:]
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let petRequest = NSFetchRequest(entityName: "PetEntity")
    
    var managedContext: NSManagedObjectContext {
        get {
            return appDelegate.managedObjectContext
        }
    }

    
    var petsDB = [NSManagedObject]()
    
    init (){
        petRequest.fetchLimit = 1
        
        imageData = ["puppy", "dogpark", "guineapig", "bird", "hedgehog", "boydog", "guineapig2", "guineapig3", "dogbow", "catanddog", "guineapig4", "guineapig5"]
        
        for imageName in imageData {
            images.append(UIImage(named: imageName)!)
            imageNames.append(imageName)
            likedImageNames[imageName] = false
            //images[imageName] = UIImage(named: imageName)!
        }
    }
    
    //Returns a pet from CoreData - currently only one pet is stored
    func getPet(indexPath: NSIndexPath) -> Pet {
        return petsDB[indexPath.row] as! Pet
    }
    
    //Refreshes liked images - this array is only used to display liked images on home screen
    func getLikedImages(){
        likedImages.removeAll()
        likedGalleryNames.removeAll()
        for index in 0...(images.count-1){
            let imageNameCheck = imageNames[index]
            if likedImageNames[imageNameCheck] != nil {
                if likedImageNames[imageNameCheck] == true {
                    likedImages.append(images[index])
                    likedGalleryNames.append(imageNames[index])
                }
            }
        }
    }
    
    //Used to create initial pet object
    func createPet(name: String, breed: String, status:String, favActivity: String) -> Pet{
        let entity = NSEntityDescription.entityForName("PetEntity", inManagedObjectContext: managedContext)
        let pet = Pet(entity: entity!, insertIntoManagedObjectContext:managedContext)
        pet.petName = name
        pet.petStatus = status
        pet.petFavActivity = favActivity
        pet.petBreed = breed
    
        updateDatabase()
        
        return pet
    }
    
    func getSinglePet() -> Pet {
        do {
            let results:NSArray? = try managedContext.executeFetchRequest(petRequest)
            let pet = (results![0] as? Pet)!
            return pet
        }
        catch {
            fatalError("Failed to fetch pet: \(error)")
        }

    }
    
    //Checks to see if any pets have been created yet - should be run before trying to retrieve a pet
    func checkForPet() -> Bool {
        do {
            let results:NSArray? = try managedContext.executeFetchRequest(petRequest)
            if (results!.count == 0){
                return false
            }
            else {
                return true
            }
            
        }
        catch {
            fatalError("Failed to fetch pet: \(error)")
        }
        
    }
    
    //Update to object from profile page - allows changing of breed and favourite activity
    func savePetProfile(favActivity: String, breed: String, existing: Pet){
        existing.petFavActivity = favActivity
        existing.petBreed = breed
    }
    
    //Update to status from home page
    func savePetStatus(status: String, existing: Pet){
        existing.petStatus = status
    }


    //Struct to hold instance of object
    private struct Static
    {
        static var instance: Model?
    }
    
    //Enforce singleton - return instance if instance exists, instantiate if not
    class var sharedInstance: Model
    {
        if !(Static.instance != nil)
        {
            Static.instance = Model()
        }
        return Static.instance!
    }
    
    
    
    //Adds a new image to the gallery
    //As there is no way to input a name for new images a random ID is assigned
    internal func addImage (newImage: UIImage){
        images.append(newImage)
        let randomName = randomStringWithLength(10)
        imageNames.append(randomName)
        likedImageNames[randomName] = false
        print ("New image added")
    }
    
    func randomStringWithLength (len:Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return String(randomString)
    }
    
    
    // Save the current state of the objects in the managed context into the
    // database.
    func updateDatabase()
    {
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
