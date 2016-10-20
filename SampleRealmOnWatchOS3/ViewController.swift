//
//  ViewController.swift
//  SampleRealmOnWatchOS3
//
//  Created by Y.T. Hoshino on 2016/10/20.
//  Copyright © 2016年 Yuta Hoshino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        print("changed")
    }
}

