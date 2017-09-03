//
//  ViewController.swift
//  PCManageSystem
//
//  Created by Phung Nam on 2017/05/02.
//  Copyright © 2017 Phung Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    

    @IBOutlet weak var ichiranView: UIView!
    
    @IBOutlet weak var tourokuView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //------------------登録-------------------------------------------
    
    
    
    //-------------------------------------------------------------
    
    
    //--------------------TableViewCellDetail-----------------------------------------
    @IBOutlet weak var tableViewCellDetail: UIView!
    @IBOutlet weak var pcNoLabel: UILabel!
    @IBOutlet weak var modalLabel: UILabel!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var osBtn: UIButton!
    @IBOutlet weak var officeBtn: UIButton!
    @IBOutlet weak var securityBtn: UIButton!
    @IBOutlet weak var damagedBtn: UIButton!
    @IBOutlet weak var cellDetailPickerView: UIPickerView!
    
    @IBOutlet weak var cellDetailPickerSuperUIView: UIView!
    
    
    var currentDetailIndex:Int32 = -1
    var pickerFlag:String = "None"
    
    var locationValueList = [String]()
    var osmValueList = [String]()
    
    
    
    
    
    //-------------------------------------------------------------
    
    //-------------------------------------------------------------
    
    
    
    //-------------------------------------------------------------
    
    
    
    
    
    
    
    
    

    @IBOutlet weak var pcInfoUITable: UITableView!
    
    var pcinfoToBuildTable:NSMutableArray = []
    var osmDic:NSMutableDictionary = [:]
    var osmArray = [MyOSM]()
    
    var locationDic:NSMutableDictionary = [:]
    var locationArray = [MyLocation]()
    let officeDamegedArray = ["有","無","-"];
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableViewData()
        
        
        

        //print(pcInfoUITable.frame)
        //pcInfoUITable.frame.origin.x = 20
        
        //let nib = UINib(nibName: "PCInfomationTableViewCell", bundle: nil)
        //pcInfoUITable.register(nib, forCellReuseIdentifier: "PCInfomationTableViewCell")
        
        pcInfoUITable.register(UINib(nibName: "PCInfomationTableViewCell", bundle: nil), forCellReuseIdentifier: "PCInfomationTableViewCell")
    
        
        
        
        

        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func torokuBtnPressed(_ sender: Any) {
        
       // let myDataController = MyDataController()
        
        print("登録ボタンが押された")
    }
    @IBAction func syncBtnPressed(_ sender: Any) {
        print("システム更新ボタンが押された")
        
    }

    @IBAction func downloadBtnPressed(_ sender: Any) {
        print("ダウンロードボタンが押された")
        let semaphore = DispatchSemaphore(value: 1)
        
        semaphore.wait(timeout: DispatchTime.distantFuture)
        
        let myDataController = MyDataController()
       
        myDataController.deleteAllRecordsOfEntity(entity: "PCINFOMATION")
        if !myDataController.syncPCInfomation(){
            print("OK a")
        }
        
        
        myDataController.deleteAllRecordsOfEntity(entity: "OSM")
        if !myDataController.syncOSM(){
            print("OSM OK")
        }
        
        myDataController.deleteAllRecordsOfEntity(entity: "LOCATION")
        if !myDataController.syncLocationm(){
            print("Location OK")
        }
        semaphore.signal()
        
        loadTableViewData()
        
        
    }
    
    
    func loadTableViewData() {
        print("Loadddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd")
        let myDataController = MyDataController()
        pcinfoToBuildTable = myDataController.getAllPCInfoList()
        osmArray = myDataController.getAllOSMList() as! [MyOSM]
        for osm:MyOSM in osmArray{
            osmDic[osm.id] = osm.osname
            osmValueList.append(osm.osname!)
            
        }
        //locationDic = myDataController.getAllLocationList()
        locationArray = myDataController.getAllLocationList() as! [MyLocation]
        
        for location:MyLocation in locationArray{
            locationDic[location.id] = location.locationname
            locationValueList.append(location.locationname!)
            
        }

        
        
        print("Load or Reload Data-------------locationkey------------")
        
        
        OperationQueue.main.addOperation({ () -> Void in self.pcInfoUITable.reloadData()})
    self.pcInfoUITable.reloadData()
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pcinfoToBuildTable.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textCellIdentifier = "PCInfomationTableViewCell"
        let cell:PCInfomationTableViewCell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier) as! PCInfomationTableViewCell
        //let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! PCInfomationTableViewCell
        
        let row = indexPath.row
        
        let tempInfo:MyPCInfomation = self.pcinfoToBuildTable.object(at: row) as! MyPCInfomation
        
        
        cell.pcNoLabel.text = tempInfo.pcno
        cell.osLabel.text = osmDic.object(forKey: tempInfo.osid) as? String
        cell.osid = tempInfo.osid
            
        cell.locationLabel.text = locationDic.object(forKey: tempInfo.locationid) as? String
        cell.locationid = tempInfo.locationid
        
        if tempInfo.officecheck==1 {
            cell.officeLabel.text = "無"
        }else if tempInfo.officecheck==0{
            cell.officeLabel.text = "有"
        }else{
            cell.officeLabel.text = "-"
        }
        
        
        cell.modelLabel.text = tempInfo.model
        
        if tempInfo.damagedcheck==1 {
            cell.damagedLabel.text = "無"
        }else if tempInfo.damagedcheck==0{
            cell.damagedLabel.text = "有"
        }else{
            cell.damagedLabel.text = "-"
        }
        
        
        if tempInfo.securitycheck==1 {
            cell.securityLabel.text = "無"
        }else if tempInfo.securitycheck==0{
            cell.securityLabel.text = "有"
        }else{
            cell.securityLabel.text = "-"
        }
        
        print("Cell clgt")
        print(self.pcinfoToBuildTable.count)
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        let row = indexPath.row
        fillDataOfCellToDetail(index: Int32(row))
        self.currentDetailIndex = Int32(row)
        self.ichiranView.isHidden = true
        self.tableViewCellDetail.isHidden = false
        self.tourokuView.isHidden = true
        
    }
    
    
    func fillDataOfCellToDetail(index:Int32) {
        let currentInfo:MyPCInfomation = self.pcinfoToBuildTable.object(at: Int(index))as! MyPCInfomation
        self.pcNoLabel.text = currentInfo.pcno
        self.modalLabel.text = currentInfo.model
        self.locationBtn.setTitle(locationDic.object(forKey: currentInfo.locationid) as? String, for: UIControlState.normal)
        self.osBtn.setTitle(osmDic.object(forKey: currentInfo.osid) as? String, for: UIControlState.normal)
        
        if currentInfo.officecheck==1 {
            self.officeBtn.setTitle("無", for: UIControlState.normal)
            
        }else if currentInfo.officecheck==0{
            self.officeBtn.setTitle("有", for: UIControlState.normal)
            
        }else{
            self.officeBtn.setTitle("-", for: UIControlState.normal)
            
        }
        
        
        if currentInfo.securitycheck==1 {
            self.securityBtn.setTitle("無", for: UIControlState.normal)
            
        }else if currentInfo.securitycheck==0{
            self.securityBtn.setTitle("有", for: UIControlState.normal)
            
        }else{
            self.securityBtn.setTitle("-", for: UIControlState.normal)
            
        }
        
        if currentInfo.damagedcheck==1 {
            self.damagedBtn.setTitle("無", for: UIControlState.normal)
            
        }else if currentInfo.damagedcheck==0{
            self.damagedBtn.setTitle("有", for: UIControlState.normal)
            
        }else{
            self.damagedBtn.setTitle("-", for: UIControlState.normal)
            
        }
        
       
        
        
        
        
        
 
    }
    
    
    
    //--------------------TableViewCellDetail-----------------------------------------
    
    @IBAction func backFromCellDetailPressed(_ sender: Any) {
        loadTableViewData()
        self.pcInfoUITable.reloadData()
        self.ichiranView.isHidden = false
        self.tableViewCellDetail.isHidden = true
        self.tourokuView.isHidden = true
        self.cellDetailPickerSuperUIView.isHidden = true
    }

    @IBAction func updateFromCellDetailPressed(_ sender: Any) {
        let updateString:String = getDetailParasToPostUpdate()
        
        
        let myUrl = URL(string: "http://localhost/PCManageSystem/API/updatedatabase.php");
        
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        
        let postString = updateString;
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    // Now we can access value of First Name by its key
                    let firstNameValue = parseJSON["result"] as? Int32
                    print("from respons")
                    print(firstNameValue!)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getDetailParasToPostUpdate() -> String {
        var result:String = ""
        
        let currentInfo:MyPCInfomation = self.pcinfoToBuildTable.object(at: Int(self.currentDetailIndex))as! MyPCInfomation
        result+="No="+String(currentInfo.id)
        
        
        
        let newLocationId:Int = locationValueList.index(of: self.locationBtn.title(for: UIControlState.normal)!)!
        
        result+="&Location="+String(locationArray[newLocationId].id)
        
        
        let newOSMId:Int = osmValueList.index(of: self.osBtn.title(for: UIControlState.normal)!)!
        result+="&OS="+String(osmArray[newOSMId].id)
        
        
        let officeValue = self.officeBtn.title(for: UIControlState.normal)!
        
        if(officeValue == "無"){
            result+="&OfficeCheck=1"
            
        }else if(officeValue == "有"){
            result+="&OfficeCheck=0"

        }else{
            result+="&OfficeCheck=2"

        }
        
        
        let securityValue = self.securityBtn.title(for: UIControlState.normal)!
        
        if(securityValue == "無"){
            result+="&SecurityCheck=1"

        }else if(securityValue == "有"){
            result+="&SecurityCheck=0"

        }else{
            result+="&SecurityCheck=2"

        }
        
        
        
        let damagedValue = self.damagedBtn.title(for: UIControlState.normal)!
        
        if(damagedValue == "無"){
            result+="&DamagedCheck=1"

        }else if(damagedValue == "有"){
            result+="&DamagedCheck=0"

        }else{
            result+="&DamagedCheck=2"

        }
        
        
        

        
        return result
        
    }
    
    @IBAction func deleteEntityFromCellDetailPressed(_ sender: Any) {
    }
    @IBAction func doneToHidePickerPressed(_ sender: Any) {
        self.cellDetailPickerSuperUIView.isHidden = true
        self.pickerFlag = "none"
        
    }
    
    @IBAction func commonDetailBtnPressedByTag(_ sender: Any) {
        let senderBtn:UIButton = sender as! UIButton
        let currentInfo:MyPCInfomation = self.pcinfoToBuildTable.object(at: Int(self.currentDetailIndex))as! MyPCInfomation
        
        
        self.cellDetailPickerSuperUIView.isHidden = false
        if(senderBtn.tag == 1){//location button
            self.pickerFlag = "location"
            
            let locationName = self.locationDic.object(forKey: currentInfo.locationid) as! String
            
            let pickerRowNum = self.locationValueList.index(where: {$0 == locationName})
            
            self.cellDetailPickerView.reloadAllComponents()
            self.cellDetailPickerView.selectRow(pickerRowNum!, inComponent: 0, animated: false)
            
        }else if(senderBtn.tag == 2){//osm button
            self.pickerFlag = "osm"
            let osmName = self.osmDic.object(forKey: currentInfo.osid) as! String
            
            let pickerRowNum = self.osmValueList.index(where: {$0 == osmName})
            
            self.cellDetailPickerView.reloadAllComponents()
            self.cellDetailPickerView.selectRow(pickerRowNum!, inComponent: 0, animated: false)
            

            
        }else if(senderBtn.tag == 3){//office button
            self.pickerFlag = "office"
            let pickerRowNum = self.officeDamegedArray.index(where: {$0 == self.officeBtn.titleLabel?.text})
            self.cellDetailPickerView.reloadAllComponents()
            self.cellDetailPickerView.selectRow(pickerRowNum!, inComponent: 0, animated: false)
            
        }else if(senderBtn.tag == 4){//security button
            self.pickerFlag = "security"
            let pickerRowNum = self.officeDamegedArray.index(where: {$0 == self.securityBtn.titleLabel?.text})
            self.cellDetailPickerView.reloadAllComponents()
            self.cellDetailPickerView.selectRow(pickerRowNum!, inComponent: 0, animated: false)
            
        }else if(senderBtn.tag == 5){//damaged button
            self.pickerFlag = "damaged"
            let pickerRowNum = self.officeDamegedArray.index(where: {$0 == self.damagedBtn.titleLabel?.text})
            self.cellDetailPickerView.reloadAllComponents()
            self.cellDetailPickerView.selectRow(pickerRowNum!, inComponent: 0, animated: false)
            
        }
        
        
    }
    
    
    //--------------------TableViewCellDetail-----------------------------------------
    

    
    
    //----------------------PickerUIView---------------------------------------------
    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var result = 0
        
        if self.pickerFlag=="location" {
            result = locationArray.count
        }else if(self.pickerFlag=="osm"){
            result = osmArray.count
        }else{
            result = self.officeDamegedArray.count
        }
        return result
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var result:String = ""
        if self.pickerFlag=="location" {
            result = locationArray[row].locationname!
        }else if(self.pickerFlag=="osm"){
            result = osmArray[row].osname!
        }else{
            result = self.officeDamegedArray[row]
        }
        return result
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        if self.pickerFlag=="location" {
            self.locationBtn.setTitle(locationArray[row].locationname, for: UIControlState.normal)
            
        }else if(self.pickerFlag=="osm"){
            self.osBtn.setTitle(osmArray[row].osname, for: UIControlState.normal)
            
        }else if self.pickerFlag=="office"{
            //result = self.officeDamegedArray[row]
            self.officeBtn.setTitle(self.officeDamegedArray[row], for: UIControlState.normal)
        }else if self.pickerFlag=="damaged"{
            self.damagedBtn.setTitle(self.officeDamegedArray[row], for: UIControlState.normal)
        }else if self.pickerFlag=="security"{
            self.securityBtn.setTitle(self.officeDamegedArray[row], for: UIControlState.normal)
        }
    }
    
    
    
}

