//
//  Privacy.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/06/28.
//

import SwiftUI

struct Privacy: View {
    
    @State private var showModal = false
    
    var body: some View {
        VStack {
            Button(action: {
                showModal = true
            },
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
        .sheet(isPresented: $showModal, content: {
            VStack {
                WebView(url: URL(string: "https://maple-fm.github.io/maple-apps/skyShaker/privacy.html")!)
            }
            .presentationDetents([.medium])
        })
    }
}

struct Privacy_Previews: PreviewProvider {
    static var previews: some View {
        Privacy()
    }
}
