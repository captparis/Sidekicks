//
//  FlickrSearchViewController.swift
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

class FlickrSearchViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var flickrSearch = FlickrSearch.sharedInstance
    
    var counter:Int = 0
    
    var pageCounter: Int = 0
    
    var testImage: UIImage?
    
    var searched: Bool = false
    
    var currentSearchString: String = String()
    
    let FLICKR_API_KEY:String = "9a286bdcb2e5718cdff6d0cdfd1027a9"
    let FLICKR_URL:String = "https://api.flickr.com/services/rest/"
    let SEARCH_METHOD:String = "flickr.photos.search"
    let FORMAT_TYPE:String = "json"
    let JSON_CALLBACK:Int = 1
    let PRIVACY_FILTER:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(self.nextPage))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(self.nextPage))
        rightSwipe.direction = .Right
        leftSwipe.direction = .Left
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
    }
    
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        pageCounter = 0
        searchBar.resignFirstResponder()
        currentSearchString = searchBar.text!
        displayImage(currentSearchString)
        print("Search bar text is " + searchBar.text!)
    }
       

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell.textLabel!.text = String(" ")
        if (flickrSearch.searchImages.count > indexPath.row){
            cell.imageView!.image = flickrSearch.searchImages[indexPath.row]
            cell.textLabel!.text = flickrSearch.searchTitles[indexPath.row]
        }
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("imagePicker", sender: tableView)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        let indexPath = self.tableView.indexPathForSelectedRow!
        let imagePicker = segue.destinationViewController as! ImagePickerController
        imagePicker.flickrSelection(indexPath.row)
        
    }
    
    
    
    //Get image from URL 
    //FIXME should run in separate thread to prevent freezing
    func urlToImageView(imageNum: Int){
        print ("The image string found is " + flickrSearch.searchResults[imageNum])
        //let fileUrl = NSURL(fileURLWithPath: searchResults[imageNum])
        //searchImageView.sd_setImageWithURL(fileUrl)
        
        let url = NSURL(string: flickrSearch.searchResults[imageNum])
        let imageData = NSData(contentsOfURL: url!)
        if(imageData != nil){
            flickrSearch.searchImages.append(UIImage(data: imageData!)!)
            print ("Set imageString to UIImage")
            
        } else {
            print ("Failed to find image")
            pageCounter = -10
        }
        
    }
    
    
    
    func displayImage(searchString: String){
        flickrSearch.searchResults.removeAll()
        flickrSearch.searchImages.removeAll()
        flickrSearch.searchTitles.removeAll()
        let escapedSearchString: String = searchString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        var urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FLICKR_API_KEY)&tags=\(escapedSearchString)&per_page=25&format=json&nojsoncallback=1"
        
        Alamofire.request(.GET, urlString)
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
                
                
                
                if(data != nil){
                    
                    var innerJson:JSON = JSON(data!)
                    
                    for var i = 1; i <= 10; i += 1 {
                        
                        let farm:String = innerJson["photos"]["photo"][i + self.pageCounter]["farm"].stringValue
                        let server:String = innerJson["photos"]["photo"][i + self.pageCounter]["server"].stringValue
                        let photoID:String = innerJson["photos"]["photo"][i + self.pageCounter]["id"].stringValue
                        let title:String = innerJson["photos"]["photo"][i + self.pageCounter]["title"].stringValue
                        
                        let secret:String = innerJson["photos"]["photo"][i + self.pageCounter]["secret"].stringValue
                        
                        let imageString:String = "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_n.jpg/"
                        
                        
                        
                        self.flickrSearch.searchResults.append(imageString)
                        self.flickrSearch.searchTitles.append(title)
                        
                        self.urlToImageView(self.counter)
                        self.counter++
                    }
                    self.counter = 0
                    self.tableView.reloadData()
                    self.searched = true
                    
                }
        }
        
        
    }
    
    func nextPage(){
        if searched {
            pageCounter += 10
            displayImage(currentSearchString)
        }
    }
    
    
}