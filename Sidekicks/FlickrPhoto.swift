//
//  FlickrPhoto.swift
//  Sidekicks
//
//  Created by mac rent on 20/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhoto {
    
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_m.jpg")!
    }
    
}
