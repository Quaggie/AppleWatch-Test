//
//  UIViewController+Ext.swift
//  ChecarSaldoMock
//
//  Created by Jonathan Bijos on 17/10/16.
//  Copyright © 2016 putfiredev. All rights reserved.
//

import UIKit

protocol ReuseIdentifier: class {}

extension ReuseIdentifier where Self: UIViewController {
    static var instantiateFromStoryboard: UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: self))
    }
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
