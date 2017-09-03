//
//  LOCATION+CoreDataProperties.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/04.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation
import CoreData


extension LOCATION {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LOCATION> {
        return NSFetchRequest<LOCATION>(entityName: "LOCATION")
    }

    @NSManaged public var id: Int32
    @NSManaged public var locationname: String?

}
