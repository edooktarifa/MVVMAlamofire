//
//  UserViewModel.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 09/06/21.
//

import Foundation
import Alamofire
import UIKit

class UserViewModel {
    
    var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
    let showLoadingHub: Bindable = Bindable(false)
    
    let friendCells = Bindable([FriendCellViewModel]())
    let appServerClient: AppServerClient
    
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }
    
    func getUser(){
        showLoadingHub.value = true
//        appServerClient.getUser { [weak self] result in
//            self?.showLoadingHub.value = false
//
//            switch result{
//            case .success(let user):
//                self?.friendCells.value = user
//            case .failure(let error):
//                print(error?.localizedDescription ?? "No connection Internet")
//                let showError = SingleButtonAlert(title: "Error", message: "Could not connect to server. Check your network and try again later.", action: AlertAction(buttonTitle: "OK", handler: {
//                    print("on click")
//                    self?.getUser()
//                }))
//
//                self?.onShowError?(showError)
//                break
//            }
//        }
        APIServices.instance.request(url: "https://jsonplaceholder.typicode.com/users", method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { [weak self] (user: [User]?, errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
            self.showLoadingHub.value = false
            
            if let error = error {
                let showError = SingleButtonAlert(title: "Error", message: "Could not connect to server. Check your network and try again later.", action: AlertAction(buttonTitle: "OK", handler: {
                    print("on click")
                    self.getUser()
                }))
                self.onShowError?(showError)
                print(error.localizedDescription)
            } else if let errorModel = errorModel {
                print(errorModel.message ?? "")
            } else {
                guard let userModel = user else { return }
                self.friendCells.value = userModel
            }
        }
    }
}


protocol FriendCellViewModel {
    var friendItem: User { get }
    var fullName: String { get }
    var phoneNumberText: String { get }
}

extension User: FriendCellViewModel{
    var friendItem: User {
        return self
    }
    
    var fullName: String {
        return name + " " + username
    }
    
    var phoneNumberText: String {
        return email
    }
}
