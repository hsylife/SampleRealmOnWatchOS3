//
//  InterfaceController.swift
//  SampleWatchApp Extension
//
//  Created by Y.T. Hoshino on 2016/10/21.
//  Copyright © 2016年 Yuta Hoshino. All rights reserved.
//

import WatchKit
import Foundation
import RealmSwift
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var realmLabel: WKInterfaceLabel!
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        realmLabel.setText("awake")
        messageLabel.setText("awake")
        
        activateSession()
    }
    
    func activateSession(){
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }

    // When the file was received
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
        //set the recieved file to default Realm file
        var config = Realm.Configuration()
        config.fileURL = file.fileURL
        Realm.Configuration.defaultConfiguration = config
        
        // display the first of realm objects
        let realm = try! Realm()
        if let firstField = realm.objects(Field.self).first{
            realmLabel.setText(firstField.text)
        }
    }
    
    // When the message was received
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        if let text = message["text"] as! String?{
            messageLabel.setText(text)
        }
        
        replyHandler(["reply" : "OK"])
    }
    

}