//
//  Animal.swift
//  ItsAZooInThere
//
//  Created by Trace Sauter on 4/18/19.
//  Copyright © 2019 Trace Sauter. All rights reserved.
//

//import Foundation
import UIKit

class Animal: CustomStringConvertible {
    var description: String
    
    
    //MARK: Properties
    
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    
    //MARK: Initialization
    
    init(name: String, species: String, age: Int, image: UIImage, soundPath: String) {
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
        
        self.description = "Animal: name = \(name), specials = \(species), age = \(age)"
    }
}
