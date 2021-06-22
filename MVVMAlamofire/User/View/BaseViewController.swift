//
//  BaseViewController.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 09/06/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(alert: SingleButtonAlert){
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alert.action.buttonTitle, style: .default, handler: { _ in
            alert.action.handler?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }

}
