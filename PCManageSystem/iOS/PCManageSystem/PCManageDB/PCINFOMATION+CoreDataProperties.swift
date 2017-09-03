//
//  PCINFOMATION+CoreDataProperties.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/04.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation
import CoreData


extension PCINFOMATION {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PCINFOMATION> {
        return NSFetchRequest<PCINFOMATION>(entityName: "PCINFOMATION")
    }

    @NSManaged public var id: Int32
    @NSManaged public var osid: Int32
    @NSManaged public var locationid: Int32
    @NSManaged public var pcno: String?
    @NSManaged public var model: String?
    @NSManaged public var officecheck: Int32
    @NSManaged public var securitycheck: Int32
    @NSManaged public var damagedcheck: Int32
    @NSManaged public var delflag: Int32
    @NSManaged public var insertdate: NSDate?
    @NSManaged public var updatedate: NSDate?

}
