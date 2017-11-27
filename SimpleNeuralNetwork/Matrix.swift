// Matrix.swift
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

import Foundation

infix operator **: MultiplicationPrecedence
infix operator -: AdditionPrecedence
infix operator +: AdditionPrecedence

// Naive matrix implementation
struct Matrix: CustomStringConvertible, Equatable {
    
    // Returns matrix representation
    var description: String {
        return data.reduce("") { "\($0)\($1.reduce("[", { "\($0) \($1)" }))]\n" }
    }
    
    // Data that the matrix holds
    let data: [[Double]]
    
    init(_ data: [Double]...) {
        self.data = data
    }
    
    init(_ data: [[Double]]) {
        self.data = data
    }
    
    // Transposess the matrix
    var transpose: Matrix {
        let width = data.count
        let height = data[0].count
        var result = Array<[Double]>(repeating: Array<Double>(repeating: 0, count: width), count: height)
        forEach { element, row, col in
            result[col][row] = element
        }
        return Matrix(result)
    }
    
    // Convenience forEach for matrix
    func forEach(_ body: (_ element: Double, _ row: Int, _ col: Int) -> Void) {
        let width = data.count
        let height = data[0].count
        (0..<width).forEach { row in
            (0..<height).forEach { col in
                body(data[row][col], row, col)
            }
        }
    }
    
    // Convenience map for matrix
    func map(_ body: (_ element: Double, _ row: Int, _ col: Int) -> Double) -> Matrix {
        let width = data[0].count
        let height = data.count
        var newData = self.data
        (0..<height).forEach { row in
            (0..<width).forEach { col in
                newData[row][col] = body(data[row][col], row, col)
            }
        }
        return Matrix(newData)
    }
    
    // Creates random matrix with elements in range [0, 1] and specified dimensions
    static func random(width: Int, height: Int) -> Matrix {
        var data = Array<[Double]>(repeating: Array<Double>(repeating: 0, count: width), count: height)
        (0..<height).forEach { row in
            (0..<width).forEach { col in
                data[row][col] = DeterministicRandom.value
            }
        }
        return Matrix(data)
    }
}

func ==(lhs: Matrix, rhs: Matrix) -> Bool {
    return lhs.data.count == rhs.data.count &&
        (0..<lhs.data.count).every { lhs.data[$0] == rhs.data[$0] }
}

// Multiplies every matrix element by lhs
func * (lhs: Double, rhs: Matrix) -> Matrix {
    return rhs.map { element, _, _ in
        return lhs * element
    }
}

// Matrix elements multiplication, i.e. multiply element by element
func ** (lhs: Matrix, rhs: Matrix) -> Matrix {
    return lhs.map { element, row, col in
        return element * rhs.data[row][col]
    }
}

// Matrix multiplication
func * (lhs: Matrix, rhs: Matrix) -> Matrix {
    let width = rhs.data[0].count
    let sumTerms = lhs.data[0].count
    let height = lhs.data.count
    var result = Array<[Double]>(repeating: Array<Double>(repeating: 0, count: width), count: height)
    (0..<height).forEach { row in
        (0..<width).forEach { col in
            var elementResult = 0.0
            (0..<sumTerms).forEach { sumTerm in
                elementResult += lhs.data[row][sumTerm] * rhs.data[sumTerm][col]
            }
            
            result[row][col] = elementResult
        }
    }
    return Matrix(result)
}

// Substracts rhs from every element
func - (lhs: Matrix, rhs: Double) -> Matrix {
    return lhs.map { element, _, _ in
        return element - rhs
    }
}

func - (lhs: Matrix, rhs: Matrix) -> Matrix {
    return lhs.map { element, row, col in
        return element - rhs.data[row][col]
    }
}

func + (lhs: Matrix, rhs: Matrix) -> Matrix {
    return lhs.map { element, row, col in
        return element + rhs.data[row][col]
    }
}
