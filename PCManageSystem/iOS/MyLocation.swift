//
//  MyLocation.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/07.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation





class MyLocation {
    
    public var id: Int32
    public var locationname: String?
    
    init(id:Int32, location:String) {
        self.id = id
        self.locationname = location
    }
    init(data:LOCATION) {
        self.id = data.id
        self.locationname = data.locationname
        
    }
}
