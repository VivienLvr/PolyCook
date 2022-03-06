//
//  StageIntent.swift
//  PolyCook
//
//  Created by Vivien Levacher on 05/03/2022.
//

import Foundation
import Combine

enum StageIntentState :  CustomStringConvertible {
    case ready
    case titleChanging(String)
    case descriptionChanging(String)
    case durationChanging(Int)
    case phaseChanging(Int)
    case ingredientsChanging([QuantityIngredient])
    
    var description: String{
       switch self {
            case .ready: return "state: .ready"
            case .titleChanging(let title): return "state: .titleChanging(\(title))"
            case .descriptionChanging(let descr): return "state: .descriptionChanging(\(descr))"
            case .durationChanging(let duration): return "state: .coversChanging(\(duration))"
            case .phaseChanging(let phase): return "state: .priceCoefChanging(\(phase))"
            case .ingredientsChanging(let ingred): return "state : .ingredientsChanging(\(ingred))"
       }
    }
}


struct StageIntent {
    //var recipeVM: RecipeViewModel
    private var state = PassthroughSubject<StageIntentState, Never>()
    private var stateRecipe = PassthroughSubject<RecipeIntentState, Never>()
    
    func addObserver(viewModel: StageViewModel, recipeVM: RecipeViewModel){
        // reçoit VM qui veut être au courant des actions demandées (Intent)
        // ce VM souscrit aux publications (modifications) de l'état
        self.state.subscribe(viewModel)
        self.stateRecipe.subscribe(recipeVM)
        //self.recipeVM = recipeVM
    }
    
    func intentToChange(title: String){
        // Fait deux choses en 1 instruction (cf specif Combine) :
        //  1) change la valeur (car on un CurrentVal... doit mémoriser la valeur en cours)
        // 2) avertit les subscriber que l'état a changé
        print("intentToChange title")
        self.state.send(.titleChanging(title))
        //      self.state.send(.ready)
    }
    
    func intentToChange(description: String){
        self.state.send(.descriptionChanging(description))
        //      self.state.send(.ready)
    }
    
    func intentToChange(duration: Int){
        self.state.send(.durationChanging(duration))
        //      self.state.send(.ready)
    }
    
    func intentToChange(phase: Int){
        self.state.send(.phaseChanging(phase))
        //      self.state.send(.ready)
    }
    
    func intentToChange(ingredients: [QuantityIngredient]){
        self.state.send(.ingredientsChanging(ingredients))
        //      self.state.send(.ready)
    }
    
    func updateRecipe() {
        print("updateRecipe()")
        self.stateRecipe.send(.progressionChanging)
    }
    
    /*func beReady() {
        self.listState.send(.ready)
    }*/
}
