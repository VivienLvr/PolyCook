//
//  PolyCookApp.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI
import Firebase

@main
struct PolyCookApp: App {
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
    
    init() {
        FirebaseApp.configure()
    }
}
