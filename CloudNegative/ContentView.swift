//
//  ContentView.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/03.
//

import SwiftUI

struct ContentView: View {

    @FetchRequest(sortDescriptors: []) var clouds: FetchedResults<Cloud>
    @StateObject private var viewModel = TextViewModel()
    @State private var cloudOffset: CGFloat = UIScreen.main.bounds.width
    @State var opacity: CGFloat = 0

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
                        if self.opacity < 100 {
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
                                                   return CGFloat(negative.count) * 6
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
                            .offset(x: CGFloat.random(in: -cloudOffset..<cloudOffset), y: CGFloat(Int.random(in: -100 ..< 50))*CGFloat(Int.random(in: 0 ..< 5)))
                            .animation(.linear(duration: Double.random(in: 20..<21)).repeatForever(autoreverses: true))
                            .opacity(Double(1-opacity/100))
                        }

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
            .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
                print("シェイクしたよ")
                opacity += 2
                print(opacity)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension NSNotification.Name {
    public static let deviceDidShakeNotification = NSNotification.Name("DeviceDidShakeNotification")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter.default.post(name: .deviceDidShakeNotification, object: event)
    }
}
