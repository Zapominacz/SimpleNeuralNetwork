// DeterministicRandom.swift
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

import GameKit

// It is important to have deterministic random as it is useful during neural network debugging
struct DeterministicRandom {
    
    private enum Constants {
        static let max = 1000000
        static let min = 0
        static let defaultSeed: UInt64 = 1
    }
    
    private static let instance = DeterministicRandom(seed: Constants.defaultSeed)
    
    private let randomGenerator: GKRandomDistribution
    
    // Constructor - available primary for testing purposes
    init(seed: UInt64) {
        let source = GKMersenneTwisterRandomSource()
        source.seed = 1
        randomGenerator = GKRandomDistribution(randomSource: source, lowestValue: Constants.min,
                                               highestValue: Constants.max)
    }
    
    // Returns random number in range [0, 1]
    var value: Double {
        return Double(randomGenerator.nextInt()) / Double(Constants.max)
    }
    
    // Returns random number in range [0, 1]
    static var value: Double {
        return instance.value
    }
}
