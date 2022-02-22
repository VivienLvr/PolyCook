//
//  IngredientDetailsView.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct IngredientsDetailsView: View {
    var ingredient: Ingredient
    var body: some View {
        VStack {
            Text("Nom : ")
            Text(ingredient.name)
            Text("Catégorie : ")
            Text(ingredient.category.rawValue)
            Text("prix : ")
            Text("\(ingredient.unitPrice) € / " + ingredient.unit.rawValue)
        }.navigationTitle("Détails")
    }
}

struct IngredientsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsDetailsView(ingredient: Ingredient(id: "0", name: "ingredient test"))
    }
}
