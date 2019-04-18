//
//  ViewController.swift
//  ItsAZooInThere
//
//  Created by Trace Sauter on 4/17/19.
//  Copyright © 2019 Trace Sauter. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var animalLabel: UILabel!
    
    //MARK: Properties
    var animals: [Animal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // add 3 animals to animals array
        let firstAnimal = Animal(name: "Kermit", species: "Frog", age: 64, image: UIImage(named:"kermit")!, soundPath: "KermitSound")
        let secondAnimal = Animal(name: "Timon", species: "Meerkat", age: 25, image: UIImage(named:"Meerkat")!, soundPath: "MeerkatSound")
        let thirdAnimal = Animal(name: "Jim", species: "Dragon", age: 3, image: UIImage(named:"Dragon")!, soundPath: "DragonSound")
        animals = [firstAnimal, secondAnimal, thirdAnimal]
        
        // shuffle the animals array
        animals.shuffle()
        
        // take care of the scrollview
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: 1125, height: 500)
        scrollView.isPagingEnabled = true
        
        animalLabel.text = animals[0].species
        animalLabel.font = UIFont(name: animalLabel.font.fontName, size: 42)
        animalLabel.textAlignment = .center
        
        for i in 1...3 {
            // add image view
            let imageView = UIImageView(image: animals[i-1].image)
            imageView.frame = CGRect(x: 375 * (i-1), y: 0, width: 375, height: 500)
            scrollView.addSubview(imageView)
            
            // add button
            let button = UIButton(type: UIButton.ButtonType.system)
            button.frame = CGRect(x: (145 + 375 * (i - 1)), y: 400, width: 85, height: 40)
            button.setTitle(animals[i-1].name, for: .normal)
            button.backgroundColor = UIColor(white: 0.8, alpha: 1)
            button.layer.cornerRadius = 2
            button.clipsToBounds = true
            button.tag = i - 1
            // referred to https://stackoverflow.com/questions/41049212/how-to-create-an-ibaction-for-a-button-programmatically-created-based-on-user-in
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            scrollView.addSubview(button)
        }
        
    }

    // referred to Professor Troy's slides
    @objc func buttonTapped(_ sender: UIButton) {
        print("UIButton \(sender.tag) was clicked.")
        // referred to https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
        let alert = UIAlertController(title: "You clicked an animal!", message: "\(animals[sender.tag].name) is a \(animals[sender.tag].age) year old \(animals[sender.tag].species).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cool!", style: .default, handler: nil))
        print(animals[sender.tag].soundPath)
        let path = Bundle.main.path(forResource: animals[sender.tag].soundPath, ofType: "m4a")
        let url = URL(fileURLWithPath: path!)
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print(error)
        }
        self.present(alert, animated: true)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // used stackoverflow to help with modular arithmatic in swift
        // https://stackoverflow.com/questions/40495301/what-does-is-unavailable-use-truncatingremainder-instead-mean
        let theAnimal: Int = Int((scrollView.contentOffset.x + 187) / 375)
        let percentTransition = 2 * abs((scrollView.contentOffset.x.truncatingRemainder(dividingBy: 375.0) / 375.0) - 0.5)
        animalLabel.text = "\(animals[theAnimal].species)"
        animalLabel.alpha = percentTransition
    }
}
