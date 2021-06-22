//
//  BaseErrorModel.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 22/06/21.
//

import Foundation

struct BaseErrorModel: Codable {
    let message: String?
    let status_code: Int?
}
