//
//  DetailViewController.swift
//  babySchedule
//
//  Created by carlstand on 12/23/15.
//  Copyright © 2015 carlstand. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var pooButton: UIButton!
    @IBOutlet weak var sleepButton: UIButton!
    
    @IBOutlet weak var date: UIDatePicker!
    
    var item: ListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if item == nil{
            eatButton.selected = true
            navigationController!.title = "add item"
        }
        else
        {
            if item?.type == action[0]{
                eatButton.selected = true
            }
            else if item?.type == action[1]{
                pooButton.selected = true
            }
            else if item?.type == action[2]{
                sleepButton.selected = true
            }
            
            date.setDate((item?.date)!, animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons(){
        eatButton.selected = false
        pooButton.selected = false
        sleepButton.selected = false
    }
    
    @IBAction func eatCliked(sender: AnyObject) {
        resetButtons()
        eatButton.selected = true
    }
    @IBAction func pooClicked(sender: AnyObject) {
        resetButtons()
        pooButton.selected = true
    }
    @IBAction func sleepClicked(sender: AnyObject) {
        resetButtons()
        sleepButton.selected = true
    }
    @IBAction func okClicked(sender: AnyObject) {
        
        var typeOfAction = ""
        
        if eatButton.selected{
            typeOfAction = action[0]
        }
        else if pooButton.selected{
            typeOfAction = action[1]
        }
        else if sleepButton.selected{
            typeOfAction = action[2]
        }
        
        if item == nil{
            let item = ListItem(amount: 100, type: typeOfAction, date: date.date)
            list.append(item)
        }
        else{
            item?.date = date.date
            item?.type = typeOfAction
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
