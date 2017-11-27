// MatrixTests.swift
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

class MatrixTests: XCTestCase {

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
    
    func testTranspose() {
        let matrix = Matrix([1, 2, 4, 5], [2, 3, 4, 1])
        let result = Matrix([1, 2], [2, 3], [4, 4], [5, 1])
        XCTAssertEqual(matrix.transpose, result, "Transposing returned bad matrix")
    }
    
    func testDotProduct() {
        let a = Matrix([1, 2, 4, 5])
        let b = Matrix([2, 3, 4, 1])
        print(a.dotProduct(b))
        XCTAssertEqual(Matrix([29]), a.dotProduct(b), "Dot product bad implemented")
    }
    
    func testMatrixValueOperations() {
        let matrix = Matrix([1, 4, 6, 10], [2, 7, 5, 3])
        XCTAssertEqual(Matrix([2, 8, 12, 20], [4, 14, 10, 6]), 2 * matrix, "Multiplication bad implemented")
        XCTAssertEqual(Matrix([-1, 2, 4, 8], [0, 5, 3, 1]), matrix - 2, "Substraction bad implemented")
        XCTAssertEqual(Matrix([3, 6, 8, 12], [4, 9, 7, 5]), matrix - (-2), "Substraction bad implemented")
    }
    
    func testMatrixAddition() {
        let a = Matrix([1, 4, 6, 10], [2, 7, 5, 3])
        let b = Matrix([1, 4, 6, 1], [2, 4, 5, 3])
        XCTAssertEqual(Matrix([2, 8, 12, 11], [4, 11, 10, 6]), a + b, "Matrix addition bad implemented")
        XCTAssertEqual(Matrix([0, 0, 0, 9], [0, 3, 0, 0]), a - b, "Matrix substraction bad implemented")
    }
    
    func testMatrixMultiplication() {
        let a = Matrix([1, 2], [3, 4], [5, 6])
        let b = Matrix([1, 2, 3, 4], [5, 6, 7, 8])
        let product = Matrix([11, 14, 17, 20], [23, 30, 37, 44], [35, 46, 57, 68])
        XCTAssertEqual(product, a * b, "Multiplication is bad implemented")
    }
}
