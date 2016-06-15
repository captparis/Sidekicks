//
//  Photo.swift
//  Sidekicks
//
//  Created by mac rent on 21/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Photo: NSManagedObject {
    @NSManaged var photoName: String
    @NSManaged var photoImage: UIImage
    @NSManaged var liked: Bool
}
