//
//  File.swift
//  
//
//  Created by nasrin niazi on 2023-02-20.
//

import Foundation
import Alamofire
import LogManager

public class NetworkService : NetworkProtocol {
    public var loading: Bool = true
    public var configs: NetworkConfig
    public  init(config : NetworkConfig,manager:Session? = nil) {
        self.configs = config
        self.configs.manager = (manager != nil) ? manager : sessionManager
    }
    public var sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        configuration.requestCachePolicy = .returnCacheDataDontLoad
        if NetworkReachabilityManager()?.isReachable ?? true {
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        }
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        let networkLogger = NetworkLogger()
        return Session(
            configuration: configuration,
            cachedResponseHandler: responseCacher,
            eventMonitors: [networkLogger])
        
    }()
    private func manageCachePolicy(manager:Session) {
        
        if NetworkReachabilityManager()?.isReachable ?? true {
            manager.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        } else {
            
            manager.sessionConfiguration.requestCachePolicy = .returnCacheDataDontLoad
        }
    }
    
    public func get(request: NetworkRequestProtocol, callBack: ((NetworkResponseProtocol) -> Void)?) {
        guard let manager = self.configs.manager as? Session else {return}
        let networkResponse = NetworkResponse(request: request)
        guard let url = URL(string: request.fullPath) else {
            
            networkResponse.error = URLError(.badURL)
            callBack?(networkResponse)
            return
        }
        if request.networkConfig == nil {
            request.setConfig(config: self.configs)
        }
        manageCachePolicy(manager: manager)
        manager.request(url, method: .get, parameters: request.stringQuery, encoding: URLEncoding.default)
            .responseData { response in
                Log.networkLog.log("get request with fullUrlpath=\(request.fullPath)")
                switch response.result {
                case .success(_) :
                    networkResponse.response = response.data
                    Log.networkLog.log("get response data successfully")
                    
                case .failure(let error) :
                    networkResponse.error = error
                    Log.networkLog.error("get response error=String(describing: \(error.localizedDescription))")
                    
                }
                callBack?(networkResponse)
            }
    }
    
}


