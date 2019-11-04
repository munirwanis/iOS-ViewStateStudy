//
//  LoadingViewController.swift
//  ViewStateStudy
//
//  Created by munir on 03/11/19.
//  Copyright © 2019 Wanis Co. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    init() {
        super.init(nibName: String(describing: LoadingViewController.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        spinner.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        spinner.stopAnimating()
    }
}
