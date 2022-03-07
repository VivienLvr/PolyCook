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
    
    @State private var showingAlert = false
    @State private var deleteIndexSet: IndexSet?
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(searchResults, id: \.id) { item in
                        NavigationLink(destination: IngredientsDetailsView(ingredient: item, ingredients: VM.ingredients)) {
                            VStack(alignment: .leading){
                                //Text(item.id ?? "no id")
                                Text(item.name)
                            }
                        }
                    }
                    .onDelete{ indexSet in
                        self.showingAlert = true
                        self.deleteIndexSet = indexSet
                        for index in indexSet {
                            print(index)
                        }
                    }
                    .onMove{ indexSet, index in
                        
                    }
                    .alert(isPresented: self.$showingAlert) {
                        Alert(title: Text("Confirmation"), message: Text("Êtes-vous sûr de vouloir supprimer cet ingrédient ?\n Cette action est irréversible."),
                              primaryButton: .destructive(Text("Confirmer"), action:  {
                            if let indexSet = self.deleteIndexSet {
                                for index in indexSet {
                                    let removed = self.VM.ingredients.remove(at: index)
                                    self.VM.delete(removed)
                                }
                            }
                        }),
                              secondaryButton: .cancel(Text("Annuler")))
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
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                Task {
                    self.VM.fetchData()
                }
            }
                .navigationBarTitle("Ingredients")
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
        VM.listIngredients()
        print(VM.ingredients.count)
        let newIngred = Ingredient(id: "", name: "nouvel ingrédient")
        VM.ingredients.append(newIngred)
        VM.insertIngredient(ingredient: newIngred)
        print("ingredient added")
    }
    
    var searchResults: [Ingredient] {
            if searchText.isEmpty {
                return VM.ingredients
            } else {
                return VM.ingredients.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
            }
        }
}

struct IngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsListView()
    }
}
