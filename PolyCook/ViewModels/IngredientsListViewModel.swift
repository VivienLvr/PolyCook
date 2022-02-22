//
//  IngredientsListViewModel.swift
//  PolyCook
//
//  Created by Vivien Levacher on 22/02/2022.
//

import Foundation
import SwiftUI
import Combine

class IngredientListViewModel : ObservableObject {
    
    
    @Published var ingredients: [Ingredient]
    
    init(_ ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }

    
    //typealias Input =
    typealias Failure = Never
    
}
