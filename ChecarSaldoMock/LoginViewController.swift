//
//  LoginViewController.swift
//  ChecarSaldoMock
//
//  Created by Jonathan Bijos on 17/10/16.
//  Copyright © 2016 putfiredev. All rights reserved.
//

import UIKit
import WatchConnectivity

class LoginViewController: UIViewController, ReuseIdentifier {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var saldo: UITextField!
    
    var session: WCSession! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnectivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        login()
    }

}

extension LoginViewController {
    func checkConnectivity () {
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    func saveToDefaults () {
        guard let email = email.text else { return }
        guard let saldo = saldo.text else { return }
        let formattedSaldo = Double(saldo)
        
        let user = ["email": email, "saldo": "\(formattedSaldo!)"]
        
        let defaults = UserDefaults.standard
        
        defaults.set(user, forKey: "user")
        defaults.synchronize()
    }
    
    func login () {
        saveToDefaults()
        let mainVC = MainViewcontroller.instantiateFromStoryboard
        navigationController?.pushViewController(mainVC, animated: true)
    }
}

extension LoginViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if error != nil { print("Deu erro") }
        
        print("Activatoin did complete with state -> \(activationState)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
    }
}

















