//
//  Display.swift
//  ViewStateStudy
//
//  Created by munir on 03/11/19.
//  Copyright © 2019 Wanis Co. All rights reserved.
//

import Foundation

typealias Action = (()->Void)

struct Display<T: Displayable, S: Displayable> {
    enum State {
        case success(T)
        case loading
        case empty(String?)
        case noConnection
        case error(Error, String?)
        case custom(S)
    }
    
    let state: State
    var action: Action?
    
    init() {
        state = .loading
    }
    
    init(_ state: State, action: Action? = nil) {
        self.state = state
        self.action = action
    }
}

protocol Displayable {}

struct None: Displayable {}
