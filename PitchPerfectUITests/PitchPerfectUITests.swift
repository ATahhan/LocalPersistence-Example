//
//  PitchPerfectUITests.swift
//  PitchPerfectUITests
//
//  Created by Ammar AlTahhan on 15/11/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import XCTest

class PitchPerfectUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        app.buttons["Record"].tap()
        
        let stopButton = app.buttons["Stop"]
        stopButton.tap()
        app.buttons["LowPitch"].tap()
        stopButton.tap()
        app.buttons["Fast"].tap()
        stopButton.tap()
        app.navigationBars["PitchPerfect.PlaySoundsView"].buttons["Back"].tap()
        
    }

}
