//
//  ViewController.swift
//  Campanero
//
//  Created by Oscar Hiram Alvarez Campos on 15/07/16.
//  Copyright © 2016 Nebusens. All rights reserved.
//

import UIKit //libreria



//aqui van todas las variables y outlets
class ViewController: UIViewController {
    
    
    var arrayWithQuestions = NSMutableArray()
    var isOpen = Bool()

    @IBOutlet weak var rateServiceButtonImage: UIImageView!
    @IBOutlet weak var rateServiceButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    
    

    // MARK: Properties

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        tableView.layer.borderWidth = 2.0
        tableView.layer.borderColor = UIColor.blackColor().CGColor
        
        isOpen=false
        
    
        
        arrayWithQuestions = ["A tiempo","Pasó tarde", "No pasó", "Pasó antes", "Pasó sin recoger"]
        tableView.dataSource = self
        tableView.delegate = self
        
        
       //funciones y extensiones  //SOLO FUNCIONES
    }
    
    
    
    @IBAction func switchButtonAction(sender: AnyObject) {  //botón para habilitar o inhabilitar las opciones de recolección
        
        
        if !switchButton.on {   //"!" negacion de la acción == if swtich button.off,
            
            var onOff = true;
            onOff = false;
        
        
        }
    }
    
    override func viewWillAppear(animated: Bool) {   // ????? //INVESTIGA
        if let direction = NSUserDefaults.standardUserDefaults().objectForKey("selected")as? String{
            
        directionLabel.text = direction
        
        }
        
    }

    
  

    //boton para mostrar y esconder menu de valoracion de servicio
    
    @IBAction func openRateView(sender: AnyObject) {
        
        if(isOpen){ //si es verdadero  esconde la tabla y pone imagen de abrir >
            
            tableView.hidden = true
            isOpen = false
            rateServiceButtonImage.image = UIImage(named: "back")
            
            
        }
        else {  //si es falso muestra la tabla y pone imagen de cerrar \/
        
        tableView.hidden = false
            isOpen = true
            rateServiceButtonImage.image = UIImage(named: "down")
            
        }
        
    }
    
    
    
    
}



extension ViewController:UITableViewDataSource, UITableViewDelegate{ //Extension para configurar el tableView //PARECIDO AL DE MAPAS
    
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

