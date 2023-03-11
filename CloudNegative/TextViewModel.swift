//
//  TextViewModel.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/07.
//

import Foundation
import SwiftUI

class TextViewModel: ObservableObject {

    @Published var text = ""
    @Published var negatives: [String] = []
    let userDefaults = UserDefaults.standard

    init() {
        get()
    }

    func get() {
        if let array = userDefaults.stringArray(forKey: "negatives") {
            negatives = array
        }
    }

    func save() {
        self.get()

        if text != "" {
            negatives.append(text)
            print(negatives)
        }
        userDefaults.set(negatives, forKey: "negatives")
        text = ""
    }

    func textValidated(_ count: Int) -> Bool {
        count < 6
    }
}
