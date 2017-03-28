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
    private var selectedLabel: SKLabelNode?
    
    
    
    //Colors tiles
    private var color_Zero: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)
    private var color_P1: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//2
    private var color_P2: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//4
    private var color_P3: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//8
    private var color_P4: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//16
    private var color_P5: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//32
    private var color_P6: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//64
    private var color_P7: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//128
    private var color_P8: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//256
    private var color_P9: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//516
    private var color_P10: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//1024
    private var color_P11: SKColor? = SKColor (colorLiteralRed: 0.1, green: 0.2, blue: 1.0, alpha: 1.0)//2048
    //colors font
    private var color_Dark: SKColor? = SKColor (colorLiteralRed: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    private var color_Light: SKColor? = SKColor (colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //Font size
    private var font_1D = 48
    private var font_2D = 46
    private var font_3D = 40
    private var font_4D = 36

    
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
    

    
    
    
    func swipedRight(recognizer:UISwipeGestureRecognizer){
        print("swiped right")
    }
    
    func swipedLeft(recognizer:UISwipeGestureRecognizer){
        print("swiped left")
    }
    
    func swipedUp(recognizer:UISwipeGestureRecognizer){
        print("swiped up")
        ChangeNodeNumber(row: 2,col: 2,value: 2)
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
    
    
    func ChangeNodeNumber(row:Int, col:Int, value:Int){
        self.selectedShape = self.childNode(withName: (String(row) + String(col))) as? SKShapeNode
        self.selectedLabel = selectedShape?.childNode(withName: "num") as? SKLabelNode
        
        
        switch value {
        case 0:
            selectedShape?.fillColor = color_Zero!
        case 2:
            selectedShape?.fillColor = color_P1!
        case 4:
            selectedShape?.fillColor = color_P2!
        case 8:
            selectedShape?.fillColor = color_P3!
        case 16:
            selectedShape?.fillColor = color_P4!
        case 32:
            selectedShape?.fillColor = color_P5!
        case 64:
            selectedShape?.fillColor = color_P6!
        case 128:
            selectedShape?.fillColor = color_P7!
        case 256:
            selectedShape?.fillColor = color_P1!
        case 516:
            selectedShape?.fillColor = color_P1!
        case 1024:
            selectedShape?.fillColor = color_P1!
        case 2048:
            selectedShape?.fillColor = color_P1!
        default:
            selectedShape?.fillColor = color_Zero!
        }
        
        
        if (value < 5)
        {
            selectedLabel?.fontColor = color_Dark
        }
        else
        {
            selectedLabel?.fontColor = color_Dark
        }
        selectedLabel?.text = String(value)
        
        
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
