//
//  Mocks.swift
//  MockAlamofire
//

import Foundation

enum MockDirection: String {
    case get = "GET", put = "PUT", post = "POST"
}

struct Mocks {
    private static var mockJson =
    "{ \"price\": \"1602.4765861121018\", \"timestamp\": 1677432780, }"
    
    
    
    static func find(_ request: URLRequest ) -> Data? {
        guard let _ = (request.url?.pathComponents),
              let method = request.httpMethod,
              let _ = MockDirection(rawValue: method)
        else { return nil }
        
        return mockJson.data(using: String.Encoding.utf8)
    }
}
