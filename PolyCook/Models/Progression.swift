//
//  Progression.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import Foundation

class Progression: Codable {
    var stages : [StageDescription]
    
    init(stages: [StageDescription]) {
        self.stages = stages
    }
}
