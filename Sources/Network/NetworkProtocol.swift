//
//  File.swift
//  
//
//  Created by nasrin niazi on 2023-02-20.
//

import Foundation

public enum NetworkHttpMethod : String {
    case GET     = "GET"
    case POST    = "POST"
    ///...
}

public enum NetworkRequestParseMethod {
    case json,formFields,base64
}

public struct NetworkConfig {
    
    public var retry : Int
    
    /// our base url, this can retrieve from config file or filled manually,
    public var baseUrl : String
    
    /// default headers attached to all requests
    public var defaulHeaders : [String:String]
    public var manager:Any? = nil
    
    /// init our config file with default data
    public init() {
        retry = 0
        baseUrl = ""
        defaulHeaders = ["Content-Type":"application/json"]
        
    }
    
    /// if any request wants to change default network config, it can get defaults from here and made its changes and pass this config to the request
    public  static var defaultConfig : NetworkConfig {
        get {
            return NetworkConfig()
        }
    }
    
}

public protocol NetworkProtocol {
    
    var loading : Bool { get set }
    
    /// do a get request
    ///
    /// - Parameters:
    ///   - request: network request object
    ///   - callBack: this function would call after request completed(either success or error)
    func get(request : NetworkRequestProtocol,callBack : ((_:NetworkResponseProtocol)->Void)?)
    
    
}
