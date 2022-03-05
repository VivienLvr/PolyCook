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
    private var state = PassthroughSubject<StageIntentState, Never>()
    private var stateRecipe = PassthroughSubject<RecipeIntentState, Never>()
    
    func addObserver(viewModel: StageViewModel, recipeVM: RecipeViewModel){
        // reçoit VM qui veut être au courant des actions demandées (Intent)
        // ce VM souscrit aux publications (modifications) de l'état
        self.state.subscribe(viewModel)
        self.stateRecipe.subscribe(recipeVM)
    }
    
    func intentToChange(name: String){
        // Fait deux choses en 1 instruction (cf specif Combine) :
        //  1) change la valeur (car on un CurrentVal... doit mémoriser la valeur en cours)
        // 2) avertit les subscriber que l'état a changé
        print("intentToChange name")
        self.state.send(.nameChanging(name))
        //      self.state.send(.ready)
    }
    
    func intentToChange(author: String){
        self.state.send(.authorChanging(author))
        //      self.state.send(.ready)
    }
    
    func intentToChange(covers: Int){
        self.state.send(.coversChanging(covers))
        //      self.state.send(.ready)
    }
    
    func intentToChange(priceCoef: Double){
        self.state.send(.priceCoefChanging(priceCoef))
        //      self.state.send(.ready)
    }
    
    func intentToChange(category: RecipeType){
        self.state.send(.categoryChanging(category))
        //      self.state.send(.ready)
    }
    
    func intentToChange(progression: Progression){
        self.state.send(.progressionChanging(progression))
        //      self.state.send(.ready)
    }
    
    
    
    func updateList() {
        print("updateList()")
        self.listState.send(.listUpdated)
    }
    
    func beReady() {
        self.listState.send(.ready)
    }
}
