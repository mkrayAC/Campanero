//
//  SelectOptionController.swift
//  Campanero
//
//  Created by Oscar Hiram Alvarez Campos on 18/07/16.
//  Copyright © 2016 Nebusens. All rights reserved.
//

import UIKit


class SelectOptionController: UIViewController, SaveDirectionDelegate  {
    
    
    
    
    
    var arrayWithDirections = NSMutableArray()
   
    @IBOutlet weak var tablewViewDirection: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let array = NSUserDefaults.standardUserDefaults().objectForKey("directions") as? NSArray{
        
            arrayWithDirections = array.mutableCopy() as! NSMutableArray
            
        }
        
        tablewViewDirection.dataSource = self
        tablewViewDirection.delegate = self
  
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addTapped))
//tocar boton y mandar a mapa con segue
        
    }
    
    
    
    func addTapped()  {
        
        self.performSegueWithIdentifier("addDirection", sender: nil)
        
        
    }
    
    func sendDirection(direction: String) {
        arrayWithDirections.addObject(direction)
        
        let arrayInmutable = NSArray(array: arrayWithDirections)
        NSUserDefaults.standardUserDefaults().setObject(arrayInmutable, forKey: "directions")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        tablewViewDirection.reloadData()
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! MapViewController
        controller.delegate = self
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension SelectOptionController:UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWithDirections.count
    }
    
    //configurar la celda
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCellWithIdentifier("myCell",forIndexPath: indexPath)
        customCell.textLabel?.font = UIFont(name: "KeepCalm-Medium", size: 14)
        customCell.textLabel?.text = arrayWithDirections.objectAtIndex(indexPath.row) as? String
        customCell.selectionStyle = .None
        
        
        return customCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // marcar opcion
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        
        NSUserDefaults.standardUserDefaults().setObject(arrayWithDirections.objectAtIndex(indexPath.row), forKey: "selected")
        
        //    indexPathSelected = indexPath
        
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .None
        
    }
    
    
}

