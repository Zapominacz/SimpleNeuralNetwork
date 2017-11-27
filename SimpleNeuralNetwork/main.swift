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
