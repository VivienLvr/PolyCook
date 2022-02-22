//
//  Recipe.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation

class Recipe {
    var id : String
    var name : String
    var author : String
    var covers : Int
    var priceCoef : Double
    var category : RecipeType
    var progression : Progression
    
    init(id: String, name: String, author: String, covers: Int, priceCoef: Double, category: RecipeType, progression: Progression) {
        self.id = id
        self.name = name
        self.author = author
        self.covers = covers
        self.priceCoef = priceCoef
        self.category = category
        self.progression = progression
    }
}

enum RecipeType: String {
    case cake = "Gateaux"
    case sauce = "Sauce"
}
