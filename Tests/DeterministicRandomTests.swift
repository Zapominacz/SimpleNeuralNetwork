// DeterministicRandomTests.swift
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

class DeterministicRandomTests: XCTestCase {
    
    func testRandomRange() {
        (0...100).forEach { _ in
            let value = DeterministicRandom.value
            XCTAssert(value <= 1 && value >= 0, "Random not in range [0, 1]")
        }
    }
    
    func testDeterminity() {
        let firstGenerator = DeterministicRandom(seed: 1)
        let secondGenerator = DeterministicRandom(seed: 1)
        let firstNumbers = [Double](repeating: 0, count: 100).map { _ in firstGenerator.value }
        let secondNumbers = [Double](repeating: 0, count: 100).map { _ in secondGenerator.value }
        XCTAssertEqual(firstNumbers, secondNumbers)
    }
}
