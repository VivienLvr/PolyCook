//
//  IngredientDetailsView.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct IngredientsDetailsView: View {
    var ingredient: Ingredient
    @ObservedObject var VM: IngredientViewModel
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
        self.VM = IngredientViewModel(from: ingredient)
    }
    
    var body: some View {
        HStack {
            Spacer().frame(width: 40)
            VStack(alignment: .leading) {
                Text("Nom : ")
                TextField("name", text: $VM.name)
                    .classicTextFieldStyle()
                Text("Catégorie : ")
                Menu(ingredient.category.rawValue) {
                    
                }
                Text(ingredient.category.rawValue ?? "pas de type")
                Text("prix : ")
                HStack {
                    Text(String(format: "%.2f €", ingredient.unitPrice ?? 0))
                    Text(ingredient.unit.rawValue ?? "no unit")
                }
                Text("Stock : ")
                //Stepper("", value: $ingredient.stock)
            }.navigationTitle("Détails")
                .font(.custom("", size: 25))
            Spacer().frame(width: 40)
        }
        
    }
}

struct IngredientsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsDetailsView(ingredient: Ingredient(id: "0", name: "ingredient test", stock: 10))
    }
}

extension TextField {
    func classicTextFieldStyle() -> some View {
        self.padding(4)
            .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.8)
            )
    }
}
