//
//  Ingredient.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation

class Ingredient {
    var id: String
    var name: String
    var category: IngredientType
    var unit: Unit
    var stock : Int;
    var unitPrice : Double;
    var isAlergen : Bool;
    
    init(id: String, name: String, category: IngredientType = .autre,
         unit: Unit = .piece, stock: Int = 0, unitPrice: Double = 1.0, isAlergen: Bool = false) {
        self.id = id
        self.name = name
        self.category = category
        self.unit = unit
        self.stock = stock
        self.unitPrice = unitPrice
        self.isAlergen = isAlergen
    }
}



enum IngredientType: String {
    case meat = "Viande"
    case fish = "Poissons et crustacés"
    case cremerie = "Crèmerie"
    case vegetable = "Légume"
    case fruit = "Fruit"
    case epicerie = "Epicerie"
    case autre = "Autre"
}



enum Unit: String {
    case gramm = "g"
    case litre = "l"
    case piece = "Pièce"
    case kg = "kg"
    case botte = "botte"
}
