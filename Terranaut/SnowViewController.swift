//
//  SnowViewController.swift
//  Terranaut
//
//  Created by Casey McCourt on 12/28/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit

class SnowViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

//    @IBAction func snowToMenuSegue(sender: UIButton) {
//        performSegueWithIdentifier("snowToMenu", sender: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
