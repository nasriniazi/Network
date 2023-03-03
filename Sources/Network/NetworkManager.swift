
public  struct NetworkManager {
    ///handles the networking
    public var networking : NetworkProtocol
    //TODO: we can handle cache here and inject cache control by init
    
    public var loading : Bool = true
    public init(network : NetworkProtocol) {
        self.networking = network
    }
}
///APIs
public extension NetworkManager {
    // TODO:  check cache before network, this is usefull when we want something cached and also sometimes use this cache for sake of preformance, for caching, the request cache or cacheTheResult properties should be setted.
    public func checkCacheThenGetNetwork(request : NetworkRequestProtocol,callBack : ((NetworkResponseProtocol)->Void )?){
        //TODO: first check cach and if needed then get network
        
        self.networking.get(request: request){response in
            if response.error == nil, let responseData = response.response{
                
                //TODO: clean previous value and relative caches and then cach new data
            }
            
            callBack?(response)
        }
        
    }
    
}


