//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Marc Aupont on 12/20/15.
//  Copyright © 2015 Digimark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var activePlayer = 1 // 1 = O's  2 = X's
    
    
    //This array is being used to keep track of the value of each button. Each array position corresponds to a Tag that has been set for each button. The intial value of empty is denoted by a 0.
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var gameActive = true
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var playAgainButton: UIButton!
    
    
    @IBAction func playAgain(sender: AnyObject) {
        
        
        //All the code below resets everything back to initial values
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        activePlayer = 1

        gameActive = true
        
        gameOverLabel.hidden = true
        
        
        //this line of code ensures that the label starts off of the screen
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        
        playAgainButton.hidden = true
        
        
        //this line of code ensures that the button starts off of the screen
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
        
        var buttonToClear : UIButton
        
        for var i = 0; i < 9; i++ {
            
            buttonToClear = view.viewWithTag(i) as! UIButton
            
            buttonToClear.setImage(nil, forState: .Normal)
        }
        
    }
    
    
    @IBOutlet var gameOverLabel: UILabel!
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        
        //This part of the code checks to see if the button that was pressed is blank. If so, proceed with updating image to O first then X. If value is already O or X, do nothing. Also check to see that the game is active and no one has won. If someone wins, stop the game and don't allow any additonal input
        if (gameState[sender.tag] == 0 && gameActive == true) {
            
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                
                sender.setImage(UIImage(named: "tic tac o.png"), forState: .Normal)
                
                activePlayer = 2
                
            } else {
                
                sender.setImage(UIImage(named: "tic tac x.png"), forState: .Normal)
                
                activePlayer = 1
                
            }//end activePlayer if statement
            
            for combination in winningCombinations {
                
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                    
                    //At this point, someone has won so set the game to no longer active
                    gameActive = false
                    
                    if gameState[combination[0]] == 1 {
                        
                        gameOverLabel.text = "Circle's Win!"
                        
                    } else {
                        
                        gameOverLabel.text = "X's Win"
                        
                    }//end if statement for which player won
                    
                   endGame()
                    
                }//end combination check if statement
                
                if gameActive == true {
                
                    gameActive = false
                    
                    
                    //Loop through each button and check to see if the value is 0/blank. If there are still blank spaces, the game is still going on. If not, game is no longer active and it is a draw.
                    for buttonState in gameState {
                    
                        if buttonState == 0 {
                        
                            gameActive = true
                        }
                    
                    }
                
                    if gameActive == false {
                    
                        gameOverLabel.text = "It's a Draw!"
                    
                        endGame()
                    }
                
                }
                
            }
            
        }
        
        
        
        
    }
    
    //This function/method handles what happens at the end of a game. Essentially we bring in our label and button onto the screen with the proper message depending on the end game condition.
    func endGame() {
        
        gameOverLabel.hidden = false
        
        playAgainButton.hidden = false
        
        
        //This piece of code animates the label and button in and comes in from the left to right
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
            
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 500, self.playAgainButton.center.y)
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameOverLabel.hidden = true
        
        
        //this line of code ensures that the label starts off of the screen
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        
        playAgainButton.hidden = true
        
        
        //this line of code ensures that the button starts off of the screen
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 500, playAgainButton.center.y)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

