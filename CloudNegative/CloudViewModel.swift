//
//  TextViewModel.swift
//  CloudNegative
//
//  Created by 出口楓真 on 2023/03/07.
//

import Foundation
import SwiftUI
import CoreData

class CloudViewModel: ObservableObject {

    @Published var clouds: [Cloud] = []
    private let persistentContainer: NSPersistentContainer
        
    init() {
        persistentContainer = NSPersistentContainer(name: "Cloud")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        
        self.fetchClouds()

    }

    func saveCloud(content: String, opacity: Double) {
        let context = persistentContainer.viewContext
        
        let cloud = Cloud(context: context)
        cloud.id = UUID().uuidString
        cloud.content = content
        cloud.opacity = opacity
        cloud.createdDate = Date.now
        
        do {
            try context.save()
            self.fetchClouds()
        } catch {
            fatalError("Failed to save context: \(error)")
        }
    }
    
    func fetchClouds() {
        let request: NSFetchRequest<Cloud> = Cloud.fetchRequest()
        
        let predicate = NSPredicate(format: "opacity < 100")
        request.predicate = predicate
        
        do {
            let fetchClouds = try persistentContainer.viewContext.fetch(request)
            clouds = fetchClouds.shuffled()
        } catch {
            fatalError("Failed to fetch clouds: \(error)")
        }
    }
    
    func updateCloudOpacity(newOpacity: Double) {
       let context = persistentContainer.viewContext
       
       context.perform {
           for cloud in self.clouds {
               cloud.opacity += newOpacity
           }

           do {
               try context.save()
               self.fetchClouds()
           } catch {
               fatalError("Failed to save context: \(error)")
           }
       }
   }

    func textValidated(_ count: Int) -> Bool {
        count < 6
    }
}
