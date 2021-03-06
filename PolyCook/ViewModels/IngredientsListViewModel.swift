//
//  IngredientsListViewModel.swift
//  PolyCook
//
//  Created by Vivien Levacher on 22/02/2022.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore

class IngredientListViewModel : ObservableObject, Subscriber {
    private let firestore = Firestore.firestore()
    
    //@Published var listDTO: [IngredientDTO] = []
    @Published var ingredients: [Ingredient] = []
    
    init(_ ingredients: [Ingredient]) {
        //self.listDTO = ingredients
        //fetchData()
        /*self.listDTO.forEach({ item in
            self.ingredients.append(Ingredient(id: item.id ?? UUID().uuidString, name: item.name, category: item.category, unit: item.unit,
                                               stock: item.stock, unitPrice: item.unitPrice, isAlergen: item.isAlergen))
        })*/
    }

    
    typealias Input = IngredListIntentState
    typealias Failure = Never
    
    func fetchData() {
        firestore.collection("ingredient").addSnapshotListener {
            (data, error) in
            guard let documents = data?.documents else {
                return // no document
            }
            print("document count", documents.count)
            self.ingredients = documents.compactMap{ (doc) ->
                Ingredient? in
                let ingred: Ingredient? = try? doc.data(as: Ingredient.self)
                ingred?.id = doc.documentID
                return ingred
            }
            print(self.ingredients.count)
        }
        
    }
    
    func receive(subscription: Subscription) {
       subscription.request(.unlimited) // unlimited : on veut recevoir toutes les valeurs
    }
    
    // au cas où le publisher déclare qu'il finit d'émetter : nous concerne pas
    func receive(completion: Subscribers.Completion<Never>) {
       return
    }

     // Activée à chaque send() du publisher :
    func receive(_ input: IngredListIntentState) -> Subscribers.Demand {
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
    
    func delete(_ ingred : Ingredient) {
        if let id = ingred.id {
            print(id)
            firestore.collection("ingredient").document(id).delete(completion: { err in
                if let err = err { print(err) }
                else {
                    print("ingredient deleted")
                    self.objectWillChange.send()
                }
            })
        }
        else { print("element to delete has no id") }
    }
    
    func listIngredients() {
        for ingred in ingredients {
            print("\(ingred.name), id : \(ingred.id)")
        }
    }
    
    func insertIngredient(ingredient: Ingredient) {
        do {
            let _ = try firestore.collection("ingredient").addDocument(from: ingredient)
            print("data writen to the DB")
        }
        catch {
            print("erreur dans l'écriture dans la base de données")
        }
    }
}
