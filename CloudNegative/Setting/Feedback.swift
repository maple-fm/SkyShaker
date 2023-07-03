//
//  Feedback.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/06/28.
//

import SwiftUI

struct Feedback: View {
    var body: some View {
        VStack {
            Button(action: {},
                   label: {
                VStack {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.black)
                    
                    Text("フィードバック")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                }
            })
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
        .background(Color.white)
        .cornerRadius(10)
        .transition(.move(edge: .trailing)) // スワイプ時のアニメーションを追加
    }
}

struct Feedback_Previews: PreviewProvider {
    static var previews: some View {
        Feedback()
    }
}
