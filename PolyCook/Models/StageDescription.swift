//
//  StageDescription.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation

/*struct StageDescription : Codable {
    var title: String
}*/

/*class StageDescription: Stage {
    var description: String?
    var phase : Int?
    
    init(id: String, title: String, duration: Int, ingredients: [QuantityIngredient], description: String, phase: Int?) {
        self.description = description
        self.phase = phase
        super.init(id: id, title: title, duration: duration, ingredients: ingredients)
    }
    
    required init(from decoder: Decoder) throws {
        print("decoding stage description")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decode(String.self, forKey: .description)
        print("description = \(description)")
        // Get superDecoder for superclass and call super.init(from:) with it
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(description, forKey: .description)
    }
    
    private enum CodingKeys: String, CodingKey {
        case description = "description"
        //case phase = "phase"
    }
}*/
