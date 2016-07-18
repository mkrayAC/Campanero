//
//  ViewController.swift
//  Campanero
//
//  Created by Oscar Hiram Alvarez Campos on 15/07/16.
//  Copyright © 2016 Nebusens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var directionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
    
    @IBAction func selectButton(sender: UIButton) {
        
        directionTextField.text = "Default Text"
    }
}

