//
//  User.swift
//  Sidekicks
//
//  Created by mac rent on 14/05/2016.
//  Copyright © 2016 Jacob Paris. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?

}
