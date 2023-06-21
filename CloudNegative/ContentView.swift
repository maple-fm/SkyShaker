//
//  ContentView.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/03.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataController = DataController()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if colorScheme == .dark {
            DarkModeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        } else {
            LightModeView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LightModeView()
    }
}
