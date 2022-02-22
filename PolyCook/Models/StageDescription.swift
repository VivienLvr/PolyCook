//
//  StageDescription.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation

class StageDescription: Stage {
    var description: String
    var phase : Int
    
    init(id: String, title: String, duration: Int, ingredients: [QuantityIngredient], description: String, phase: Int) {
        self.description = description
        self.phase = phase
        super.init(id: id, title: title, duration: duration, ingredients: ingredients)
    }
}
