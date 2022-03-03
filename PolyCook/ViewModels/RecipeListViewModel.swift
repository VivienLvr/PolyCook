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

class RecipeListViewModel : ObservableObject, Subscriber {
    private let firestore = Firestore.firestore()
    
    //@Published var listDTO: [IngredientDTO] = []
    @Published var recipes: [Recipe] = []
    
    init(_ recipes: [Recipe]) {
        //self.listDTO = ingredients
        //fetchData()
        /*self.listDTO.forEach({ item in
            self.ingredients.append(Ingredient(id: item.id ?? UUID().uuidString, name: item.name, category: item.category, unit: item.unit,
                                               stock: item.stock, unitPrice: item.unitPrice, isAlergen: item.isAlergen))
        })*/
    }

    
    typealias Input = RecipeListIntentState
    typealias Failure = Never
    
    func fetchData() {
        firestore.collection("recipe").addSnapshotListener {
            (data, error) in
            guard let documents = data?.documents else {
                return // no document
            }
            print("document count", documents.count)
            self.recipes = documents.compactMap{ (doc) ->
                Recipe? in
                let recipe: Recipe? = try? doc.data(as: Recipe.self)
                recipe?.id = doc.documentID
                return recipe
            }
            print(self.recipes.count)
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
    func receive(_ input: RecipeListIntentState) -> Subscribers.Demand {
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
    
    func delete(_ rec : Recipe) {
        if let id = rec.id {
            print(id)
            firestore.collection("recipe").document(id).delete(completion: { err in
                if let err = err { print(err) }
                else {
                    print("recipe deleted")
                    self.objectWillChange.send()
                }
            })
        }
        else { print("element to delete has no id") }
    }
    
    /*func listIngredients() {
        for recipe in recipes {
            print("\(recipe.name), id : \(recipe.id)")
        }
    }*/
    
    func insertRecipe(recipe: Recipe) {
        do {
            let _ = try firestore.collection("recipe").addDocument(from: recipe)
            print("data writen to the DB")
        }
        catch {
            print("erreur dans l'écriture dans la base de données")
        }
    }
}
