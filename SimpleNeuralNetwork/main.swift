// main.swift
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

// Our task: first two elements XOR'ed gives output value. We will try to create XOR from this values by
// learning neural networks by examples.
let inputData = Matrix([0, 0, 1, 0], [0, 1, 1, 0], [1, 0, 1, 0], [1, 1, 1, 0])
let outputData = Matrix([0, 1, 1, 0]).transpose

//Synapses, i.e. connections weights between layers, a first random with mean 0
var synapse0 = 2 * Matrix.random(width: 4, height: 4) - 1
var synapse1 = 2 * Matrix.random(width: 1, height: 4) - 1

let maxIterations = 40000

(0...maxIterations).forEach { iteration in
    //Forward propagation: layer0 -> layer1 -> layer2
    let layer0 = inputData
    let layer1 = sigmoid(layer0 * synapse0)
    let layer2 = sigmoid(layer1 * synapse1)

    //Calculate error between expected value and result
    let layer2Error = outputData - layer2

    //Debug purposes, how big is the error currently
    if iteration % 10000 == 0 {
        print("Current error: \(absoluteMean(layer2Error))")
    }

    //In what direction is target value. If we are sure, don't change much.
    //I.e. should we add to remove weight from synapse for element
    let layer2Delta = layer2Error ** sigmoid(layer2, derive: true)

    //How much did each layer 1 value contribute to the layer 2 error
    let layer1Error = layer2Delta * synapse1.transpose

    //In what direction is layer 1. If we are sure, don't change much.
    let layer1Delta = layer1Error ** sigmoid(layer1, derive: true)

    //Update synapses, i.e. weights
    synapse1 = synapse1 + layer1.transpose * layer2Delta
    synapse0 = synapse0 + layer0.transpose * layer1Delta

    //Print result from layer2 (should be close to output matrix) during last iteration
    if iteration == maxIterations {
        print("Learning result")
        print(layer2)
    }
}

print("Lets got test learned synapses")
let layer0 = Matrix([[1, 0, 1, 1]])
let layer1 = sigmoid(layer0 * synapse0)
let layer2 = sigmoid(layer1 * synapse1)
// It works!
print(layer2)




