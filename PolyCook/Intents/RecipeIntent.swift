//
//  RecipeIntent.swift
//  PolyCook
//
//  Created by Vivien Levacher on 02/03/2022.
//

import Foundation
import Combine

enum RecipeIntentState :  CustomStringConvertible {
    case ready
    case nameChanging(String)
    case authorChanging(String)
    case coversChanging(Int)
    case priceCoefChanging(Double)
    case categoryChanging(RecipeType)
    case progressionChanging(Progression)
    
    var description: String{
       switch self {
            case .ready: return "state: .ready"
            case .nameChanging(let name): return "state: .nameChanging(\(name))"
            case .authorChanging(let author): return "state: .authorChanging(\(author))"
            case .coversChanging(let covers): return "state: .coversChanging(\(covers))"
            case .priceCoefChanging(let coef): return "state: .priceCoefChanging(\(coef))"
            case .categoryChanging(let category): return "state: .categoryChanging(\(category))"
            case .progressionChanging(let prog): return "state: .progressionChanging(\(prog))"
       }
    }
}

enum RecipeListIntentState :  Equatable {
    case ready
    case listUpdated
}

struct RecipeIntent {
    private var state = PassthroughSubject<RecipeIntentState, Never>()
    private var listState = PassthroughSubject<RecipeListIntentState, Never>()
    
    func addObserver(viewModel: RecipeViewModel, listVM: RecipeListViewModel){
        // reçoit VM qui veut être au courant des actions demandées (Intent)
        // ce VM souscrit aux publications (modifications) de l'état
        self.state.subscribe(viewModel)
        self.listState.subscribe(listVM)
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
