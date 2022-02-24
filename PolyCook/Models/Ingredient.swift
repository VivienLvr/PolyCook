//
//  Ingredient.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation
import FirebaseFirestoreSwift

class Ingredient : Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
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
    
    enum CodingKeys: String, CodingKey{
        //case id = "id"
        case name
        case category
        case unit
        case stock
        case unitPrice
        case isAlergen
    }
}



enum IngredientType: String, Codable {
    case meat = "Viande"
    case fish = "Poissons et crustacés"
    case cremerie = "Crèmerie"
    case vegetable = "Légume"
    case fruit = "Fruit"
    case epicerie = "Epicerie"
    case autre = "Autre"
}



enum Unit: String, Codable {
    case gramm = "g"
    case litre = "l"
    case piece = "Pièce"
    case kg = "kg"
    case botte = "botte"
}

struct IngredientDTO : Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var category: IngredientType?
    var unit: Unit?
    var stock : Int?;
    var unitPrice : Double?;
    var isAlergen : Bool?;
    
    enum CodingKeys: String, CodingKey{
        //case id = "id"
        case name
        case category
        case unit
        case stock
        case unitPrice
        case isAlergen
    }
    
    init(id: String, name: String, category: String = "autre", unit: String = "Pièce", stock: Int = 0, unitPrice: Double = 1.0, isAlergen: Bool = false) {
        self.id = id
        self.name = name
        self.category = IngredientType(rawValue: category) ?? IngredientType.autre
        self.unit = Unit(rawValue: unit) ?? Unit.piece
        self.stock = stock
        self.unitPrice = unitPrice
        self.isAlergen = isAlergen
    }
}
