//
//  CloudView.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/06/21.
//

import SwiftUI

struct CloudView: View {

    @State private var textFieldInput = ""
    @StateObject private var viewModel = CloudViewModel()
    @State private var cloudOffset: CGFloat = UIScreen.main.bounds.width
    @State private var cloudOpacity: Double = 0.0
    var backgroundColor: String
    var backgroundImage: String
    
    init(color backgroundColor: String, image backgroundImage: String) {
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }

    var body: some View {
        ZStack {
            Color(UIColor(named: backgroundColor)!)
                .ignoresSafeArea()

            Image(backgroundImage)
                .resizable()
                .frame(width: 200, height: 200)
                .offset(x: -100, y:-300)

            VStack {
                ZStack {
                    ForEach(viewModel.clouds, id: \.self) { cloud in
                        CloudShape(viewModel: viewModel, negative: cloud.content)
                            .offset(x: CGFloat.random(in: -cloudOffset..<cloudOffset), y: CGFloat(Int.random(in: -100 ..< 50))*CGFloat(Int.random(in: 0 ..< 5)))
                            .animation(.linear(duration: Double.random(in: 20..<21)).repeatForever(autoreverses: true))
                            .opacity(1-cloud.opacity/10)
                            .onAppear {
                                withAnimation(.linear(duration: Double.random(in: 20..<21)).repeatForever(autoreverses: true), {})

                            }
                                

                    }
                    

                    Spacer()
                    HStack {
                        TextField("不満", text: $textFieldInput)
                            .padding(.trailing, 35)
                            .padding(10)
                            .background(Color(UIColor(named: "inputColor")!))
                            .cornerRadius(10)
                            .padding(30)
                            .padding(.leading, 20)
                            .frame(width: 370, height: 50)
                            .offset(x: 0, y:350)

                        Button(action: {
                            viewModel.saveCloud(content: textFieldInput, opacity: 0)
                            textFieldInput = ""
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
                cloudOpacity += 0.2
                print(cloudOpacity)
                viewModel.updateCloudOpacity(newOpacity: cloudOpacity)
                cloudOpacity = 0
            }
        }

    }
}

struct CloudView_Previews: PreviewProvider {
    static var previews: some View {
        CloudView(color: "Sky", image: "sun")
    }
}

struct CloudShape: View {
    var viewModel: CloudViewModel
    let negative: String
    
    var body: some View {
        ZStack {
            Image("cloud")
                .resizable()
                .frame(width: cloudWidth, height: cloudHeight)
            
            Text(negative)
                .foregroundColor(.black)
                .frame(width: textWidth)
        }
    }

    private var cloudWidth: CGFloat {
        if viewModel.textValidated(negative.count) {
            return 100
        } else if negative.count > 20 {
            return CGFloat(negative.count) * 10
        } else {
            return CGFloat(negative.count) * 25
        }
    }
    
    private var cloudHeight: CGFloat {
        if viewModel.textValidated(negative.count) {
            return 80
        } else if negative.count > 20 {
            return CGFloat(negative.count) * 6
        } else {
            return CGFloat(negative.count) * 10
        }
    }

    private var textWidth: CGFloat {
        if viewModel.textValidated(negative.count) {
            return 80
        } else if negative.count > 20 {
            return CGFloat(negative.count) * 5
        } else {
            return CGFloat(negative.count) * 10
        }
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
