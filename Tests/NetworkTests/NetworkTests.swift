import XCTest
@testable import Network
import Alamofire

final class NetworkTests: XCTestCase {
    
    let manager: Session = {
        let configuration = URLSessionConfiguration.af.default
        
        //The most important string!
        configuration.protocolClasses = [MockURLProtocol.self]
        
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        return Session(
            configuration: configuration,
            cachedResponseHandler: responseCacher)
    }()
    
    
    func testMock_getRequest() {
        
        let expect = expectation(description: "Get")
        
        manager.request("https://api.coinranking.com/v2/coin/razxDUgYGNAdQ/price").responseData { response in
            switch response.result {
            case .success(let value):
                let val = value as AnyObject?
                print("Mock DATA", val as Any)
            case .failure(let error):
                print("Error: Handle failure", error)
            }
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
