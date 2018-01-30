//
//  ViewController.swift
//  SampleRealmOnWatchOS3
//
//  Created by Y.T. Hoshino on 2016/10/20.
//  Copyright © 2016年 Yuta Hoshino. All rights reserved.
//

import UIKit
import RealmSwift
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var realmTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initial setting
        activateSession()

        //initial transfer
        transferRealmFile()
        
        //read realmTextField.txt
        readRealmTextFieldText()
    }

    func activateSession(){
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func transferRealmFile(){
        if let path = Realm.Configuration().fileURL {
            WCSession.default.transferFile(path, metadata: nil)
        }
    }

    func readRealmTextFieldText(){
        let realm = try! Realm()
        if let firstField = realm.objects(Field.self).first{
            realmTextField.text = firstField.text
        } else {
            try! realm.write {
                realm.add(Field())
            }
        }
    }
    
    @IBAction func realmTextFieldEditingChanged(_ sender: UITextField) {
        saveRealmTextFieldText()
        transferRealmFile()
    }
    
    func saveRealmTextFieldText(){
        let realm = try! Realm()
        if let myField = realm.objects(Field.self).first{
            try! realm.write {
                myField.text = realmTextField.text
            }
            
        }
    }
    
    @IBAction func sendMessageEditingChanged(_ sender: UITextField) {
        sendMessage()
    }
    
    func sendMessage(){
        if WCSession.default.isReachable {
            let applicationDict = ["text": messageTextField.text ?? ""]
            WCSession.default.sendMessage(applicationDict,
                                            replyHandler: { replyDict in print(replyDict) },
                                            errorHandler: { error in print(error.localizedDescription)})
        }

    }
    
    //WCSessionDelegate
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    
}

