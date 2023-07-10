//
//  CloudShape.swift
//  SkyShaker
//
//  Created by 出口楓真 on 2023/06/28.
//

import SwiftUI

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


struct CloudShape_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
