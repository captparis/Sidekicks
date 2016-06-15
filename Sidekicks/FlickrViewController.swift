//
//  FlickrViewController.swift
//  Sidekicks
//
//  Created by mac rent on 20/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class FlickrViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    
    var flickrSearch = FlickrSearch()
    
    var searchResults: [String] = []
    
    var counter:Int = 0
    
    
    @IBAction func searchButtonPress(sender: AnyObject) {
        getImages()
    }
    
    
    let FLICKR_API_KEY:String = "9a286bdcb2e5718cdff6d0cdfd1027a9"
    let FLICKR_URL:String = "https://api.flickr.com/services/rest/"
    let SEARCH_METHOD:String = "flickr.photos.search"
    let FORMAT_TYPE:String = "json"
    let JSON_CALLBACK:Int = 1
    let PRIVACY_FILTER:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchField.delegate = self
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let searchResultCellIdentifier = "SearchResultCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(searchResultCellIdentifier, forIndexPath: indexPath)
        //cell.imageView.image
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("PhotoSegue", sender: self)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    
    //Get image from URL - run in separate thread to prevent freezing
    func urlToImageView(imageNum: Int){
        print ("The image string found is " + searchResults[imageNum])
        let fileUrl = NSURL(fileURLWithPath: searchResults[imageNum])
        //searchImageView.sd_setImageWithURL(fileUrl)
        
        let url = NSURL(string: self.searchResults[imageNum])
        let imageData = NSData(contentsOfURL: url!)
        if(imageData != nil){
            self.searchImageView.image = UIImage(data: imageData!)
            print ("Set imageString to UIImage")
            
        } else {
            print ("Failed to find image")
        }

        
        /*
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            dispatch_async(dispatch_get_main_queue(), {
                let url = NSURL(string: self.searchResults[imageNum])
                let imageData = NSData(contentsOfURL: url!)
                if(imageData != nil){
                    self.searchImageView.image = UIImage(data: imageData!)
                    print ("Set imageString to UIImage")
                    
                } else {
                    print ("Failed to find image")
                }
                
            });
        });*/
        
    }
    
    func getImages(){
        displayImage()
        //urlToImageView(imageString)
    }
    
    func displayImagesTest(){
        
    }
    
    
    func displayImage(){
        
        //let random = Int(arc4random_uniform(UInt32(100))) as Int
        
        
        Alamofire.request(.GET, "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=294e72a918044d22512d1188d7da408d&tags=cute&format=json&nojsoncallback=1&auth_token=72157668284412202-5a84a22adb18b035&api_sig=c8af9f8af8e5717374119317c8a65d49")
            .responseJSON { response in
                print("REQUEST IS ")
                print(response.request)
                print ("DATA IS ")
                print(response.data)     // server data
                print ("RESULT IS ")
                print(response.result)   // result of response serialization
                print ("VALUE IS ")
                print(response.result.value)
                let data = response.result.value
                
                /*
 FLICKR_URL, parameters: ["method": SEARCH_METHOD, "api_key": FLICKR_API_KEY, "tags":searchField.text!,"privacy_filter":PRIVACY_FILTER, "format":FORMAT_TYPE, "nojsoncallback": JSON_CALLBACK]
 */

        
                if(data != nil){
                    
                    var json:JSON = JSON(data!)
                    var innerJson:JSON = JSON(data!)
                    
                    for var i = 1; i <= 5; i++ {
                    
                    let farm:String = innerJson["photos"]["photo"][i]["farm"].stringValue
                    let server:String = innerJson["photos"]["photo"][i]["server"].stringValue
                    let photoID:String = innerJson["photos"]["photo"][i]["id"].stringValue
                    
                    let secret:String = innerJson["photos"]["photo"][i]["secret"].stringValue
                    
                    let imageString:String = "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_n.jpg/"
                    
                    
                    //var farm:String = "1"
                    //var server:String = "2"
                    //var photoID:String = "1418878"
                    //var secret:String = "1e92283336"
                    
                    //var imageString:String = "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_n.jpg/"
 
                    print("value of farm is " + farm)
                    print("value of server is " + server)
                    print("value of photoID is " + photoID)
                    print("value of secret is " + secret)
                    
                    self.searchResults.append(imageString)
                    
                    self.urlToImageView(0)
                    //self.counter + 1
                    }
                    
                    
                }
        }
        
    }
 
    
}