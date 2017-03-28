//
//  GameScene.swift
//  2048
//
//  Created by Graphic on 2017-03-16.
//  Copyright © 2017 Graphic. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var btn_newGame: SKLabelNode?
    private var btn_return: SKLabelNode?
    private var selectedShape: SKShapeNode?
    private var selecedLabel: SKLabelNode?
    
    
    var board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    
    override func didMove(to view: SKView) {
        self.btn_newGame = self.childNode(withName: "btn_newGame") as? SKLabelNode
        self.btn_return = self.childNode(withName: "btn_Return") as? SKLabelNode
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedRight(recognizer:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedLeft(recognizer:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedUp(recognizer:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipedDown(recognizer:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)

    }
    
    override func sceneDidLoad() {
        InitializeGame()
       
    }
    
    func ChangeNodeNumber(row:Int, col:Int, value:Int){
        self.selectedShape = self.childNode(withName: (String(row) + String(col))) as? SKShapeNode
        self.selecedLabel = selectedShape?.childNode(withName: "num") as? SKLabelNode
    }
    
    
    
    func swipedRight(recognizer:UISwipeGestureRecognizer){
        print("swiped right")
    }
    
    func swipedLeft(recognizer:UISwipeGestureRecognizer){
        print("swiped left")
    }
    
    func swipedUp(recognizer:UISwipeGestureRecognizer){
        print("swiped up")
    }
    
    func swipedDown(recognizer:UISwipeGestureRecognizer){
        print("swiped down")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if (btn_newGame?.contains(touch.location(in: self)))! {
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(scene, transition: SKTransition.doorway(withDuration: 1.0));
            }
        }
        if (btn_return?.contains(touch.location(in: self)))! {
            if let scene = TitleScene(fileNamed: "TitleScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0));
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func InitializeGame(){
        board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        let diceRoll1 = Int(arc4random_uniform(4))
        let diceRoll2 = Int(arc4random_uniform(4))
        
        let diceRoll3 = Int(arc4random_uniform(4))
        let diceRoll4 = Int(arc4random_uniform(4))
        
        let diceRoll5 = Int(arc4random_uniform(2) + 1)
        let diceRoll6 = Int(arc4random_uniform(2) + 1)
        
        board[diceRoll1][diceRoll2] = 2 ** diceRoll5;
        board[diceRoll3][diceRoll4] = 2 ** diceRoll6;
        print("Location: ",diceRoll1," ",diceRoll2 ,". Number",board[diceRoll1][diceRoll2])
        print("Location: ",diceRoll3," ",diceRoll4 ,". Number",board[diceRoll3][diceRoll4])
    }
    
   

}
infix operator ** { associativity left precedence 170 }

func ** (num: Int, power: Int) -> Int{
    return Int(pow(Double(num), Double(power)))
}
