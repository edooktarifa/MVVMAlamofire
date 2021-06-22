//
//  PhotoVM.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 09/06/21.
//

import Foundation
import Alamofire

class PhotoVM {

    private var photo: User? {
        didSet {
            guard let p = photo else { return }
            setupText(with: p)
            self.didFinishFetch?()
        }
    }
    let showLoadingHud: Bindable = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    var didFinishFetch: (() -> ())?
    
    
    let appServerClient: AppServerClient
    var titleString: String?
    var emailString: String?
    
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }
    
    func getPhoto(){
        showLoadingHud.value = true
        
        APIServices.instance.request(url: "https://jsonplaceholder.typicode.com/users/1", method: .get, params: nil, encoding: URLEncoding.default, headers: nil) { [weak self] (photo: User?, errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
    
            self.showLoadingHud.value = false
            
            if let error = error {
                let showError = SingleButtonAlert(title: "Error", message: "Could not connect to server. Check your network and try again later.", action: AlertAction(buttonTitle: "OK", handler: {
                    
                }))
                self.onShowError?(showError)
                print(error.localizedDescription)
                
            } else if let errorModel = errorModel {
                print(errorModel.message)
            } else {
                guard let photoModel = photo else { return }
                self.photo = photoModel
            }
            
        }
    }
    
    private func setupText(with photo: User){
        self.titleString = photo.name
        self.emailString = "Your email is : \(photo.email)"
    }
}
