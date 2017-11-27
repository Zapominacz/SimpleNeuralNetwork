// NeuralMath.swift
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

// Useful function in neural networks. Maps every real number into range [0, 1] (every number has its own mapped value).
// See: https://en.wikipedia.org/wiki/Sigmoid_function
// Added convenience derivative.
func sigmoid(_ x: Double, derive: Bool = false) -> Double {
    if derive {
        return x * (1.0 - x)
    }
    return 1.0 / (1.0 + exp(-x))
}

// Matrix variation of sigmoid function.
func sigmoid(_ matrix: Matrix, derive: Bool = false) -> Matrix {
    if derive {
        return matrix.map { element, _, _ in element * (1.0 - element) }
    }
    return matrix.map { element, _, _ in 1.0 / (1.0 + exp(-element)) }
}

// Computes error between learning layer and output data. Only for debugging.
func absoluteMean(_ matrix: Matrix) -> Double {
    var sum = 0.0
    matrix.forEach { element, _, _ in sum += abs(element) }
    return sum / Double(matrix.data.count * matrix.data[0].count)
}
