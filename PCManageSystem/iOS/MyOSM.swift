//
//  MyOSM.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/07.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation



class MyOSM {
    
    public var id: Int32
    public var osname: String?
    
    init(data:OSM) {
        self.id = data.id
        self.osname = data.osname
        
    }
}
