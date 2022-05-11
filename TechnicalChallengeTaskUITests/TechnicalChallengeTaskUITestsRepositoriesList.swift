//
//  TechnicalChallengeTaskUITestsRepositoriesList.swift
//  TechnicalChallengeTaskUITests
//
//  Created by Maksym Vitovych on 07.02.2022.
//

import XCTest

class TechnicalChallengeTaskUITestsRepositoriesList: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStaticLabelsExistWithCorrectText()  {
        XCTAssert(app.staticTexts["Repositories: "].exists)
        XCTAssert(app.staticTexts["Sorry, but there is no any repositories here."].exists)
    }
    
    func testTableViewExist() {
        let tableView = app.tables["repositoriesListTableView"]
        XCTAssertNotNil(tableView)
    }
    
    func testTableViewCellsCountMoreThanZero() {
        let tableCells = app.tables["repositoriesListTableView"].cells
            
        if tableCells.count > 0 {
            let cell = tableCells.element(boundBy: 0)
            XCTAssert(cell.exists)
        } else {
            let errorView = app.otherElements["errorView"]
            XCTAssertEqual(errorView.isHittable, false)
        }
    }
    
    func testTryAgainButtonClickBehaviour() {
        let tableCells = app.tables["repositoriesListTableView"].cells
            
        if tableCells.count > 0 {
            let errorView = app.otherElements["errorView"]
            XCTAssertTrue(errorView.isHittable)
        } else {
            let expectation = expectation(description: "Completion handler invoked")
            app.buttons["tryAgainButton"].tap()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: { [weak expectation] in
                expectation?.fulfill()
            })
            
            waitForExpectations(timeout: 3, handler: nil)
            XCTAssertTrue(tableCells.count > 0)
        }
    }
}
