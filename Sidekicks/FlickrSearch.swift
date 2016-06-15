//
//  FlickrSearch.swift
//  Sidekicks
//
//  Created by mac rent on 20/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class FlickrSearch {
    
    let FLICKR_API_KEY:String = "9a286bdcb2e5718cdff6d0cdfd1027a9"
    let FLICKR_URL:String = "https://api.flickr.com/services/rest/"
    let SEARCH_METHOD:String = "flickr.photos.search"
    let FORMAT_TYPE:String = "json"
    let JSON_CALLBACK:Int = 1
    let PRIVACY_FILTER:Int = 1
    
    
    var searchResults: [String] = []
    
    var searchTitles: [String] = []
    
    var searchImages: [UIImage?] = []
    
    //Struct to hold instance of object
    private struct Static
    {
        static var instance: FlickrSearch?
    }
    
    //Enforce singleton - return instance if instance exists, instantiate if not
    class var sharedInstance: FlickrSearch
    {
        if !(Static.instance != nil)
        {
            Static.instance = FlickrSearch()
        }
        return Static.instance!
    }
    
}
