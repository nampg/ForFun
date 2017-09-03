//
//  MyPCInfomation.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/07.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation


class MyPCInfomation {
    public var id: Int32 = 0
    public var osid: Int32 = 0
    public var locationid: Int32 = 0
    public var model: String?
    public var officecheck: Int32 = 0
    public var securitycheck: Int32 = 0
    public var damagedcheck: Int32 = 0
    public var delflag: Int32 = 0
    public var insertdate: NSDate?
    public var updatedate: NSDate?
    public var pcno: String?
    
    
    init(data:PCINFOMATION) {
        self.id = data.id
        self.osid = data.osid
        self.locationid = data.locationid
        self.model = data.model
        self.officecheck = data.officecheck
        self.securitycheck = data.securitycheck
        self.damagedcheck = data.damagedcheck
        self.delflag = data.delflag
        self.insertdate = data.insertdate
        self.updatedate = data.updatedate
        self.pcno = data.pcno
    }
}
