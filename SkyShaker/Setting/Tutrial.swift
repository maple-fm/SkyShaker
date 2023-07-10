//
//  Tutrial.swift
//  SkyShaker
//
//  Created by 出口楓真 on 2023/07/03.
//

import SwiftUI

struct Tutrial: View {
    
    @State var showTutrial: Bool = false
    var body: some View {
        VStack {
            Button (
                action: {
                    showTutrial.toggle()
                },
                label: {
                    VStack {
                        
                        Image(systemName: "book")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.black)
                        
                        Text("使い方")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                        
                    }
                }
           )
            
            if showTutrial {
                TutrialView()
            }

            
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
        .background(Color.white)
        .cornerRadius(10)
        .transition(.move(edge: .trailing)) // スワイプ時のアニメーションを追加
        .fullScreenCover(isPresented: $showTutrial, content: TutrialView.init)
    }
}

//
//#Preview {
//    Tutrial()
//}
