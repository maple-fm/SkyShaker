//
//  ContentView.swift
//  SkyShaker
//
//  Created by 出口楓真 on 2023/03/03.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    let hasLaunchedKey = "hasLaunched"
    
    @State private var hasLaunchedBefore: Bool =  !UserDefaults.standard.bool(forKey: "hasLaunched")

    var body: some View {
        if hasLaunchedBefore {
            TutrialView()
                .onAppear {
                    UserDefaults.standard.set(true, forKey: hasLaunchedKey)
                    hasLaunchedBefore = true
                }
        } else {
            if colorScheme == .dark {
                CloudView(color: "Night", image: "moon")
            } else {
                CloudView(color: "Sky", image: "sun")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
