//
//  File.swift
//  
//
//  Created by nasrin niazi on 2023-02-20.
//

import Foundation

public class NetworkRequest : NetworkRequestProtocol {
    
    ///this property would be setted either user set cache or directly set this option, if this property active
    public var cacheTheResult: Bool
    public var bodyParseMode: NetworkRequestParseMethod
    public var method: NetworkHttpMethod
    public var networkConfig: NetworkConfig?
    
    /// setting the config, here we ignore already existing header keys and just append new keys in our request headers, it means that if we add some extera headers, when we set new config, config headers appended to our headers and existing keys will be ignored and keep their old value
    ///
    /// - Parameter config: configs
    public func setConfig(config: NetworkConfig)-> Self {
        self.networkConfig = config
        
        ///if we have headers
        if let headers = self.headers  {
            /// get existing keys
            let existingKeys = Set(headers.keys)
            
            ///get new keys and find keep only new ones
            var configKeys = Set(config.defaulHeaders.keys)
            configKeys.subtract(existingKeys)
            
            ///append new keys to the headers
            for key in configKeys {
                self.add(extraHeaders: [key:(config.defaulHeaders[key] ?? "") ])
            }
        }
        return self
    }
    
    public  var path: String
    public var baseUrl : String {
        get {
            return networkConfig?.baseUrl ?? ""
        }
    }
    
    public  var fullPath: String {
        return (networkConfig?.baseUrl ?? "") + path
    }
    
    public lazy var headers: [String:String]? = {
        return [String:String]()
    }()
    
    public var stringQuery: [String:Any]?
    
    public var body: [String:Any]?
    public var jsonBody:Data?
    
    public init() {
        path = ""
        method = .GET
        bodyParseMode = .json
        cacheTheResult = false
    }
    @discardableResult public  func add(parameter param: [String:Any]) -> Self {
        self.stringQuery = param
        return self
    }
    
    @discardableResult public  func add(extraHeaders param: [String:String]) -> Self {
        param.forEach { (key,value) in
            self.headers?.updateValue(value, forKey: key)
        }
        return self
    }
    
    @discardableResult public func add(path: String) -> Self {
        self.path = path
        return self
    }
    
    @discardableResult public func add(body: [String:Any]) -> Self {
        self.body = body
        return self
    }
    
    @discardableResult public func cacheResult() -> Self {
        self.cacheTheResult = true
        return self
    }
}
