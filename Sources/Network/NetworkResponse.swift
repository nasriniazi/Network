//
//  File.swift
//  
//
//  Created by nasrin niazi on 2023-02-20.
//

import Foundation

class NetworkResponse : NetworkResponseProtocol {
    var cached : Bool
    var request: NetworkRequestProtocol
    var response: Data?
    var error: Error?
    init(request : NetworkRequestProtocol) {
        self.request = request
        self.cached = false
    }
}
