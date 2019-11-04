//
//  ViewController.swift
//  ViewStateStudy
//
//  Created by munir on 03/11/19.
//  Copyright © 2019 Wanis Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var successLabel: UILabel!
    
    private lazy var currentState: DisplayViewController<ViewControllerDisplay, None> = {
        return .init(display: self.display)
    }()
    
    struct ViewControllerDisplay: Displayable {
        let message: String
        
        init() {
            message = "Escolha um estado:\nDeu certo!"
        }
    }
    
    var display: Display<ViewControllerDisplay, None> = .init(.success(ViewControllerDisplay())) {
        didSet {
            currentState.removeChild()
            switch display.state {
            case .success(let model):
                successLabel.text = model.message
            case .loading:
                currentState.change(display)
                add(child: currentState)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.display = .init(.success(ViewControllerDisplay()))
                }
            default:
                display.action = {
                    self.display = .init(.success(ViewControllerDisplay()))
                }
                currentState.change(display)
                add(child: currentState)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.display = .init(.success(ViewControllerDisplay()))
    }
    
    
    @IBAction func didPressButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            triggerAlert()
        case 2:
            display = .init(.loading)
        case 3:
            display = .init(.noConnection)
        case 4:
            display = .init(.error(AppError.general, nil))
        case 5:
            display = .init(.empty(nil))
        default:
            display = .init(.error(AppError.general, nil))
        }
    }
    
    func triggerAlert() {
        let alert = UIAlertController(title: "Sucesso!",
                                      message: "Digite algo:",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Digite a mensagem de sucesso."
        }
        
        func actionHandler(_ action: UIAlertAction) {
            let text = alert.textFields?.first?.text
            self.successLabel.text = text
        }
        
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: actionHandler)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

enum AppError: Error {
    case general
}
