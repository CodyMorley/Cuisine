//
//  CuisineUITests.swift
//  CuisineUITests
//
//  Created by Cody Morley on 1/14/25.
//

import XCTest

final class CuisineUITests: XCTestCase {
    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
