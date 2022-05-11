//
//  URLSessionTests.swift
//  TechnicalChallengeTaskTests
//
//  Created by Maksym Vitovych on 07.02.2022.
//

import XCTest
@testable import TechnicalChallengeTask

class URLSessionTests: XCTestCase {

    var sessionUnderTest: URLSessionProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = MockURLSession()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
    }

    func testGetSuccessResponseFromRequest() {
        let url = URL(string: "https://mockurl/getSomething")

        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let request = URLRequest(url: url!)
        let dataTask = sessionUnderTest.dataTask(request: request) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          // 2
          promise.fulfill()
        }
        
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
