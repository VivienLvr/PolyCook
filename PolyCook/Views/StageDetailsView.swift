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
    var index: Int
    var recipes: [Recipe]
    @ObservedObject var VM: StageViewModel
    @ObservedObject var listVM: StageListViewModel
    @ObservedObject var recipeVM: RecipeViewModel
    var intent = StageIntent()
    var stages: [Stage]
    var recipeIntent = RecipeIntent()
    
    init(stage: Stage, recipe: Recipe, index: Int, recipes: [Recipe], intent: RecipeIntent) {
        self.stage = stage
        self.recipe = recipe
        self.index = index
        self.recipes = recipes
        stages = recipe.progression.stages// ?? []
        self.VM = StageViewModel(from: stage)
        self.listVM = StageListViewModel(stages)
        self.recipeVM = RecipeViewModel(from: recipe)
        self.recipeIntent = intent
        self.intent.addObserver(viewModel: VM, listVM: listVM)
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
            LazyVGrid(columns: cols, alignment: .leading, spacing: 15) {
                Text("Titre de l'étape : ")
                TextField("title", text: $VM.title)
                    .classicTextFieldStyle()
                    .onSubmit {
                        intent.intentToChange(title: VM.title)
                        listVM.stages[index] = VM.model
                        recipeIntent.intentToChange(stages: listVM.stages)
                        intent.updateList()
                    }
                Text("Durée de l'étape : ")
                HStack {
                    TextField("duration", value: $VM.duration, formatter: formatter)
                        .onSubmit {
                            intent.intentToChange(duration: VM.duration)
                            listVM.stages[index] = VM.model
                            recipeIntent.intentToChange(stages: listVM.stages)
                            intent.updateList()
                        }
                        .frame(width: 45)
                    Text("minutes")
                    Spacer()
                }
                
                
                Text("Description : ")
                TextEditor(text: $VM.description)
                    .classicTextEditorStyle()
                    .onSubmit {
                        intent.intentToChange(description: VM.description)
                        listVM.stages[index] = VM.model
                        recipeIntent.intentToChange(stages: listVM.stages)
                        intent.updateList()
                    }
                    .frame(minHeight: 30)
                   /*
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
                */
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
        ])), index: 1
            , recipes: [], intent: RecipeIntent())
    }
}
