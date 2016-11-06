//
//  LevelCompleteViewController.swift
//  MatchRPG
//
//  Created by David Garrett on 8/28/16.
//  Copyright © 2016 David Garrett. All rights reserved.
//

import Foundation
import UIKit

class LevelCompleteViewController: UIViewController {
    @IBOutlet weak var gameOverPanel: UIImageView!
    
    @IBOutlet weak var totalMovesGoal: UILabel!
    @IBOutlet weak var damageTakenGoal: UILabel!
    @IBOutlet weak var elapsedTimeGoal: UILabel!
    @IBOutlet weak var totalMovesResult: UILabel!
    @IBOutlet weak var damageTakenResult: UILabel!
    @IBOutlet weak var elapsedTimeResult: UILabel!
    @IBOutlet weak var currentLevel: UILabel!
    @IBOutlet weak var nextLevel: UILabel!

    @IBOutlet weak var goal1: UIImageView!
    @IBOutlet weak var goal2: UIImageView!
    @IBOutlet weak var goal3: UIImageView!
    
    @IBOutlet weak var experienceView: UIView!
    @IBOutlet weak var experienceProgress: UIProgressView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    
    @IBAction func continueButtonPressed() {
        if gameOver {
            performSegue(withIdentifier: "showMainMenu", sender: self)
        } else if levelUp {
            performSegue(withIdentifier: "showLevelUp", sender: self)
        } else {
            performSegue(withIdentifier: "showStoryMode", sender: self)
        }
    }
    
    var savedGame: GameSave!
    private var character: Character!
    var level: Level!
    var gameOver: Bool = false
    var awardedExperience: Int = 0
    var levelUp: Bool = false

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        character = savedGame.characters[savedGame.selectedCharacter]
        
        totalMovesGoal.text = String(format: "%ld", level.goals.totalMoves)
        damageTakenGoal.text = String(format: "%ld", level.goals.totalDamageTaken)
        elapsedTimeGoal.text = DateComponentsFormatter().string(from: level.goals.elapsedTime)
        
        totalMovesResult.text = String(format: "%ld", level.result.totalMoves)
        damageTakenResult.text = String(format: "%ld", level.result.totalDamageTaken)
        elapsedTimeResult.text = DateComponentsFormatter().string(from: level.result.elapsedTime)
        
        if level.result.totalMoves <= level.goals.totalMoves {goal1.image = UIImage(named: "goal complete")}
        if level.result.totalDamageTaken <= level.goals.totalDamageTaken {goal2.image = UIImage(named: "goal complete")}
        if level.result.elapsedTime <= level.goals.elapsedTime {goal3.image = UIImage(named: "goal complete")}
        
        if awardedExperience > 0 {
            currentLevel.text = String(format: "Level %ld", character.level)
            nextLevel.text = String(format: "Level %ld", character.level + 1)
        } else {
            experienceProgress.isHidden = true
            currentLevel.isHidden = true
            nextLevel.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let progressPercentage = Float(character.experience - character.previousLevelGoal) / Float(character.nextLevelGoal - character.previousLevelGoal)
        experienceProgress.setProgress(progressPercentage, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStoryMode" {
            let vc = segue.destination as! StoryModeViewController
            vc.savedGame = savedGame
        }
        if segue.identifier == "showPreGame" {
            let vc = segue.destination as! PreGameViewController
            vc.savedGame = savedGame
        }
        if segue.identifier == "showLevelUp" {
            let vc = segue.destination as! LevelUpViewController
            vc.savedGame = savedGame
        }
    }
}
