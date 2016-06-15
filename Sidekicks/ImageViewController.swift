//
//  LoadingController.swift
//  Sidekicks
//
//  Created by Jacob Paris on 2/04/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet var bigImage: UIImageView!
    
    @IBOutlet weak var favouriteImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    var model = Model.sharedInstance
    
    var isFavouriteView: Bool = false
    
    @IBAction func likeButtonPress(sender: AnyObject) {
        if liked == false {
            liked = true
            favouriteImage.image = UIImage(named: "like_selected")
            for (name, _) in model.likedImageNames {
                if name == imageName {
                    model.likedImageNames[imageName] = true
                }
            }
        }
        else {
            liked = false
            favouriteImage.image = UIImage(named: "favourite")
            for (name, _) in model.likedImageNames  {
                if name == imageName {
                    model.likedImageNames[imageName] = false
                }
            }
        }
        
    }
    
    var imageToDisplay = UIImage()
    
    var imageName: String = String()
    
    var liked: Bool = false
    
    override func viewWillAppear(animated: Bool) {
        for (name, hasLiked) in model.likedImageNames {
            if name == imageName {
                if hasLiked {
                    liked = true
                    favouriteImage.image = UIImage(named: "like_selected")
                } else {
                    liked = false
                    favouriteImage.image = UIImage(named: "favourite")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(ImageViewController.returnToHome))
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(ImageViewController.returnToHome))
        
        rightSwipe.direction = .Right
        leftSwipe.direction = .Left
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        
        //let homeView: HomeController = HomeController(nibName: nil, bundle: nil)
        
        print(imageToDisplay)
        bigImage.image = imageToDisplay
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnToHome(){
        [self .performSegueWithIdentifier("imageToHome", sender: self)]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imageToHome"{
            let controller = segue.destinationViewController as! HomeController
            controller.favouriteView = isFavouriteView
        }
    }



}

