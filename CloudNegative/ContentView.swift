//
//  ContentView.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/03.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = TextViewModel()
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

                    ForEach(viewModel.negatives, id: \.self) { negative in
                        ZStack {
                            Image("cloud")
                                .resizable()
                                .frame(
                                    width: { () -> CGFloat in
                                        if viewModel.textValidated(negative.count) {
                                            return 100
                                        } else if negative.count > 20 {
                                            return CGFloat(negative.count) * 10
                                        } else {
                                            return CGFloat(negative.count) * 25
                                        }
                                    }(),
                                   height: { () -> CGFloat in
                                           if viewModel.textValidated(negative.count) {
                                               return 80
                                           } else if negative.count > 20 {
                                               return CGFloat(negative.count) * 8
                                           } else {
                                               return CGFloat(negative.count) * 10
                                           }
                                       }())
                            Text(negative)
                                .frame(width: { () -> CGFloat in
                                    if viewModel.textValidated(negative.count) {
                                        return 80
                                    } else if negative.count > 20 {
                                        return CGFloat(negative.count) * 5
                                    } else {
                                        return CGFloat(negative.count) * 10
                                    }
                                }())

                        }
                        .offset(x: CGFloat.random(in: -200..<cloudOffset), y: CGFloat(Int.random(in: -100 ..< 50))*CGFloat(Int.random(in: 0 ..< 5)))
                        .animation(.linear(duration: Double.random(in: 20..<21)).repeatForever(autoreverses: true))
                    }

                    Spacer()
                    HStack {
                        TextField("不満", text: $viewModel.text)
                            .padding(.trailing, 35)
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
                self.cloudOffset = 200
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
