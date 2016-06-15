//
//  Pet.swift
//  Sidekicks
//
//  Created by mac rent on 19/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import CoreData

class Pet: NSManagedObject {
    @NSManaged var petName: String
    @NSManaged var petStatus: String
    @NSManaged var petBreed: String
    @NSManaged var petFavActivity: String
}
