//
//  MockURLSession.swift
//  TechnicalChallengeTaskTests
//
//  Created by Maksym Vitovych on 07.02.2022.
//

import Foundation
@testable import TechnicalChallengeTask

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    private (set) var lastURL: String?
    
    private var mockResponse: HTTPURLResponse?

    var nextData: Data?
    var nextError: Error?

    init() {}
    
    init(mockResponse: HTTPURLResponse) {
        self.mockResponse = mockResponse
    }
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url?.absoluteString
        
        if let mockResponse = mockResponse {
            completionHandler(nextData, mockResponse, nextError)
        }
        else {
            //default case is success
            completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        }

        return nextDataTask
    }
}
