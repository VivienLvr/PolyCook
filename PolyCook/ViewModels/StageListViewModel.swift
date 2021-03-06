//
//  StageListViewModel.swift
//  PolyCook
//
//  Created by Vivien Levacher on 05/03/2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class StageListViewModel : ObservableObject, Subscriber {
    private let firestore = Firestore.firestore()
    
    //@Published var listDTO: [IngredientDTO] = []
    @Published var stages: [Stage] = []
    
    init(_ stages: [Stage]) {
        //self.listDTO = ingredients
        //fetchData()
        /*self.listDTO.forEach({ item in
            self.ingredients.append(Ingredient(id: item.id ?? UUID().uuidString, name: item.name, category: item.category, unit: item.unit,
                                               stock: item.stock, unitPrice: item.unitPrice, isAlergen: item.isAlergen))
        })*/
        self.stages = stages
    }

    
    typealias Input = StageListIntentState
    typealias Failure = Never
    
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: StageListIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .listUpdated:
            self.objectWillChange.send()
            print("sent objectWillChange")
            break
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
}
