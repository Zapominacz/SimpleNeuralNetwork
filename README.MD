# Simple neural network
Simple neural network example, rewritten to Swift from Python.

Neural network copied from: https://iamtrask.github.io/2015/07/12/basic-python-network/

## Purpose
This project was created to learn some basics of the neural networks by writing the code.

## What this neural network do?
Given four examples that contains four input signals: `[a, b, c, d]` and one output signal `[o]`, neural network needs to learn how to compute output value from input. Originally, this output value was computed by XOR'ing first two signals, i.e. `o = a XOR b`.

After learning phase, neural network is tested using another input signal to validate it.

## About project
Project was intended to have educational values. Because of that everything was written without libraries (except `DeterministicRandom`). The major drawback of this approach is long computation time, but at least operations are more readable.

Simple tests were added. Matrix was implemented in a very naive way.

## Install and run
Open *SimpleNeuralNetwork.xcodeproj* in repository folder and launch SimpleNeuralNetwork target.

**Program execution will take a while, because of non-optimised math functions.**

## Other
Any suggestions will be appreciated :)
