//
//  TerranautTests.swift
//  TerranautTests
//
//  Created by Jane Appleseed on 5/23/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import XCTest

class TerranautTests: XCTestCase {
    
    // MARK: Terranaut Tests

    // Tests to confirm that the Gear initializer returns nil when no name or a negative rating is provided.
    func testGearInitialization() {
        // Success case.
        let potentialItem = Gear(name: "Newest gear", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Gear(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Gear(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating)
    }
}
