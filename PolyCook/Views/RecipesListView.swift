//
//  IngredientsList.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject var VM = RecipeListViewModel([
        Recipe(id: "1", name: "Recette 1", category: .cake),
        Recipe(id: "2", name: "Recette 2", category: .cake),
        Recipe(id: "3", name: "Recette 3", category: .cake)
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
                        NavigationLink(destination: RecipeDetailsView(recette: item, recettes: VM.recipes)) {
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
                        Alert(title: Text("Confirmation"), message: Text("Êtes-vous sûr de vouloir supprimer cette recette ?\n Cette action est irréversible."),
                              primaryButton: .destructive(Text("Confirmer"), action:  {
                            if let indexSet = self.deleteIndexSet {
                                for index in indexSet {
                                    let removed = self.VM.recipes.remove(at: index)
                                    self.VM.delete(removed)
                                }
                            }
                        }),
                              secondaryButton: .cancel(Text("Annuler")))
                    }
                }
                .navigationTitle("Liste des recettes")
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
        } .navigationBarTitle("Recipes")    }
    
    private var addButton: some View {
        switch editMode {
                case .inactive:
                    return AnyView(Button(action: onAdd) { Text("Ajouter") })
                default:
                    return AnyView(EmptyView())
                }
    }
    
    func onAdd() {
        //VM.listIngredients()
        print(VM.recipes.count)
        let newRec = Recipe(id: "", name: "Nouvelle recette", author: "aucun", category: .other)
        VM.recipes.append(newRec)
        VM.insertRecipe(recipe: newRec)
        print("recipe added")
    }
    
    var searchResults: [Recipe] {
            if searchText.isEmpty {
                return VM.recipes
            } else {
                return VM.recipes.filter { $0.name.range(of: searchText, options: .caseInsensitive) != nil }
            }
        }
}

struct RecipesListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView()
    }
}
