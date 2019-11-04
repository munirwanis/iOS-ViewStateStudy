//
//  ConnectionViewController.swift
//  ViewStateStudy
//
//  Created by munir on 03/11/19.
//  Copyright © 2019 Wanis Co. All rights reserved.
//

import UIKit

class ConnectionViewController: ErrorViewController {

    init(action: (() -> ())? = {}) {
        let message = "Ops!\nParece que você não está conectado à internet."
        super.init(message: message, iconName: "connection", action: action)
    }
}
