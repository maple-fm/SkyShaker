//
//  CloudView.swift
//  SkyShaker
//
//  Created by 出口楓真 on 2023/06/21.
//

import SwiftUI
import KeyboardObserving

struct CloudView: View {

    @State private var textFieldInput = ""
    @StateObject private var viewModel = CloudViewModel()
    @State private var cloudOffset: CGFloat = UIScreen.main.bounds.width
    @State private var ScreenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var cloudOpacity: Double = 0.0
    @State private var isPopupPresented = false
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
            
            Button(action: {
                isPopupPresented = true
            }) {
                Image(backgroundImage)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            .position(x: 100, y:80)
            VStack {
                ZStack {
                    ForEach(viewModel.clouds, id: \.self) { cloud in
                        CloudShape(viewModel: viewModel, negative: cloud.content)
                            .offset(x: CGFloat.random(in: -cloudOffset..<cloudOffset), y: CGFloat(Int.random(in: -100 ..< 50))*CGFloat(Int.random(in: 0 ..< 5)))
                            .animation(.linear(duration: Double.random(in: 20..<21)).repeatForever(autoreverses: true))
                            .opacity(1-cloud.opacity/10)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        ZStack(alignment: .leading) {
                            if textFieldInput.isEmpty {
                                Text("不満")
                                    .foregroundColor(.gray)
                            }
                            
                            TextField("", text: $textFieldInput)
                                .foregroundColor(.black)
                            
                            
                        }
                        .padding(.trailing, 35)
                        .padding(10)
                        .background(Color(UIColor(named: "inputColor")!))
                        .cornerRadius(10)
                        .padding(30)

                        .frame(width: 370, height: 50)
                        
                        
                        Button(action: {
                            viewModel.saveCloud(content: textFieldInput, opacity: 0)
                            textFieldInput = ""
                        }) {
                            Image("submit")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                                
                        }
                        .offset(x: -80)
                        
                    }
                    .offset(y: ScreenHeight / 3 + 70)
                    .padding(.bottom, 50)
                    .keyboardObserving()
              }
            }
            .onAppear {
                self.cloudOffset = 200
            }
            .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
                cloudOpacity += 0.2
                viewModel.updateCloudOpacity(newOpacity: cloudOpacity)
                cloudOpacity = 0
            }
        }
        .overlay(
            ZStack {
                if isPopupPresented {
                    SettingPopup(isPresented: $isPopupPresented)
                        .transition(.move(edge: .bottom))
                }
            }
        )
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
}

struct CloudView_Previews: PreviewProvider {
    static var previews: some View {
        CloudView(color: "Sky", image: "sun")
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

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
