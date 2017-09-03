//
//  MyDataController.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/05.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import Foundation
import CoreData

class MyDataController: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "PCManageSystem")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
//    func getContext () -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
//    
    
    
    func syncPCInfomation() -> Bool {
        let result:Bool = false
        
        let userNameValue = "nampg"
        let scriptUrl = "http://localhost/PCManageSystem/pcinfosync.php"
        // Add one parameter
        let urlWithParams = scriptUrl + "?userName=\(userNameValue)"
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlWithParams);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error roi")
                return
            }
            
            
            do {
                if let convertedJsonIntoNSArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    
                    
                    
                    for object in convertedJsonIntoNSArray {
                        if let tempPcinfoDict = object as? NSDictionary {
                            print(tempPcinfoDict)
                            let context = self.persistentContainer.viewContext
                            let entity =  NSEntityDescription.entity(forEntityName: "PCINFOMATION", in: context)
                            
                            let tempPCinfo = NSManagedObject(entity: entity!, insertInto: context) as! PCINFOMATION
                            tempPCinfo.id = (tempPcinfoDict.object(forKey: "No") as! NSString).intValue
                            tempPCinfo.osid = (tempPcinfoDict.object(forKey: "OS") as! NSString).intValue
                            tempPCinfo.locationid = (tempPcinfoDict.object(forKey: "Location") as! NSString).intValue
                            tempPCinfo.pcno = tempPcinfoDict.object(forKey: "PCNo") as? String
                            tempPCinfo.model = tempPcinfoDict.object(forKey: "Model") as? String
                            tempPCinfo.officecheck = (tempPcinfoDict.object(forKey: "OfficeCheck") as! NSString).intValue
                            tempPCinfo.securitycheck = (tempPcinfoDict.object(forKey: "SecurityCheck") as! NSString).intValue
                            tempPCinfo.damagedcheck = (tempPcinfoDict.object(forKey: "DamagedCheck") as! NSString).intValue
                            tempPCinfo.delflag = (tempPcinfoDict.object(forKey: "DelFlg") as! NSString).intValue
                            tempPCinfo.insertdate = tempPcinfoDict.object(forKey: "InsertDate") as? NSDate
                            tempPCinfo.updatedate = tempPcinfoDict.object(forKey: "UpdateDate") as? NSDate
                            
                            do {
                                try context.save()
                                print("saved PCInfo!")
                            } catch let error as NSError  {
                                print("Could not save \(error), \(error.userInfo)")
                            } catch {
                                
                            }
                            
                            /*
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
                            
                            */
                        }
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
        
        return result
    }
    
    
    
    
    func syncOSM() -> Bool {
        let result:Bool = false
        
        let userNameValue = "nampg"
        let scriptUrl = "http://localhost/PCManageSystem/osmsync.php"
        // Add one parameter
        let urlWithParams = scriptUrl + "?userName=\(userNameValue)"
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlWithParams);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error roi")
                return
            }
            
            
            do {
                if let convertedJsonIntoNSArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    
                    
                    
                    for object in convertedJsonIntoNSArray {
                        if let tempOSMDict = object as? NSDictionary {
                            print(tempOSMDict)
                            
                            
                            let context = self.persistentContainer.viewContext
                            let entity =  NSEntityDescription.entity(forEntityName: "OSM", in: context)
                            
                            let tempOSM = NSManagedObject(entity: entity!, insertInto: context) as! OSM
                            tempOSM.id = (tempOSMDict.object(forKey: "No") as! NSString).intValue
                            tempOSM.osname = tempOSMDict.object(forKey: "OSName") as? String
                            
                            
                            /*
 
                             @NSManaged public var id: Int32
                             @NSManaged public var osname: String?

 
                             */
                            
                            
                            do {
                                try context.save()
                                print("saved OSM!")
                            } catch let error as NSError  {
                                print("Could not save \(error), \(error.userInfo)")
                            } catch {
                                
                            }
                            
                        }
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
        
        return result
    }
    
    
    
    
    func syncLocationm() -> Bool {
        let result:Bool = false
        
        let userNameValue = "nampg"
        let scriptUrl = "http://localhost/PCManageSystem/locationmsync.php"
        // Add one parameter
        let urlWithParams = scriptUrl + "?userName=\(userNameValue)"
        // Create NSURL Ibject
        let myUrl = NSURL(string: urlWithParams);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error roi")
                return
            }
            
            
            do {
                if let convertedJsonIntoNSArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    
                    
                    
                    for object in convertedJsonIntoNSArray {
                        if let tempLocationDict = object as? NSDictionary {
                            print(tempLocationDict)
                            
                            
                            let context = self.persistentContainer.viewContext
                            let entity =  NSEntityDescription.entity(forEntityName: "LOCATION", in: context)
                            
                            let tempLocation = NSManagedObject(entity: entity!, insertInto: context) as! LOCATION
                            tempLocation.id = (tempLocationDict.object(forKey: "No") as! NSString).intValue
                            tempLocation.locationname = tempLocationDict.object(forKey: "Location") as? String
                            
                            
                            /*
                             
                             @NSManaged public var id: Int32
                             @NSManaged public var osname: String?
                             
                             
                             */
                            
                            
                            do {
                                try context.save()
                                print("saved Location!")
                            } catch let error as NSError  {
                                print("Could not save \(error), \(error.userInfo)")
                            } catch {
                                
                            }
                            
                        }
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        
        
        return result
    }
    
    
    
    func storeUSER () {
        let context = persistentContainer.viewContext
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "USER", in: context)
        
        let user = NSManagedObject(entity: entity!, insertInto: context) as! USER
        
        //user.id = 1
        user.pass = "nam123"
        user.username = "nampgxxxx"
        
        //set the entity values
        //transc.setValue(audioFileUrlString, forKey: "audioFileUrlString")
        //transc.setValue(textFileUrlString, forKey: "textFileUrlString")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }

    func myQuery(sql: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let context = persistentContainer.viewContext
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "PCINFOMATION", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        let firstName = "3"
        fetchRequest.predicate = NSPredicate(format: "id == %@", firstName)
        
        
        
        
        
        do {
            
            var pcinfos  = [PCINFOMATION]()
            
            
            pcinfos = try context.fetch(fetchRequest) as! [PCINFOMATION]
            
            
            print("myQuery--------------")
            for pcinfo in pcinfos {
                
                print(pcinfo.model!)
                
            }
            
            
            
            
//            let result = try context.fetch(fetchRequest)
//            print("myQuery--------------")
//            print(result)
            
            
            
            
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    
    
    //------------------------------------------------------------------------------------------------------
    //GET ALL OBJECT FUNTIONS
    
    func getAllPCInfoList() -> NSMutableArray{
        var pcinfos  = [PCINFOMATION]()
        var result:NSMutableArray = []

        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let context = persistentContainer.viewContext
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "PCINFOMATION", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        do {
            pcinfos = try context.fetch(fetchRequest) as! [PCINFOMATION]
            result = convertPCInfoList(pcinfos: pcinfos)
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return result
    }
    
    func getAllOSMList() -> NSArray{
        var osmList  = [OSM]()
        var result = [MyOSM]()
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let context = persistentContainer.viewContext
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "OSM", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        do {
            osmList = try context.fetch(fetchRequest) as! [OSM]
            //result = convertLocationList(locationList: locationList)
            for osm in osmList{
                let temp:MyOSM = MyOSM.init(data: osm)
                result.append(temp)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return result as NSArray
    }
    
    /*
    func getAllOSMList() -> NSMutableDictionary{
        var osmList  = [OSM]()
        var result:NSMutableDictionary = [:]
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let context = persistentContainer.viewContext
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "OSM", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        do {
            osmList = try context.fetch(fetchRequest) as! [OSM]
            result = convertOSMList(osmList: osmList)
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return result
    }
    */
    func getAllLocationList() -> NSArray{
        var locationList  = [LOCATION]()
        var result = [MyLocation]()
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let context = persistentContainer.viewContext
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "LOCATION", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        do {
            locationList = try context.fetch(fetchRequest) as! [LOCATION]
            //result = convertLocationList(locationList: locationList)
            for location in locationList{
                let temp:MyLocation = MyLocation.init(data: location)
                result.append(temp)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return result as NSArray
    }
    
    
    /*
    func getAllLocationList() -> NSMutableDictionary{
        var locationList  = [LOCATION]()
        var result:NSMutableDictionary = [:]
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let context = persistentContainer.viewContext
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "LOCATION", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        do {
            locationList = try context.fetch(fetchRequest) as! [LOCATION]
            result = convertLocationList(locationList: locationList)
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return result
    }
    
    */
    //================================================================
    
    func convertPCInfoList(pcinfos:[PCINFOMATION]) -> NSMutableArray {
        let result:NSMutableArray = []
        
        for pcinfo in pcinfos{
            let temp:MyPCInfomation = MyPCInfomation.init(data: pcinfo)
            result.add(temp)
        }
        
        return result
        
    }
    
    
    func convertOSMList(osmList:[OSM]) -> NSMutableDictionary {
        let result:NSMutableDictionary = [:]
        
        for osm in osmList{
            let temp:MyOSM = MyOSM.init(data: osm)
            result[temp.id] = temp.osname
        }
        
        return result
        
    }
    
    func convertLocationList(locationList:[LOCATION]) -> NSMutableDictionary {
        let result:NSMutableDictionary = [:]
        
        for location in locationList{
            let temp:MyLocation = MyLocation.init(data: location)
            result[temp.id] = temp.locationname
        }
        
        return result
        
    }
    
    
    
    
    
    //------------------------------------------------------------------------------------------------------
    //GET ALL OBJECT FUNTIONS
    
    
    
    func deleteAllRecordsOfEntity(entity: String) {
        let context = persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    


}

