//
//  DisplayViewController.swift
//  ViewStateStudy
//
//  Created by munir on 03/11/19.
//  Copyright © 2019 Wanis Co. All rights reserved.
//

import UIKit

class DisplayViewController<T: Displayable, S: Displayable>: UIViewController {
    private var display: Display<T, S>
    private var currentState: UIViewController?
    
    init(display: Display<T, S>) {
        self.display = display
        super.init(nibName: nil, bundle: nil)
    }
    
    func change(_ display: Display<T, S>) {
        self.display = display
        currentState?.removeChild()
        currentState = nil
        defineState(from: display)
    }
    
    func defineState(from display: Display<T, S>) {
        let currentState: UIViewController
        switch display.state {
        case .loading:
            currentState = LoadingViewController()
        case .noConnection:
            currentState = ConnectionViewController(action: display.action)
        case .error(let error, let message):
            print(error)
            currentState = ErrorViewController(message: message,
                                               action: display.action)
        case .empty(let message):
            let msg = message ?? "Parece que não há nada aqui!"
            currentState = ErrorViewController(message: msg,
                                               action: display.action)
        default:
            currentState = ErrorViewController(action: display.action)
        }
        
        add(child: currentState)
        self.currentState = currentState
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        defineState(from: self.display)
    }
}

extension UIViewController {
    
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.frame
        child.didMove(toParent: self)
    }
    
    func add(child: UIViewController, with frame: CGRect) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = frame
        child.didMove(toParent: self)
    }
    
    func addChildToSetConstraints(_ child: UIViewController) -> UIView {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        return child.view
    }
    
    func removeChild() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
