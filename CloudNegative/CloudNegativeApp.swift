//
//  CloudNegativeApp.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/03.
//

import SwiftUI

@main
struct CloudNegativeApp: App {
    
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            
            if showSplash {
                // スプラッシュ画面を表示
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showSplash = false // フェードアウトのトリガーとなる変数を変更
                            }
                        }
                    }

            } else {
                ContentView()
            }
        }
    }
}
