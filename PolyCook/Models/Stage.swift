//
//  Stage.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation

class Stage: Codable {
    var id: String
    var title: String
    var duration: Int
    var ingredients: [QuantityIngredient]
    
    init(id: String, title: String, duration: Int, ingredients: [QuantityIngredient]) {
        self.id = id
        self.title = title
        self.duration = duration
        self.ingredients = ingredients
    }
}

struct QuantityIngredient: Codable {
    var quantity: Int
    var ingredient: Ingredient
}
