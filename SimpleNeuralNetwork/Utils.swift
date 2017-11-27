//
//  Utils.swift
//  SimpleNeuralNetwork
//
//  Created by Mikołaj Styś on 27.11.2017.
//  Copyright © 2017 Mikołaj Styś. All rights reserved.
//

import Foundation

extension Sequence {
    
    func every(_ body: (Element) -> (Bool)) -> Bool {
        for element in self {
            if !body(element) {
                return false
            }
        }
        return true
    }
}
