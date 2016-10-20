//
//  ViewController.swift
//  SampleRealmOnWatchOS3
//
//  Created by Y.T. Hoshino on 2016/10/20.
//  Copyright © 2016年 Yuta Hoshino. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        if let myField = realm.objects(Field.self).first{
            textField.text = myField.text
        } else {
            try! realm.write {
                realm.add(Field())
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        print("changed")
        let realm = try! Realm()
        if let myField = realm.objects(Field.self).first{
            try! realm.write {
                myField.text = textField.text
            }

        }
    }
}

