//
//  JSONParserTests.swift
//  TechnicalChallengeTaskTests
//
//  Created by Maksym Vitovych on 07.02.2022.
//

import XCTest
@testable import TechnicalChallengeTask

class JSONParserTests: XCTestCase {

    var jsonParserUnderTest: JSONParserServiceProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        jsonParserUnderTest = JSONParserService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        jsonParserUnderTest = nil
    }

    func testParseModelWithoutErrors() {
        let promise = expectation(description: "Completion handler invoked")
        var firstRepository: RepositoriesListEntity.Response.RepositoriesResponse?
        var parseError: Error?

        if let path = Bundle.main.path(forResource: "MockRepositoriesEntity", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                jsonParserUnderTest.parseJSON(of: [RepositoriesListEntity.Response.RepositoriesResponse].self, from: data) { (result) in
                    switch result {
                    
                    case .success(let response):
                        firstRepository = response.first
                    case .failure(let error):
                        parseError = error
                    }
                    
                    promise.fulfill()
                }
            } catch {
                fatalError("Can't get data from MockRepositoriesEntity json")
            }
        } else {
            fatalError("Can't read from MockRepositoriesEntity json")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(parseError)
        XCTAssertNotNil(firstRepository)
        XCTAssertNotNil(firstRepository?.name)
    }
    
    func testParseModelReturnRightFirstItem() {
        let promise = expectation(description: "Completion handler invoked")
        var firstRepository: RepositoriesListEntity.Response.RepositoriesResponse?

        if let path = Bundle.main.path(forResource: "MockRepositoriesEntity", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                jsonParserUnderTest.parseJSON(of: [RepositoriesListEntity.Response.RepositoriesResponse].self, from: data) { (result) in
                    switch result {
                    
                    case .success(let response):
                        firstRepository = response.first
                    default:
                        break
                    }
                    
                    promise.fulfill()
                }
            } catch {
                fatalError("Can't get data from MockRepositoriesEntity json")
            }
        } else {
            fatalError("Can't read from MockRepositoriesEntity json")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertEqual(firstRepository?.name, "yajl-objc")
        XCTAssertEqual(firstRepository?.description, "Objective-C bindings for YAJL (Yet Another JSON Library) C library")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
