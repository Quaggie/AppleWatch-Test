//
//  InterfaceController.swift
//  ChecarSaldoWatch Extension
//
//  Created by Jonathan Bijos on 17/10/16.
//  Copyright © 2016 putfiredev. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var session: WCSession! = nil
    @IBOutlet var saldo: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        //
    }
    
    override func willActivate() {
        super.willActivate()
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func refresh() {
        session.sendMessage(["request": "user"], replyHandler: nil, errorHandler: nil)
    }
    
    func configureSaldo (_ user: [String: Any]) {
        let saldo = user["saldo"] as! String
        
        self.saldo.setText("R$ \(saldo)")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        configureSaldo(message)
    }

}









