//
//  USER+CoreDataProperties.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/05.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation
import CoreData


extension USER {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<USER> {
        return NSFetchRequest<USER>(entityName: "USER")
    }

    @NSManaged public var id: Int32
    @NSManaged public var username: String?
    @NSManaged public var pass: String?

}
