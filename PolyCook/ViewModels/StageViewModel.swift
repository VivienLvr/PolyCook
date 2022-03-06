//
//  StageViewModel.swift
//  PolyCook
//
//  Created by Vivien Levacher on 06/03/2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class StageViewModel: ObservableObject, Subscriber, StageOberver {
    var model: Stage
    
    private let firestore = Firestore.firestore()
    
    @Published var id: String
    @Published var title: String
    @Published var duration: Int
    @Published var description : String
    @Published var ingredients: [QuantityIngredient]?
    @Published var phase: Int

    
    init(from stage: Stage) {
        self.model = stage
        self.id = model.id ?? "default id"
        self.title = model.title
        self.duration = model.duration
        self.description = model.description
        self.ingredients = model.ingredients
        self.phase = model.phase
        self.model.observer = self
    }
    
    typealias Input = StageIntentState
    typealias Failure = Never
    
    // appelée à l'inscription
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: StageIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .titleChanging(let title):
            self.model.title = title
            print("vm: model title changed to '\(self.model.title)'")
            //writeData()
        case .descriptionChanging(let description):
            self.model.description = description
            print("vm: model description changed to '\(self.model.description)'")
            //writeData()
        case .durationChanging(let duration):
            self.model.duration = duration
            print("vm: model duration changed to '\(self.model.duration)'")
            //writeData()
        case .ingredientsChanging(let ingredients):
            self.model.ingredients = ingredients
            print("vm: model ingredients changed to '\(String(describing: self.model.ingredients))'")
            //writeData()
        case .phaseChanging(let phase):
            self.model.phase = phase
            print("vm: model phase changed to '\(self.model.phase)'")
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    func change(title: String) {
        self.title = title
    }
    
    func change(description: String) {
        self.description = description
    }
    
    func change(duration: Int) {
        self.duration = duration
    }
    
    func change(phase: Int) {
        self.phase = phase
    }
    
    func change(ingredients: [QuantityIngredient]) {
        self.ingredients = ingredients
    }
    
    func writeData() {
        do {
            let _ = try firestore.collection("recipe").document(self.model.id!).setData(from: self.model)
            print("data writen to the DB")
        }
        catch {
            print("erreur dans l'écriture dans la base de données")
        }
    }
    
}
