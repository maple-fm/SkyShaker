//
//  TutrialView.swift
//  SkyShaker
//
//  Created by 出口楓真 on 2023/07/03.
//

import SwiftUI

struct TutrialView: View {
    let tutorialPages = [
        TutorialPage(page: 1, totalPages: 3, imageName: "page1"),
        TutorialPage(page: 2, totalPages: 3, imageName: "page2"),
        TutorialPage(page: 3, totalPages: 3, imageName: "page3"),
        TutorialPage(page: 4, totalPages: 4, imageName: "page4"),
    ]
    
    @State private var currentPage = 0
    @State private var showContentView = false
    
    var body: some View {
        ZStack {
            VStack {
                tutorialPages[currentPage]
                    .transition(.scale)
                
                HStack(alignment: .center) {
                    
                    if currentPage > 0 {
                        Button(action: {
                            withAnimation {
                                currentPage -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                            
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    // ページング用のサークル
                    HStack {
                        ForEach(0..<tutorialPages.count) { index in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(index == currentPage ? .blue : .gray)
                        }
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                    
                    if currentPage < tutorialPages.count - 1 {
                        Button(action: {
                            withAnimation {
                                currentPage += 1
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.title)
                                .padding()
                        }
                    } else {
                        Button(action: {
                            showContentView.toggle()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .padding()
                        }
                    }
                    
                }
            }
            .padding()
            
            if showContentView {
                ContentView()
            }
        }
        
    }
}

struct TutrialView_Previews: PreviewProvider {
    static var previews: some View {
        TutrialView()
    }
}


struct TutorialPage: View {
    let page: Int
    let totalPages: Int
    let imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-100, alignment: .top)
        }
    }
}
