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

class IngredientListViewModel : ObservableObject {
    private let firestore = Firestore.firestore()
    
    @Published var listDTO: [IngredientDTO] = []
    @Published var ingredients: [Ingredient] = []
    
    init(_ ingredients: [IngredientDTO]) {
        //self.listDTO = ingredients
        //fetchData()
        /*self.listDTO.forEach({ item in
            self.ingredients.append(Ingredient(id: item.id ?? UUID().uuidString, name: item.name, category: item.category, unit: item.unit,
                                               stock: item.stock, unitPrice: item.unitPrice, isAlergen: item.isAlergen))
        })*/
    }

    
    //typealias Input =
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
                return try? doc.data(as: Ingredient.self)
            }
            print(self.ingredients.count)
        }
    }
    
}
