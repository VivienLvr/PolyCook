//
//  StageDetailsView.swift
//  PolyCook
//
//  Created by Vivien Levacher on 04/03/2022.
//

import SwiftUI

struct StageDetailsView: View {
    @State var recipe: Recipe
    @State var stage: Stage
    var recipes: [Recipe]
    @ObservedObject var VM: StageViewModel
    @ObservedObject var recipeVM: RecipeViewModel
    var intent = StageIntent()
    var stages: [Stage]
    
    init(stage: Stage, recipe: Recipe, recipes: [Recipe]) {
        self.stage = stage
        self.recipe = recipe
        self.recipes = recipes
        self.VM = StageViewModel(from: stage)
        self.recipeVM = RecipeViewModel(from: recipe)
        stages = recipe.progression.stages ?? []
        self.intent.addObserver(viewModel: VM, recipeVM: recipeVM)
        
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
            //Spacer()
            LazyVGrid(columns: cols, spacing: 15) {
                Text("Titre de l'étape : ")
                TextField("title", text: $stage.title)
                    .classicTextFieldStyle()
                    .onSubmit {
                        intent.intentToChange(title: stage.title)
                        intent.updateRecipe()
                    }
                /*Text("Auteur : ")
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
                }*/
            }
            //.padding(30)
                            //.font(.custom("", size: 15))
            Spacer().frame(height: 30)
            /*Text("Progression").font(.title)
            List {
                ForEach(stages.indices) { i in
                    Text("\(i+1) - \(stages[i].title) (\(stages[i].duration ?? 5) min)")
                }
            }*/
        }
        .navigationTitle("Détails étape")
        .padding(30)
    }
}

struct StageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StageDetailsView(stage: Stage(id: "", title: "Première étape", duration: 10, description: "", ingredients: [], phase: 1), recipe: Recipe(id: "0", name: "recipe test", covers: 10, category: .other, progression: Progression(stages: [
            Stage(id: "1", title: "stage 1", duration: 10, description: "", ingredients: [], phase: 1)
            , Stage(id: "2", title: "stage 2", duration: 20, description: "", ingredients: [], phase: 2)
        ]))
            , recipes: [])
    }
}
