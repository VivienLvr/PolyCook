//
//  ContentView.swift
//  PolyCook
//
//  Created by Vivien Levacher on 17/02/2022.
//

import SwiftUI

struct HomePageView: View {
  var body: some View {
    NavigationView {
        ZStack {
            Image("background")
                VStack {
                    Text("Bienvenue sur PolyCook")
                        .font(.title).foregroundColor(.white).bold()
                        }
                    .padding()
                }
    }
  }
}

struct HomePage: View {
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .white
    }
    var body: some View {
      TabView {
          HomePageView()
              .tabItem {
                  Image(systemName:"house")
                  Text("Home").font(.title)
          }
          IngredientsListView()
              .tabItem {
                  Image(systemName:"drop")
                  Text("Ingredients")
          }
          RecipesListView()
              .tabItem {
                  Image(systemName:"cart")
                  Text("Recipes")
          }
      }

    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
