//
//  Result.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 09/06/21.
//

import Foundation

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}


enum Results<T, U> {
    case success(payload: T)
    case failure(U?)
}
