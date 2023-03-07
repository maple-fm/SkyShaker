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

            Image("sun")
                .resizable()
                .frame(width: 200, height: 200)
                .offset(x: -100, y:-300)
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
                        .animation(Animation.linear(duration: Double.random(in: 14..<15)).repeatForever(autoreverses: true))
                    }

                    Spacer()
                    HStack(alignment: .center) {
                        Spacer()
                        TextField("不満", text: $viewModel.text)
                            .padding(10)
                            .background(Color(UIColor(named: "inputColor")!))
                            .cornerRadius(10)
                            .padding(30)
                            .padding(.leading, 20)
                            .frame(width: 370, height: 50)
                            .offset(x: 0, y:350)

                        Button(action: {
                            viewModel.save()
                        }) {
                            Image("submit")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .offset(x: -80, y: 350)


                    }



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
