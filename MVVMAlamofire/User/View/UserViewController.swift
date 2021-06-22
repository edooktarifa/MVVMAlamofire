//
//  UserViewController.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 09/06/21.
//

import UIKit
import PKHUD

class UserViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.getUser()
    }
    
    func bindViewModel(){
        viewModel.friendCells.bindAndFire{
            [weak self] response in
            self?.tableView.reloadData()
        }
        
        viewModel.onShowError = {
            [weak self] alert in
            self?.showAlert(alert: alert)
        }
        
        viewModel.showLoadingHub.bind(){
            [weak self] visible in
            
            if let self = self {
                PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
            }
        }
    }
}

extension UserViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friendCells.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.friendCells.value[indexPath.row].fullName
        return cell
    }
}
