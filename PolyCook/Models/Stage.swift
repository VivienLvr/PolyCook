//
//  Stage.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation
import FirebaseFirestoreSwift

class Stage: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var duration: Int?
    var description: String?
    var ingredients: [QuantityIngredient]?
    
    init(id: String, title: String, duration: Int, description: String = "", ingredients: [QuantityIngredient]?) {
        self.id = id
        self.title = title
        self.duration = duration
        self.description = description
        self.ingredients = ingredients
    }
    
    
    /*required init(from decoder: Decoder) throws {
        print("decoding stage")
        
        do {
            let container = try decoder.container(keyedBy: Stage.CodingKeys.self)
            do {
                self.title = try container.decode(String.self, forKey: .title)
            } catch { print("error while decoding title") }
            //print("title : \(self.title)")
            do {
                self.duration = try container.decode(Int.self, forKey: .duration)
            } catch { print("error while decoding duration") }
            //print("duration : \(self.duration)")
            ingredients = []
            /*do {
                ingredients = try container.decode([QuantityIngredient].self, forKey: .ingredients)
            } catch { print("erreur ingredients") }
            print("\(self.title), \(ingredients?.count)")*/
        } catch { print("error container") }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(duration, forKey: .duration)
        //try container.encode(ingredients, forKey: .ingredients)
    }*/
    
    private enum CodingKeys: String, CodingKey {
        case title
        case duration
        case description
        //case ingredients
    }
}

struct QuantityIngredient: Codable {
    var quantity: Int
    var ingredient: Ingredient
}
