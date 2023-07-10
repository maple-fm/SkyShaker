//
//  SkyShakerApp.swift
//  SkyShaker
//
//  Created by 出口楓真 on 2023/03/03.
//

import SwiftUI

@main
struct SkyShakerApp: App {
    
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            
            if showSplash {
                ZStack {
                    Color.white
                        .ignoresSafeArea(.all)
                    // スプラッシュ画面を表示
                    SplashView()
                        .background(.white)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showSplash = false // フェードアウトのトリガーとなる変数を変更
                                }
                            }
                        }
                }
                
            } else {
                ContentView()
            }
        }
    }
}
