//
//  ContentView.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    VStack {
                        Text("Bienvenue sur PolyCook")
                            .font(.title).foregroundColor(.white).bold()
                        NavigationLink(
                            destination: IngredientsListView(),
                                    label: {
                                        Text("Accéder aux recettes")
                                            .padding(10)
                                            .background(.white)
                                            .foregroundColor(.black)
                                            .cornerRadius(15)
                                    })
                        Spacer().frame(height: 120)
                            }
                        .padding()
                    }
            }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
