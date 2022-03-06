//
//  IngredientDetailsView.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct IngredientsDetailsView: View {
    @State var ingredient: Ingredient
    var ingredients: [Ingredient]
    @ObservedObject var VM: IngredientViewModel
    @ObservedObject var ListVM: IngredientListViewModel
    var intent = IngredientIntent()
    
    init(ingredient: Ingredient, ingredients: [Ingredient]) {
        self.ingredient = ingredient
        self.ingredients = ingredients
        self.VM = IngredientViewModel(from: ingredient)
        self.ListVM = IngredientListViewModel(ingredients)
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
                    
                Text("Catégorie : ")
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
                }
                Text("Stock : ")
                Stepper("\(VM.stock)", onIncrement: {
                    intent.intentToChange(stock: VM.stock + 1)
                    //VM.stock += 1
                },
                        onDecrement: {
                    intent.intentToChange(stock: VM.stock - 1)
                    //VM.stock -= 1
                })
            }
            .padding(30)
            .navigationTitle("Détails")
                .font(.custom("", size: 25))
            //Spacer().frame(width: 8)
        }
        
    }
}

struct IngredientsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsDetailsView(ingredient: Ingredient(id: "0", name: "ingredient test", stock: 10), ingredients: [])
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

extension TextEditor {
    func classicTextEditorStyle() -> some View {
        self.padding(4)
            .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.8)
            )
    }
}
