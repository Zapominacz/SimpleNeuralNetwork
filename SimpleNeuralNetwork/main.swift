//
//  main.swift
//  SimpleNeuralNetwork
//
//  Created by Mikołaj Styś on 23.11.2017.
//  Copyright © 2017 Mikołaj Styś. All rights reserved.
//

import Foundation
import GameKit

struct DeterministicRandom {
    
    private static let max = 1000000
    
    private static let instance: GKRandomDistribution = {
        let rs = GKMersenneTwisterRandomSource()
        rs.seed = 1
        return GKRandomDistribution(randomSource: rs, lowestValue: 0, highestValue: max)
    }()
    
    static var value: Double {
        return Double(instance.nextInt()) / Double(max)
    }
}

func sigmoid(_ x: Double, derive: Bool = false) -> Double {
    if derive {
        return x * (1.0 - x)
    }
    return 1.0 / (1.0 + exp(-x))
}

func sigmoid(_ matrix: Matrix, derive: Bool = false) -> Matrix {
    if derive {
        return matrix.map { element, _, _ in element * (1.0 - element) }
    }
    return matrix.map { element, _, _ in 1.0 / (1.0 + exp(-element)) }
}

struct Matrix: CustomStringConvertible {
    
    var description: String {
        return data.reduce("") { "\($0)\($1.reduce("[", { "\($0) \($1)" }))]\n" }
    }

    var data: [[Double]]

    init(_ data: [Double]...) {
        self.data = data
    }
    
    init(_ data: [[Double]]) {
        self.data = data
    }
    
    var transpose: Matrix {
        let width = data.count
        let height = data[0].count
        var result = Array<[Double]>(repeating: Array<Double>(repeating: 0, count: width), count: height)
        forEach { element, row, col in
            result[col][row] = element
        }
        return Matrix(result)
    }
    
    func forEach(_ body: (_ element: Double, _ row: Int, _ col: Int) -> Void) {
        let width = data[0].count
        let height = data.count
        (0..<width).forEach { row in
            (0..<height).forEach { col in
                body(data[row][col], row, col)
            }
        }
    }
    
    func map(_ body: (_ element: Double, _ row: Int, _ col: Int) -> Double) -> Matrix {
        let width = data[0].count
        let height = data.count
        var newData = self.data
        (0..<width).forEach { row in
            (0..<height).forEach { col in
                newData[row][col] = body(data[row][col], row, col)
            }
        }
        return Matrix(newData)
    }
    
    func dotProduct(_ other: Matrix) -> Matrix {
        return map { element, row, col in
            return element * other.data[row][col]
        }
    }
    
    static func random(width: Int, height: Int) -> Matrix {
        var data = Array<[Double]>(repeating: Array<Double>(repeating: 0, count: width), count: height)
        (0..<width).forEach { row in
            (0..<height).forEach { col in
                data[row][col] = DeterministicRandom.value
            }
        }
        return Matrix(data)
    }
}

infix operator *: MultiplicationPrecedence
infix operator -: AdditionPrecedence

func * (lhs: Double, rhs: Matrix) -> Matrix {
    return rhs.map { element, _, _ in
        return lhs * element
    }
}

func * (lhs: Matrix, rhs: Matrix) -> Matrix {
    let width = rhs.data[0].count
    let sumTerms = rhs.data.count
    let height = lhs.data.count
    var result = Array<[Double]>(repeating: Array<Double>(repeating: 0, count: width), count: height)
    (0..<width).forEach { row in
        (0..<height).forEach { col in
            var elementResult = 0.0
            (0..<sumTerms).forEach { sumTerm in
                elementResult += lhs.data[row][sumTerm] * rhs.data[sumTerm][col]
            }
            result[row][col] = elementResult
        }
    }
    return Matrix(result)
}


func - (lhs: Matrix, rhs: Double) -> Matrix {
    return lhs.map { element, _, _ in
        return rhs - element
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

func absoluteMean(_ matrix: Matrix) -> Double {
    var sum = 0.0
    matrix.forEach { element, _, _ in sum += abs(element) }
    return sum / Double(matrix.data.count * matrix.data[0].count)
}

let inputData = Matrix([0, 0, 1, 0], [0, 1, 1, 0], [1, 0, 1, 0], [1, 1, 1, 0])
let outputData = Matrix([0, 1, 1, 0])

//Synapses, i.e. connections weights at specific layer, a first random with mean 0
var synapse0 = 2 * Matrix.random(width: 4, height: 4) - 1
var synapse1 = 2 * Matrix.random(width: 4, height: 1) - 1

(0...100000).forEach { iteration in
    //Forward propagation
    let layer0 = inputData
    let layer1 = sigmoid(layer0.dotProduct(synapse0))
    let layer2 = sigmoid(layer1.dotProduct(synapse1))
    
    //Calculate error
    let layer2Error = outputData - layer2
    
    if iteration % 10000 == 0 {
        print("Current error: \(absoluteMean(layer2Error))")
    }
   
    //In what direction is target value. If we are sure, don't change much.
    let layer2Delta = layer2Error * sigmoid(layer2, derive: true)

    //How much did each layer 1 value contribute to the layer 2 error (according to weights)?
    let layer1Error = layer2Delta.dotProduct(synapse1.transpose)
    
    //In what direction is layer 1. If we are sure, don't change much.
    let layer1Delta = layer1Error * sigmoid(layer1, derive: true)
    
    synapse1 = synapse1 + layer1.transpose.dotProduct(layer2Delta)
    synapse0 = synapse0 + layer0.transpose.dotProduct(layer1Delta)
    
    if iteration == 100000 {
        print("Learning result")
        print(layer2)
    }
}

print("Training output:")

print(synapse0)
print(synapse1)

//synapse0 = np.array([[ 2.21243114 , 4.80030487, -6.99312991, -7.57326441],
//[ 0.34480045, -7.83355659, -7.02793451,  3.13418063],
//[-0.30636526, -1.60166494,  2.34743284, -0.54198415],
//[-0.5910955,  0.75623487, -0.94522481,  0.34093502]])
//
//synapse1 = np.array([[ -6.18136719],
//[ 11.63723577],
//[-10.32714268],
//[  9.91017803]])
//
//
//print "Lets got test it"
//layer0 = np.array([[1, 0, 0, 1]])
//layer1 = nonlinear(np.dot(layer0, synapse0))
//layer2 = nonlinear(np.dot(layer1, synapse1))
//
//print layer2
//
