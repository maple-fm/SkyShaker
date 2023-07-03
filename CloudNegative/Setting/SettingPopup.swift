//
//  SettingPopup.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/06/24.
//

import SwiftUI

struct SettingPopup: View {
    @Binding var isPresented: Bool
    @State private var currentPage = 0 // 現在のページを保持する状態変数
    let pages: [AnyView] = [AnyView(Privacy()), AnyView(Feedback()), AnyView(Tutrial())] // 表示するページの配列
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        pages[index]
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .animation(.easeInOut) // ページ切り替え時のアニメーションを追加
                .frame(width: 400, height: 350)

                
                HStack {
                    ForEach(0..<pages.count) { index in
                        Circle()
                            .foregroundColor(currentPage == index ? .blue : .gray) // 現在のページに応じて色を変更
                            .frame(width: 10, height: 10)
                    }
                   
                }
                .padding(.vertical, 20)
                
            }
//            .frame(width: 300, height: 300)
        }
        .onAppear {
            currentPage = 0 // ポップアップが表示された時に現在のページをリセットする
        }
    }
}

struct SettingPopup_Previews: PreviewProvider {
    static var previews: some View {
        let bool = Binding.constant(true)
        return SettingPopup(isPresented: bool)
    }
}
