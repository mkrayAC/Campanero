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
        
        if let array = NSUserDefaults.standardUserDefaults().objectForKey("directions") as? NSArray{ // Valida si es array lo que está guardado
        
            arrayWithDirections = array.mutableCopy() as! NSMutableArray
            
        }
        
        tablewViewDirection.dataSource = self
        tablewViewDirection.delegate = self
  
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(addTapped))
        
        
    }
    
//tocar boton y mandar a mapa con segue
    
    
    func addTapped()  {
        
        self.performSegueWithIdentifier("addDirection", sender: nil)
        
        
    }
    
    func sendDirection(direction: String) {  //funcion para convertir un arreglo mutable en inmutable //NO ES CIERTO
        arrayWithDirections.addObject(direction)
        
        let arrayInmutable = NSArray(array: arrayWithDirections) //conversion del arreglo :CORRECTO
        NSUserDefaults.standardUserDefaults().setObject(arrayInmutable, forKey: "directions")//el arreglo se guarda en memoria
        NSUserDefaults.standardUserDefaults().synchronize() // ?? //INVESTIGA PARA QUE SIRVE EL SYNCHRONIZE
        
        
        tablewViewDirection.reloadData()
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {  // esta funcion sirve para guardar la ubicacion escogida del mapa
        
        let controller = segue.destinationViewController as! MapViewController
        controller.delegate = self
    }
 
}

extension SelectOptionController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {// esta funcion sirve para ver cuantas filas tenemos en el arrayWithDirections y regresa un entero
        
        return arrayWithDirections.count
    }
    
    //configurar la celda ???
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCellWithIdentifier("myCell",forIndexPath: indexPath)
        customCell.textLabel?.font = UIFont(name: "KeepCalm-Medium", size: 14)
        customCell.textLabel?.text = arrayWithDirections.objectAtIndex(indexPath.row) as? String
        customCell.selectionStyle = .None
        
        if let direction = NSUserDefaults.standardUserDefaults().objectForKey("selected")as? String{
            
            if direction == arrayWithDirections.objectAtIndex(indexPath.row) as? String{
            
                 customCell.accessoryType = .Checkmark
            }
        }
        return customCell
    }
    
    //funcion para borrar una fila de una direccion guardada, se elimina la fila y se borra la informacion de memoria
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
         
            
            arrayWithDirections.removeObjectAtIndex(indexPath.row )
            let arrayInmutable = NSArray(array: arrayWithDirections)
            NSUserDefaults.standardUserDefaults().setObject(arrayInmutable, forKey: "directions")
            NSUserDefaults.standardUserDefaults().synchronize()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
 
        let arrayWithCell = tableView.visibleCells
        
        for cell in arrayWithCell{ //borra checkmarck de celdas no seleccionadas
            cell.accessoryType = .None
            
        }
 
        
        // marcar opcion
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        
        //Toma le valor de arrayWithDirectons y lo utiliza en el view controller para poder ver la direccion seleccionada //NO ES CIERTO
        NSUserDefaults.standardUserDefaults().setObject(arrayWithDirections.objectAtIndex(indexPath.row), forKey: "selected")
 
        
 }
 
}

 
