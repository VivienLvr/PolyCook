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
    var stages: [Stage]
    
    @State private var editMode = EditMode.inactive
    
    init(recipe: Recipe, recipes: [Recipe]) {
        self.recipe = recipe
        self.recipes = recipes
        self.VM = RecipeViewModel(from: recipe)
        self.ListVM = RecipeListViewModel(recipes)
        stages = recipe.progression.stages ?? []
        self.intent.addObserver(viewModel: VM, listVM: ListVM)
        if let stages = recipe.progression.stages {
            print(stages.count)
        }
        
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
        VStack(alignment: .leading) {
            Spacer()
            LazyVGrid(columns: cols, spacing: 15) {
                Text("Nom : ")
                TextField("name", text: $VM.name)
                    .classicTextFieldStyle()
                    .onSubmit {
                        intent.intentToChange(name: VM.name)
                        intent.updateList()
                    }
                Text("Auteur : ")
                TextField("author", text: $VM.author)
                    .classicTextFieldStyle()
                    .onSubmit {
                        intent.intentToChange(author: VM.author)
                        intent.updateList()
                    }
                    
                Text("Catégorie : ")
                Menu(VM.category.rawValue) {
                    ForEach(RecipeType.allCases, id: \.self) { type in
                        Button(type.rawValue, action: {
                            VM.category = type;
                            intent.intentToChange(category: type)
                            intent.updateList()
                        })
                    }
                    /*for type in IngredientType.allCases {
                        print(type.rawValue)
                    }*/
                }
                //Text(ingredient.category.rawValue ?? "pas de type")
                
                Text("Nombre de couverts : ")
                Stepper("\(VM.covers)", onIncrement: {
                    intent.intentToChange(covers: VM.covers + 1)
                },
                        onDecrement: {
                    intent.intentToChange(covers: VM.covers - 1)
                })
                Text("coefficient de prix : ")
                HStack {
                    TextField("priceCoef", value: $VM.priceCoef, formatter: formatter)
                        .onSubmit {
                            intent.intentToChange(priceCoef: VM.priceCoef)
                            //intent.updateList()
                        }
                }
            }
            //.padding(30)
                            //.font(.custom("", size: 15))
            Spacer().frame(height: 30)
            Text("Progression").font(.title)
            List {
                ForEach(stages.indices) { i in
                    NavigationLink(destination: StageDetailsView(stage: stages[i], recipe: self.recipe, recipes: self.recipes)) {
                        Text("\(i+1) - \(stages[i].title) (\(stages[i].duration ?? 5) min)")
                    }
                }
            }
            HStack {
                Spacer()
                EditButton()
                Spacer()
                //addButton
                Spacer()
            }
        }
        .navigationTitle("Détails")
        .padding(30)
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
        let newStage = Stage(id: "", title: "Nouvelle étape", duration: 0, description: "", ingredients: [])
        stages.append(newStage)
        VM.insertRecipe(recipe: newRec)
        print("recipe added")
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: Recipe(id: "0", name: "recipe test", covers: 10, category: .other, progression: Progression(stages: [
            Stage(id: "1", title: "stage 1", duration: 10, description: "", ingredients: [])
            , Stage(id: "2", title: "stage 2", duration: 20, description: "", ingredients: [])
        ]))
            , recipes: [])
    }
}
