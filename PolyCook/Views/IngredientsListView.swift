//
//  IngredientsList.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct IngredientsListView: View {
    let ingredients: [Ingredient] = [
        Ingredient(id: "1", name: "Poire"),
        Ingredient(id: "2", name: "Pomme"),
        Ingredient(id: "3", name: "Sucre")
    ]
    var body: some View {
        List {
            ForEach(ingredients, id: \.id) { item in
                NavigationLink(destination: IngredientsDetailsView(ingredient: item)) {
                    VStack(alignment: .leading){
                        Text(item.id)
                        Text(item.name)
                    }
                }
            }
            .onDelete{ indexSet in
                
            }
            .onMove{ indexSet, index in
                
            }
        }.navigationTitle("Liste des ingrédients")
    }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
