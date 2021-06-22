//
//  PhotoViewController.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 10/06/21.
//

import UIKit
import PKHUD

class PhotoViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    let viewModel: PhotoVM = PhotoVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bindViewModel()
    }
    
    func bindViewModel(){
        viewModel.onShowError = {
            [weak self] alert in
            self?.showAlert(alert: alert)
        }
        
        viewModel.showLoadingHud.bind(){
            [weak self] visible in
            
            if let self = self {
                PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
            }
        }
        
        viewModel.didFinishFetch = {
            self.titleLabel.text = self.viewModel.emailString
        }
        
        viewModel.getPhoto()
    }
}
