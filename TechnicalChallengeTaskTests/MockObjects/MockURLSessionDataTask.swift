//
//  MockURLSessionDataTask.swift
//  TechnicalChallengeTaskTests
//
//  Created by Maksym Vitovych on 07.02.2022.
//

import Foundation
@testable import TechnicalChallengeTask

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
