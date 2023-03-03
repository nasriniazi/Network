//
//  File.swift
//  
//
//  Created by nasrin niazi on 2023-02-20.
//

import Foundation

public protocol NetworkRequestProtocol {
    
    /// this is our config object, we use it to config our network requests
    var networkConfig : NetworkConfig?{get}
    
    /// this is our path
    /// like /users/{id}/info
    var path : String {set get}
    
    /// cache the result
    var cacheTheResult : Bool {get}
    
    /// this is a computed property that returns the full path
    var fullPath: String{get}
    
    /// our request header, this is filled by config file and we can add extra fields
    /// like ["ios" : "12.0.1"]
    var headers : [String:String]?{set get}
    
    /// this is what we added to query string,
    /// like ?dateFrom=23/12/1397
    var stringQuery : [String:Any]?{set get}
    
    /// add body, based on the post or update method policy, it will be parsed to the represeted model (JSON,FormFields,Raw...)
    var body : [String:Any]?{set get}
    var jsonBody : Data?{set get}
    ///request type, set this from init
    var method : NetworkHttpMethod{set get}
    
    /// body should parse to JSON or FormFeilds ....
    var bodyParseMode : NetworkRequestParseMethod{set get}
    
    /// you can set directly or use this helper to have a chainable object like request.add(parameter : ["date":"value"]).add(extraHeader: ["token":""])
    ///
    /// - Parameter param: parameters to add to
    /// - Returns: self (this object)
    @discardableResult func add(parameter param : [String:Any]) -> Self
    
    /// add custom headers, somethime we have to add extra header to the default headers, this fields will be added to the default header, default header is retrieved from config
    ///
    /// - Parameter param: parameters to add to
    /// - Returns: self (this object)
    @discardableResult func add(extraHeaders param : [String:String]) -> Self
    
    
    /// change the default path, maybe we need to call some services directly, but default baseUrl would retrieved from config file
    ///
    /// - Parameter path: string path start with / like "/posts"
    /// - Returns: self (this object)
    @discardableResult func add(path : String) -> Self
    
    /// this is what we use to post as JSON or form fields
    ///
    /// - Parameter body: codable
    /// - Returns:  self (this object)
    @discardableResult func add(body : [String:Any]) -> Self
    
    /// set manually network config
    ///
    /// - Parameter config:pass config model
    @discardableResult func setConfig(config : NetworkConfig)-> Self
}
