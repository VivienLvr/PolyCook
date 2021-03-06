//
//  Recipe.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation
import FirebaseFirestoreSwift

class Recipe: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name : String {
        didSet {
            self.observer?.change(name: self.name)
        }
    }
    var author : String {
        didSet {
            self.observer?.change(author: self.author)
        }
    }
    var covers : Int {
        didSet {
            self.observer?.change(covers: self.covers)
        }
    }
    var priceCoef : Double {
        didSet {
            self.observer?.change(priceCoef: self.priceCoef)
        }
    }
    var category : RecipeType {
        didSet {
            self.observer?.change(category: self.category)
        }
    }
    var progression : Progression {
        didSet {
            self.observer?.change(progression: self.progression)
        }
    }
    
    init(id: String, name: String, author: String = "unknown", covers: Int = 0, priceCoef: Double = 0, category: RecipeType, progression: Progression = Progression(stages: [])) {
        self.id = id
        self.name = name
        self.author = author
        self.covers = covers
        self.priceCoef = priceCoef
        self.category = category
        self.progression = progression
    }
    
    var observer: RecipeOberver?
    
    enum CodingKeys: String, CodingKey{
        //case id = "id"
        case name = "name"
        case author = "author"
        case covers = "covers"
        case priceCoef = "priceCoef"
        case category = "category"
        case progression = "progression"
    }
}

enum RecipeType: String, Codable, CaseIterable {
    case cake = "Gateau"
    case sauce = "Sauce"
    case other = "Autre"
    case pizza = "Pizza"
}

protocol RecipeOberver {
    func change(name: String)
    func change(author: String)
    func change(covers: Int)
    func change(priceCoef: Double)
    func change(category: RecipeType)
    func change(progression: Progression)
}
