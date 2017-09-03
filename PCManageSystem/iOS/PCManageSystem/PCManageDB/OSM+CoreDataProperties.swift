//
//  OSM+CoreDataProperties.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/04.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation
import CoreData


extension OSM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OSM> {
        return NSFetchRequest<OSM>(entityName: "OSM")
    }

    @NSManaged public var id: Int32
    @NSManaged public var osname: String?

}
