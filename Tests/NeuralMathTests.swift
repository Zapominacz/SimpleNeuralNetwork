// NeuralMathTests.swift
//
// Copyright © 2017 Mikołaj Styś
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest

class NeuralMathTests: XCTestCase {
    
    let epsilon = 0.0001
    
    func testSigmoidValues() {
        let x1 = -3.32
        let x2 = 0.0
        let x3 = 2.0
        let x4 = 20.0
        let y1 = 0.0348914085317368
        let y2 = 0.5
        let y3 = 0.880797077977882
        let y4 = 0.999999997938846
        let d1 = -14.3424
        let d2 = 0.0
        let d3 = -2.0
        let d4 = -380.0
        print(sigmoid(20.0, derive: true))
        XCTAssert(closeEnough(sigmoid(x1), y1), "Numbers differs too much")
        XCTAssert(closeEnough(sigmoid(x2), y2), "Numbers differs too much")
        XCTAssert(closeEnough(sigmoid(x3), y3), "Numbers differs too much")
        XCTAssert(closeEnough(sigmoid(x4), y4), "Numbers differs too much")
        XCTAssert(closeEnough(sigmoid(x1, derive: true), d1), "Numbers differs too much")
        XCTAssert(closeEnough(sigmoid(x2, derive: true), d2), "Numbers differs too much")
        XCTAssert(closeEnough(sigmoid(x3, derive: true), d3), "Numbers differs too much")
        XCTAssert(closeEnough(sigmoid(x4, derive: true), d4), "Numbers differs too much")
        let x = Matrix([x1, x2], [x3, x4])
        let y = [[y1, y2], [y3, y4]]
        let d = [[d1, d2], [d3, d4]]
        sigmoid(x).forEach {
            XCTAssert(closeEnough($0, y[$1][$2]), "Numbers differs too much")
        }
        sigmoid(x, derive: true).forEach {
            XCTAssert(closeEnough($0, d[$1][$2]), "Numbers differs too much")
        }
    }
    
    func testAbsoluteMean() {
        let a = Matrix([-1, 1, 0, 0])
        let result = 0.5
        XCTAssertEqual(result, absoluteMean(a), "Absolute mean not equal")
    }
    
    private func closeEnough(_ lhs: Double, _ rhs: Double) -> Bool {
        return (lhs - epsilon) < rhs && (lhs + epsilon) > rhs
    }
}
