//
//  HttpClientTests.swift
//  TechnicalChallengeTaskTests
//
//  Created by Maksym Vitovych on 07.02.2022.
//

import XCTest
@testable import TechnicalChallengeTask

class HttpClientTests: XCTestCase {

    var httpClientUnderTest: HTTPClient!
    let session = MockURLSession()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        httpClientUnderTest = HTTPClient(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        httpClientUnderTest = nil
    }

    func testGetRequestWithURL() {
        let urlPath = "https://mockurl/getSomething"
        
        httpClientUnderTest.request(url: urlPath) { response in
            // Return data
        }
        
        XCTAssert(session.lastURL == urlPath)
    }
    
    func testGetResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        let urlPath = "https://mockurl/getSomething"
        
        httpClientUnderTest.request(url: urlPath)  { response in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
