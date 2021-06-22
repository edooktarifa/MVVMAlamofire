//
//  Alert.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 09/06/21.
//

import Foundation

struct AlertAction {
    let buttonTitle: String
    let handler: (() -> Void)?
}

struct SingleButtonAlert {
    let title: String
    let message: String?
    let action: AlertAction
}
