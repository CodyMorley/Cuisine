//
//  CuisineTests.swift
//  CuisineTests
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI
import XCTest
@testable import Cuisine

final class CuisineTests: XCTestCase {
    func testRecipesAppBody() {
        let app = CuisineApp()
        
        let body = app.body
        
        XCTAssertNotNil(body, "The app's body should not be nil")
        XCTAssertTrue(body is WindowGroup<ContentView>, "The body should be a WindowGroup containing ContentView")
    }
}
