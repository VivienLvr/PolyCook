//
//  IngredientViewModel.swift
//  PolyCook
//
//  Created by Vivien Levacher on 23/02/2022.
//

import Foundation

class IngredientViewModel: ObservableObject {
    var model: Ingredient
    
    @Published var id: String
    @Published var name: String
    @Published var category: IngredientType
    @Published var unit: Unit
    @Published var stock : Int
    @Published var unitPrice : Double
    @Published var isAlergen : Bool
    
    init(from ingredient: Ingredient) {
        self.model = ingredient
        self.id = model.id ?? "default id"
        self.name = model.name
        self.category = model.category //?? IngredientType.autre
        self.unit = model.unit //?? Unit.piece
        self.stock = model.stock //?? 0
        self.unitPrice = model.unitPrice
        self.isAlergen = model.isAlergen
    }
}
