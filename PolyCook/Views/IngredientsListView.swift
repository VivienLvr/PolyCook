//
//  IngredientsList.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct IngredientsListView: View {
    @StateObject var VM = IngredientListViewModel([
        IngredientDTO(id: "1", name: "Poire"),
        IngredientDTO(id: "2", name: "Pomme"),
        IngredientDTO(id: "3", name: "Sucre")
    ])
    
    @State private var editMode = EditMode.inactive
    
    @State private var showingAlert = false
    @State private var deleteIndexSet: IndexSet?
    
    var body: some View {
        VStack {
            List {
                ForEach(VM.ingredients, id: \.id) { item in
                    NavigationLink(destination: IngredientsDetailsView(ingredient: item)) {
                        VStack(alignment: .leading){
                            //Text(item.id ?? "no id")
                            Text(item.name)
                        }
                    }
                }
                .onDelete{ indexSet in
                    self.showingAlert = true
                    self.deleteIndexSet = indexSet
                }
                .onMove{ indexSet, index in
                    
                }
                .alert(isPresented: self.$showingAlert) {
                    Alert(title: Text("Confirmation"), message: Text("Êtes-vous sûr de vouloir supprimer cet ingrédient ?\n Cette action est irréversible."),
                          primaryButton: .destructive(Text("Confirmer"), action:  {
                        if let indexSet = self.deleteIndexSet {
                            for index in indexSet {
                                self.VM.ingredients.remove(at: index)
                            }
                        }
                    }),
                          secondaryButton: .cancel())
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
        .onAppear {
            Task {
                self.VM.fetchData()
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
        print(VM.listDTO.count)
        VM.ingredients.append(Ingredient(id: "4", name: "new ingredient"))
        print("ingredient added")
    }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
