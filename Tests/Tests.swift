//
//  Tests.swift
//  Tests
//
//  Created by Mikołaj Styś on 27.11.2017.
//  Copyright © 2017 Mikołaj Styś. All rights reserved.
//

import XCTest

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEquality() {
        let a = Matrix([1, 2, 4, 5], [2, 3, 4, 1])
        let b = Matrix([1, 2, 4, 5], [2, 3, 4, 1])
        XCTAssertEqual(a, b, "Matrixes should be equal")
    }
    
    func testMap() {
        let a = Matrix([1, 2, 4, 5], [2, 3, 4, 1])
        let b = Matrix([2, 4, 8, 10], [4, 6, 8, 2])
        XCTAssertEqual(a.map({ element, _, _ in element * 2 }), b)
    }
    
    func testForEach() {
        let data: [[Double]] = [[1, 2, 4, 5], [2, 3, 4, 1]]
        let a = Matrix(data)
        a.forEach { element, row, col in
            XCTAssertEqual(data[row][col], element, "Foreach points wrong element")
        }
    }
    
//    class MathTests: XCTestCase {
//
//        func testEquality() {
//            let a = Matrix([1, 2, 4, 5], [2, 3, 4, 1])
//            let b = Matrix([2, 4, 8, 10], [4, 6, 8, 2])
//            XCTAssertEqual(a.map({ element, _, _ in element * 2 }), b)
//        }
//
//        func testMatrixMultiplication() {
//            let a = Matrix([1, 4, 6, 10], [2, 7, 5, 3])
//            let b = Matrix([1, 4, 6,], [2, 7, 5], [9, 0, 11], [3, 1, 0])
//            let product = Matrix([93, 43, 92], [70, 60, 102])
//        }
//
//    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
