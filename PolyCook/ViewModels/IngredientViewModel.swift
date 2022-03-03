//
//  IngredientViewModel.swift
//  PolyCook
//
//  Created by Vivien Levacher on 23/02/2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class IngredientViewModel: ObservableObject, Subscriber, IngredientObserver {
    var model: Ingredient
    
    private let firestore = Firestore.firestore()
    
    @Published var id: String
    @Published var name: String
    @Published var category: IngredientType
    @Published var unit: Unit
    @Published var stock : Int
    @Published var unitPrice : Double
    @Published var isAlergen : Bool
    
    init(from ingredient: Ingredient) {
        self.model = ingredient
        self.id = model.id ?? "default id"
        self.name = model.name
        self.category = model.category //?? IngredientType.autre
        self.unit = model.unit //?? Unit.piece
        self.stock = model.stock //?? 0
        self.unitPrice = model.unitPrice
        self.isAlergen = model.isAlergen
        self.model.observer = self
    }
    
    typealias Input = IngredIntentState
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
    func receive(_ input: IngredIntentState) -> Subscribers.Demand {
       print("vm -> intent \(input)")
        switch input {
        case .ready:
            break
        case .nameChanging(let name):
            self.model.name = name
            print("vm: model name changed to '\(self.model.name)'")
            writeData()
        case .typeChanging(let type):
            self.model.category = type
            print("vm: model category changed to '\(self.model.category)'")
            writeData()
        case .unitChanging(let unit):
            self.model.unit = unit
            print("vm: model unit changed to '\(self.model.unit)'")
            writeData()
        case .priceChanging(let price):
            self.model.unitPrice = price
            print("vm: model price changed to '\(self.model.unitPrice)'")
            writeData()
        case .stockChanging(let stock):
            self.model.stock = stock
            print("vm: model stock changed to '\(self.model.stock)'")
            writeData()
        case .isAlergenChanging(let alergen):
            self.model.isAlergen = alergen
            print("vm: model isAlergen changed to '\(self.model.isAlergen)'")
            writeData()
       }
       return .none // on arrête de traiter cette demande et on attend un nouveau send
    }
    
    func change(name: String) {
        self.name = name
    }
    
    func change(category: IngredientType) {
        self.category = category
    }
    
    func change(unit: Unit) {
        self.unit = unit
    }
    
    func change(unitPrice: Double) {
        self.unitPrice = unitPrice
    }
    
    func change(stock: Int) {
        self.stock = stock
    }
    
    func change(isAlergen: Bool) {
        self.isAlergen = isAlergen
    }
    
    func writeData() {
        do {
            let _ = try firestore.collection("ingredient").document(self.model.id!).setData(from: self.model)
            print("data writen to the DB")
        }
        catch {
            print("erreur dans l'écriture dans la base de données")
        }
    }
    
}
