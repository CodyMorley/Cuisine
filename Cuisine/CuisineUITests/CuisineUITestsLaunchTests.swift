//
//  CuisineUITestsLaunchTests.swift
//  CuisineUITests
//
//  Created by Cody Morley on 1/14/25.
//

import XCTest

final class CuisineUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool { true }

    override func setUpWithError() throws { continueAfterFailure = false }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
