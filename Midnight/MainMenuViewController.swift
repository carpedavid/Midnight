//
//  MainMenuViewController.swift
//  MatchRPG
//
//  Created by David Garrett on 8/11/16.
//  Copyright © 2016 David Garrett. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class MainMenuViewController: UIViewController {
    var options: GameOptions = GameOptions()
    
    @IBAction func mainMenuUnwindAction(_ unwindSegue: UIStoryboardSegue) {

    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        options.load()
//        printFonts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    func printFonts() {
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
}
