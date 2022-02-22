//
//  IngredientsList.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct IngredientsListView: View {
    @StateObject var VM = IngredientListViewModel([
        Ingredient(id: "1", name: "Poire"),
        Ingredient(id: "2", name: "Pomme"),
        Ingredient(id: "3", name: "Sucre")
    ])
    
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        VStack {
            List {
                ForEach(VM.ingredients, id: \.id) { item in
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
            }
            .navigationTitle("Liste des ingrédients")
            HStack {
                Spacer()
                EditButton()
                Spacer()
                addButton
                Spacer()
            }
        }
    }
    
    private var addButton: some View {
        switch editMode {
                case .inactive:
                    return AnyView(Button(action: onAdd) { Text("Ajouter") })
                default:
                    return AnyView(EmptyView())
                }
    }
    
    func onAdd() {
        VM.ingredients.append(Ingredient(id: "4", name: "new ingredient"))
        print("ingredient added")
    }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
