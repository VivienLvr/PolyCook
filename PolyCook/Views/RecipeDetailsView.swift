//
//  IngredientDetailsView.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct RecipeDetailsView: View {
    @State var recipe: Recipe
    var recipes: [Recipe]
    @ObservedObject var VM: RecipeViewModel
    @ObservedObject var ListVM: RecipeListViewModel
    var intent = RecipeIntent()
    
    init(recipe: Recipe, recipes: [Recipe]) {
        self.recipe = recipe
        self.recipes = recipes
        self.VM = RecipeViewModel(from: recipe)
        self.ListVM = RecipeListViewModel(recipes)
        self.intent.addObserver(viewModel: VM, listVM: ListVM)
    }
    
    let cols: [GridItem] = [
        GridItem(.fixed(140), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack {
            //Spacer().frame(width: )
            LazyVGrid(columns: cols, spacing: 15) {
                Text("Nom : ")
                TextField("name", text: $VM.name)
                    .classicTextFieldStyle()
                    .onSubmit {
                        intent.intentToChange(name: VM.name)
                        intent.updateList()
                    }
                    
                /*Text("Catégorie : ")
                Menu(VM.category.rawValue) {
                    ForEach(IngredientType.allCases, id: \.self) { type in
                        Button(type.rawValue, action: {
                            intent.intentToChange(category: type)
                            //intent.updateList()
                            //VM.category = type;
                        })
                    }
                    /*for type in IngredientType.allCases {
                        print(type.rawValue)
                    }*/
                }
                //Text(ingredient.category.rawValue ?? "pas de type")
                Text("prix : ")
                HStack {
                    TextField("unitPrice", value: $VM.unitPrice, formatter: formatter)
                        .onSubmit {
                            intent.intentToChange(unitPrice: VM.unitPrice)
                            //intent.updateList()
                        }
                    Text("/ " + VM.unit.rawValue ?? "no unit")
                }*/
                Text("Nombre de couverts : ")
                Stepper("\(VM.covers)", onIncrement: {
                    intent.intentToChange(covers: VM.covers + 1)
                },
                        onDecrement: {
                    intent.intentToChange(covers: VM.covers - 1)
                })
            }
            .padding(30)
            .navigationTitle("Détails")
                .font(.custom("", size: 25))
            //Spacer().frame(width: 8)
        }
        
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: Recipe(id: "0", name: "recipe test", covers: 10, category: .other), recipes: [])
    }
}
