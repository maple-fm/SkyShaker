//
//  Privacy.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/06/28.
//

import SwiftUI

struct Privacy: View {
    var body: some View {
        VStack {
            Button(action: {},
            label: {
                VStack {
                    Image(systemName: "shield")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.black)
                    
                    Text("プライバシーポリシー")
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

struct Privacy_Previews: PreviewProvider {
    static var previews: some View {
        Privacy()
    }
}
