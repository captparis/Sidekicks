//
//  TodayViewController.swift
//  SidekicksCounter
//
//  Created by mac rent on 20/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var newImages: UILabel!
    @IBOutlet weak var totalImages: UILabel!
    @IBOutlet weak var toggleImagePreviewButton: UIButton!
    @IBOutlet weak var image1height: NSLayoutConstraint!
    @IBOutlet weak var image2height: NSLayoutConstraint!
    @IBOutlet weak var image3height: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imagesView: UIView!
    
    var imageData: [String] = [String]()
    var images: [UIImage] = [UIImage]()
    var imagesExpanded = false
    
    @IBAction func toggleImagePreview(sender: AnyObject) {
        if imagesExpanded {
            imageViewHeightConstraint.constant = 0
            image1.hidden = true
            image2.hidden = true
            image3.hidden = true
            
            let transform = CGAffineTransformMakeRotation(0)
            toggleImagePreviewButton.transform = transform
            imagesExpanded = false
        } else {
            imageViewHeightConstraint.constant = 98
            
            image1.hidden = false
            image2.hidden = false
            image3.hidden = false
            let transform = CGAffineTransformMakeRotation(CGFloat(180.0 * M_PI/180.0))
            toggleImagePreviewButton.transform = transform
            imagesExpanded = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image1height.constant = 0
        image2height.constant = 0
        image3height.constant = 0
        imageViewHeightConstraint.constant = 0
        
        image1.hidden = true
        image2.hidden = true
        image3.hidden = true
        
        imageData = ["puppy", "dogpark", "guineapig", "bird", "hedgehog", "boydog", "guineapig2", "guineapig3", "dogbow", "catanddog", "guineapig4", "guineapig5"]
        
        for imageName in imageData {
            images.append(UIImage(named: imageName)!)
        }
        
        var num1: Int = Int()
        var num2: Int = Int()
        var num3: Int = Int()
        
        let count = UInt32(images.count)
        
        num1 = Int(arc4random_uniform(count))
        while num1 == num2 {
            num2 = Int(arc4random_uniform(count))
        }
        while num1 == num3 || num2 == num3 {
            num3 = Int(arc4random_uniform(count))
        }
        
        image1.image = images[num1]
        image2.image = images[num2]
        image3.image = images[num3]
        
        totalImages.text = "Total: 514"
        newImages.text = "+12 today"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //TODO add code to update total number of images and new images
    }
    
    func widgetMarginInsetsForProposedMarginInsets
        (defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
        return UIEdgeInsetsZero
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
