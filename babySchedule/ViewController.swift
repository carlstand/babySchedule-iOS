//
//  ViewController.swift
//  babySchedule
//
//  Created by carlstand on 12/14/15.
//  Copyright © 2015 carlstand. All rights reserved.
//

import UIKit

var list: [ListItem] = []
var filteredList: [ListItem] = []
let selected: String = " selected"
let action: [String] = ["eat", "poo", "sleep"]
let unit: [String] = [" ML"," Time(s)"," Hour(s)"]
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        list = [ListItem(amount: 100, type: action[0], date: NSDate()),
            ListItem(amount: 1, type: action[1], date: NSDate()),
            ListItem(amount: 3, type: action[2], date: NSDate()),
            ListItem(amount: 400, type: action[0], date: NSDate())]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            var item : ListItem
            
            item = list[indexPath.row] as ListItem
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("listCell") as UITableViewCell!
            
            let image = cell.viewWithTag(1) as! UIImageView
            let title = cell.viewWithTag(2) as! UILabel
            let date = cell.viewWithTag(3) as! UILabel
            
            let dateFormatter = NSDateFormatter()
            let dateFormat = NSDateFormatter.dateFormatFromTemplate("HH:mm:ss YYYY-MM-dd", options: 0, locale: NSLocale.currentLocale())
            dateFormatter.dateFormat = dateFormat
            let dateOfDate = dateFormatter.stringFromDate(item.date)
            if let index = action.indexOf(item.type){
                date.text = String(item.amount) + unit[index]
            }
            image.image = UIImage(named: (item.type + selected))
            title.text = dateOfDate
            return cell
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int{
            return list.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            list.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    @IBAction func close(segue: UIStoryboardSegue){
        print("closed")
        saveDatatoFile()
        tableView.reloadData()
    }
    
    func getFilePath(type: String) -> NSURL?{
        let fileManager = NSFileManager.defaultManager()
        do{
            let folderPath = try fileManager.URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL: nil, create: true).URLByAppendingPathComponent(type)
            if !fileManager.fileExistsAtPath(folderPath.path!){
                do{
                    try fileManager.createDirectoryAtURL(folderPath, withIntermediateDirectories: true, attributes: nil)
                    return folderPath
                }
                catch let err as NSError{
                    print(err.localizedDescription)
                }
            }
        }
        catch let err as NSError{
            print(err.localizedDescription)
        }

        return nil
        
    }
    
    func saveDatatoFile(){
        if let testPath = getFilePath(action[0])
        {
            let filePath = testPath.URLByAppendingPathComponent("test.txt")
            print(filePath.path)
            let info  = "this is test text"
            do{
                try info.writeToURL(filePath, atomically: true, encoding: NSUTF8StringEncoding)
            }
            catch let err as NSError{
                print(err.localizedDescription)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditItem"{
            let vc = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let index = indexPath{
                vc.item = list[index.row]
            }
        }
        else if segue.identifier == "AddItem"{
            
        }
    }
}

