//
//  Progression.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation

class Progression: Codable {
    var duration: Int
        /*var sum = 0
        guard let stages = stages else {
            return sum
        }
        for stage in stages {
            if let duration = stage.duration {
                sum += duration
            }
        }
        return sum
    }*/
    
    var stages: [Stage] = []
    
    init(duration: Int = 10, stages: [Stage]) {
        self.duration = duration
        self.stages = stages
    }
    
    required init(from decoder: Decoder) throws {
        print("decoding progression")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        duration = try container.decode(Int.self, forKey: .duration)
        var stagesContainer = try container.nestedUnkeyedContainer(forKey: .stages)
        while !stagesContainer.isAtEnd {
            self.stages.append(try stagesContainer.decode(Stage.self))
        }
        print("\(stages.count) stages decoded")
    }
    
    private enum CodingKeys: String, CodingKey { case duration = "duration"; case stages = "stages" }
}
