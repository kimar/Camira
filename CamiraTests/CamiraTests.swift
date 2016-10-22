//
//  CamiraTests.swift
//  CamiraTests
//
//  Created by Marcus Kida on 22/10/16.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import XCTest
@testable import Camira

class CamiraTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPersistency() {
        let game = Game(title: "Title", subtitle: "Subtitle", initial: Scene.start(), player: Player.main())
        let persisted = game.persist()
        print("persisted: \(persisted!)")
    }
}
