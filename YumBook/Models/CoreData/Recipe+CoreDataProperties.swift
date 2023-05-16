//
//  Recipe+CoreDataProperties.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 5/4/23.
//

import SwiftUI
import CoreData


extension Recipe {
    @NSManaged public var ingredientAndMeasure: String
    @NSManaged public var title: String
    @NSManaged public var instruction: String
    @NSManaged public var image: Data?
    
  static func create(title: String,
                     instruction: String,
                     ingredientAndMeasure: String,
                     image: UIImage?,
                     in managedObjectContext: NSManagedObjectContext) {
    let newRecipe = self.init(context: managedObjectContext)
      newRecipe.title = title
      newRecipe.instruction = instruction
      newRecipe.ingredientAndMeasure = ingredientAndMeasure
      newRecipe.image = image?.jpegData(compressionQuality: 1.0)
    do {
      try managedObjectContext.save()
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
    static func basicFetchRequest() -> FetchRequest<Recipe> {
      return FetchRequest<Recipe>(entity: Recipe.entity(), sortDescriptors: [])
    }
    
}
