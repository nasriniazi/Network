//
//  File.swift
//  
//
//  Created by nasrin niazi on 2023-02-20.
//

import Foundation

/// Every response has to implements this protocol, this is what the Network give back to the callers
public protocol NetworkResponseProtocol {
    /// cached
    var cached : Bool {get}
    
    /// the request that cause this response
    var request : NetworkRequestProtocol {get}
    
    ///raw response, can be anything
    var response : Data? {get}
    
    /// if request has any error
    var error : Error?{set get}

}
