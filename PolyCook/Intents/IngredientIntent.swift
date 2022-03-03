//
//  IngredientIntent.swift
//  PolyCook
//
//  Created by Vivien Levacher on 27/02/2022.
//

import Foundation
import Combine

enum IngredIntentState :  CustomStringConvertible, Equatable {
    case ready
    case nameChanging(String)
    case typeChanging(IngredientType)
    case unitChanging(Unit)
    case priceChanging(Double)
    case stockChanging(Int)
    case isAlergenChanging(Bool)
    
    var description: String{
       switch self {
            case .ready: return "state: .ready"
            case .nameChanging(let name): return "state: .nameChanging(\(name))"
            case .typeChanging(let type): return "state: .typeChanging(\(type))"
            case .unitChanging(let unit): return "state: .unitChanging(\(unit))"
            case .priceChanging(let price): return "state: .priceChanging(\(price))"
            case .stockChanging(let stock): return "state: .stockChanging(\(stock))"
            case .isAlergenChanging(let alergen): return "state: .isAlergenChanging(\(alergen))"
       }
    }
}

enum IngredListIntentState :  Equatable {
    case ready
    case listUpdated
}

struct IngredientIntent {
    private var state = PassthroughSubject<IngredIntentState, Never>()
    private var listState = PassthroughSubject<IngredListIntentState, Never>()
    
    func addObserver(viewModel: IngredientViewModel, listVM: IngredientListViewModel){
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
    
    func intentToChange(category: IngredientType){
        self.state.send(.typeChanging(category))
        //      self.state.send(.ready)
    }
    
    func intentToChange(unit: Unit){
        self.state.send(.unitChanging(unit))
        //      self.state.send(.ready)
    }
    
    func intentToChange(unitPrice: Double){
        self.state.send(.priceChanging(unitPrice))
        //      self.state.send(.ready)
    }
    
    func intentToChange(stock: Int){
        self.state.send(.stockChanging(stock))
        //      self.state.send(.ready)
    }
    
    func intentToChange(isAlergen: Bool){
        self.state.send(.isAlergenChanging(isAlergen))
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
