//
//  ViewController.swift
//  Campanero
//
//  Created by Oscar Hiram Alvarez Campos on 15/07/16.
//  Copyright © 2016 Nebusens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var arrayWithQuestions = NSMutableArray()
    var isOpen = Bool()

    @IBOutlet weak var rateServiceButtonImage: UIImageView!
    @IBOutlet weak var rateServiceButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var directionLabel: UILabel!
    
    @IBOutlet weak var firstCheckMarckImage: UIImageView!
    @IBOutlet weak var secondCheckMarckImage: UIImageView!
    
    

    // MARK: Properties

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        isOpen=false
        
    
        
        arrayWithQuestions = ["A tiempo","Con retardo(5-10min)","Tarde(20 min)", "No paso", "Paso antes", "Paso sin recoger"]
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let direction = NSUserDefaults.standardUserDefaults().objectForKey("selected")as? String{
            
        directionLabel.text = direction
        
        }
        
    }

    
    @IBAction func halfHourOption(sender: AnyObject) {
        
        firstCheckMarckImage.hidden = false
        secondCheckMarckImage.hidden = true
        
        
    }
    
    @IBAction func fullTimeOption(sender: AnyObject) {
        
        firstCheckMarckImage.hidden = true
        secondCheckMarckImage.hidden = false
        
    }

    //boton para mostrar y esconder menu de valoracion de servicio
    
    @IBAction func openRateView(sender: AnyObject) {
        
        if(isOpen){
            
            tableView.hidden = true
            isOpen = false
            rateServiceButtonImage.image = UIImage(named: "back")
            
            
        }
        else {
        
        tableView.hidden = false
            isOpen = true
            rateServiceButtonImage.image = UIImage(named: "down")
            
        }
        
    }
    
    
    
}



extension ViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWithQuestions.count
    }
    
    //configurar la celda
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCellWithIdentifier("myCell",forIndexPath: indexPath)
        customCell.textLabel?.font = UIFont(name: "KeepCalm-Medium", size: 14)
        customCell.textLabel?.text = arrayWithQuestions.objectAtIndex(indexPath.row) as? String
        customCell.selectionStyle = .None
        return customCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // marcar opcion
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        
        
    //    indexPathSelected = indexPath
        
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .None
        
    }
    
    
}

