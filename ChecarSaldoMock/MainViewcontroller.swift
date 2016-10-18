//
//  MainViewcontroller.swift
//  ChecarSaldoMock
//
//  Created by Jonathan Bijos on 17/10/16.
//  Copyright © 2016 putfiredev. All rights reserved.
//

import UIKit
import WatchConnectivity

class MainViewcontroller: UIViewController, ReuseIdentifier {
    
    var session: WCSession! = nil
    
    let user: [String: Any] = {
        return UserDefaults.standard.value(forKey: "user") as! [String: Any]
    }()
    
    @IBOutlet weak var userLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnectivity()
        let email = user["email"] as! String
        let saldo = user["saldo"] as! String
        
        userLabel.text = "\(email) - \(saldo)"
        verifyLoggedIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkConnectivity () {
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    func verifyLoggedIn () {
        session.sendMessage(user, replyHandler: nil, errorHandler: nil)
    }

}

extension MainViewcontroller: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let request = message["request"] as! String
        
        switch request {
        case "user":
            verifyLoggedIn()
            break
        default: break
        }
        
        print(message)
    }
}
