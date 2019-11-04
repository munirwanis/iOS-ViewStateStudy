//
//  ErrorViewController.swift
//  ViewStateStudy
//
//  Created by munir on 03/11/19.
//  Copyright © 2019 Wanis Co. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    private let action: (()->())?
    private let message: String
    private let icon: UIImage?
    
    init(message: String? = nil, iconName: String? = nil, action: (()->())? = {}) {
        self.action = action
        self.message = message ?? "Ops!\nAlgo de errado aconteceu..."
        self.icon = UIImage(named: iconName ?? "error")
        super.init(nibName: String(describing: ErrorViewController.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageLabel.text = message
        imageView.image = icon
        tryAgainButton.isHidden = action == nil
    }

    @IBAction func tryAgainAction(_ sender: Any) {
        action?()
    }
}
