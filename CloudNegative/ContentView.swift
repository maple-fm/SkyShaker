//
//  ContentView.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/03.
//

import SwiftUI

struct ContentView: View {

    @State var text: String = ""
    @State private var cloudOffset: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            Color(UIColor(named: "Sky")!)
                .ignoresSafeArea()
            VStack {
                ZStack {

                    ForEach(0..<10) { index in
                        ZStack {
                            Image("cloud")
                                .resizable()
                                .frame(width: 260, height: 100)
                                .foregroundColor(.blue)
                            Text("Cloud")
                        }
                        .offset(x: CGFloat.random(in: -150..<cloudOffset), y: CGFloat.random(in: -100 ..< 5)*CGFloat.random(in: 0 ..< 5))
                        .animation(Animation.linear(duration: Double.random(in: 11..<12)).repeatForever(autoreverses: true))
                    }

                    Spacer()
                    TextField("不満", text: $text)
                        .background(.red)
                        .offset(x: 0, y:350)
                }
            }

            .onAppear {
                self.cloudOffset = 100
            }
            .padding()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
