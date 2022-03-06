//
//  RecipeViewModel.swift
//  PolyCook
//
//  Created by Vivien Levacher on 02/03/2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class RecipeViewModel: ObservableObject, Subscriber, RecipeOberver {
    var model: Recipe
    
    private let firestore = Firestore.firestore()
    
    @Published var id: String
    @Published var name: String
    @Published var author: String
    @Published var covers : Int
    @Published var priceCoef : Double
    @Published var category: RecipeType
    @Published var progression : Progression

    
    init(from recipe: Recipe) {
        self.model = recipe
        self.id = model.id ?? "default id"
        self.name = model.name
        self.category = model.category
        self.author = model.author //?? Unit.piece
        self.covers = model.covers //?? 0
        self.priceCoef = model.priceCoef
        self.progression = model.progression// ?? Progression(stages: [])
        self.model.observer = self
    }
    
    typealias Input = RecipeIntentState
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
    func receive(_ input: RecipeIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .nameChanging(let name):
            self.model.name = name
            print("vm: model name changed to '\(self.model.name)'")
            //writeData()
        case .authorChanging(let author):
            self.model.author = author
            print("vm: model author changed to '\(self.model.author)'")
            //writeData()
        case .coversChanging(let covers):
            self.model.covers = covers
            print("vm: model covers changed to '\(self.model.covers)'")
            //writeData()
        case .priceCoefChanging(let priceCoef):
            self.model.priceCoef = priceCoef
            print("vm: model priceCoef changed to '\(self.model.priceCoef)'")
            //writeData()
        case .categoryChanging(let category):
            self.model.category = category
            print("vm: model category changed to '\(self.model.category)'")
            //writeData()
        case .progressionChanging:
            self.objectWillChange.send()
            //self.model.progression = progression
            print("vm: model progression changed to '\(self.progression)'")
            //writeData()
        
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    func change(name: String) {
        self.name = name
    }
    
    func change(category: RecipeType) {
        self.category = category
    }
    
    func change(author: String) {
        self.author = author
    }
    
    func change(covers: Int) {
        self.covers = covers
    }
    
    func change(priceCoef: Double) {
        self.priceCoef = priceCoef
    }
    
    func change(progression: Progression) {
        self.progression = progression
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
