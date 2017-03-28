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
    private var scoreLabel: SKLabelNode?
    
    private var cheekyDown = false
    private var cheekyUp = false
    private var cheekyLeft = false
    private var cheekyRight = false

    private var score = 0
    //Colors tiles
    private var color_Zero: SKColor? = SKColor (colorLiteralRed: 0.8, green: 0.76, blue: 0.71, alpha: 1.0)
    private var color_P1: SKColor? = SKColor (colorLiteralRed: 0.93, green: 0.89, blue: 0.85, alpha: 1.0)//2
    private var color_P2: SKColor? = SKColor (colorLiteralRed: 0.93, green: 0.88, blue: 0.78, alpha: 1.0)//4
    private var color_P3: SKColor? = SKColor (colorLiteralRed: 0.95, green: 0.69, blue: 0.47, alpha: 1.0)//8
    private var color_P4: SKColor? = SKColor (colorLiteralRed: 0.96, green: 0.58, blue: 0.39, alpha: 1.0)//16
    private var color_P5: SKColor? = SKColor (colorLiteralRed: 0.97, green: 0.49, blue: 0.37, alpha: 1.0)//32
    private var color_P6: SKColor? = SKColor (colorLiteralRed: 0.97, green: 0.37, blue: 0.24, alpha: 1.0)//64
    private var color_P7: SKColor? = SKColor (colorLiteralRed: 0.93, green: 0.81, blue: 0.44, alpha: 1.0)//128
    private var color_P8: SKColor? = SKColor (colorLiteralRed: 0.93, green: 0.80, blue: 0.38, alpha: 1.0)//256
    private var color_P9: SKColor? = SKColor (colorLiteralRed: 0.93, green: 0.78, blue: 0.31, alpha: 1.0)//512
    private var color_P10: SKColor? = SKColor (colorLiteralRed: 0.93, green: 0.77, blue: 0.25, alpha: 1.0)//1024
    private var color_P11: SKColor? = SKColor (colorLiteralRed: 0.93, green: 0.76, blue: 0.18, alpha: 1.0)//2048
    //colors font
    private var color_Dark: SKColor? = SKColor (colorLiteralRed: 0.47, green: 0.43, blue: 0.40, alpha: 1.0)
    private var color_Light: SKColor? = SKColor (colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    //Font size
    private var font_1D = 48
    private var font_2D = 48
    private var font_3D = 46
    private var font_4D = 36

    
    var board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
    
    override func didMove(to view: SKView) {
        self.btn_newGame = self.childNode(withName: "btn_newGame") as? SKLabelNode
        self.btn_return = self.childNode(withName: "btn_Return") as? SKLabelNode
        
        if (cheekyDown && cheekyUp && cheekyLeft && cheekyRight){
            if let scene = GameOverScene(fileNamed: "GameOverScene") {
                scene.scaleMode = .aspectFill
                self.scene?.view?.presentScene(scene, transition: SKTransition.doorway(withDuration: 1.0));
            }
        }
        
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
        self.scoreLabel = self.childNode(withName: "lbl_Score") as? SKLabelNode
    }

    
    
    func swipedRight(recognizer:UISwipeGestureRecognizer){
        CalculateTurn(direction: 1)
    }
    
    func swipedLeft(recognizer:UISwipeGestureRecognizer){
        CalculateTurn(direction: 0)
    }
    
    func swipedUp(recognizer:UISwipeGestureRecognizer){
        CalculateTurn(direction: 2)
    }
    
    func swipedDown(recognizer:UISwipeGestureRecognizer){
        CalculateTurn(direction: 3)
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
        board[row][col] = value
        
        switch value {
        case 0:
            selectedShape?.fillColor = color_Zero!
        case 2:
            selectedShape?.fillColor = color_P1!
            selectedLabel?.fontSize = CGFloat(font_1D)
        case 4:
            selectedShape?.fillColor = color_P2!
            selectedLabel?.fontSize = CGFloat(font_1D)
        case 8:
            selectedShape?.fillColor = color_P3!
            selectedLabel?.fontSize = CGFloat(font_1D)
        case 16:
            selectedShape?.fillColor = color_P4!
            selectedLabel?.fontSize = CGFloat(font_1D)
        case 32:
            selectedShape?.fillColor = color_P5!
            selectedLabel?.fontSize = CGFloat(font_1D)
        case 64:
            selectedShape?.fillColor = color_P6!
            selectedLabel?.fontSize = CGFloat(font_1D)
        case 128:
            selectedShape?.fillColor = color_P7!
            selectedLabel?.fontSize = CGFloat(font_2D)
        case 256:
            selectedShape?.fillColor = color_P8!
            selectedLabel?.fontSize = CGFloat(font_2D)
        case 512:
            selectedShape?.fillColor = color_P9!
            selectedLabel?.fontSize = CGFloat(font_2D)
        case 1024:
            selectedShape?.fillColor = color_P10!
            selectedLabel?.fontSize = CGFloat(font_3D)
        case 2048:
            selectedShape?.fillColor = color_P11!
            selectedLabel?.fontSize = CGFloat(font_3D)
        default:
            selectedShape?.fillColor = color_Zero!
        }
        
        
        if (value == 0)
        {
            selectedLabel?.text = ""
        }
        else if(value < 5)
        {
            selectedLabel?.fontColor = color_Dark
            selectedLabel?.text = String(value)
        }
        else
        {
            selectedLabel?.fontColor = color_Light
            selectedLabel?.text = String(value)
        }
        
        
        
    }
    
    func AddNumber()
    {
        var diceRoll3 = Int(arc4random_uniform(4))
        var diceRoll4 = Int(arc4random_uniform(4))
        while (board[diceRoll3][diceRoll4] != 0) {
            diceRoll3 = Int(arc4random_uniform(4))
            diceRoll4 = Int(arc4random_uniform(4))
        }
        ChangeNodeNumber(row: diceRoll3, col: diceRoll4, value: 2**Int(arc4random_uniform(2) + 1))
    }
    
    func CalculateTurn(direction:Int){
        var moved = false
        switch direction {
        case -1:
            for x in 0...3
            {
                for y in 0...3
                {
                    ChangeNodeNumber(row: x, col: y, value: board[x][y])
                }
            }
            //LEFT
        case 0:
            for x in 0...3
            {
                for y in 0...3
                {
                    if (y == 0){
                        continue
                    }
                    for i in 0...y{
                        if (board[x][i] == 0){
                            ChangeNodeNumber(row: x, col: i, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
                for y in 0...3
                {
                    if (y == 0){
                        continue
                    }
                    if (board[x][y-1] == board[x][y]){
                        ChangeNodeNumber(row: x, col: y-1, value: (board[x][y] * 2))
                        score = score + board[x][y-1]
                        ChangeNodeNumber(row: x, col: y, value: 0)
                        moved = true
                    }
                }
                for y in 0...3
                {
                    if (y == 0){
                        continue
                    }
                    for i in 0...y{
                        if (board[x][i] == 0){
                            ChangeNodeNumber(row: x, col: i, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
            }
        case 1:
            for x in 0...3
            {
                for y in (0...3).reversed()
                {
                    if (y == 3){
                        continue
                    }
                    for i in (y...3).reversed(){
                        if (board[x][i] == 0){
                            ChangeNodeNumber(row: x, col: i, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
                for y in (0...3).reversed()
                {
                    if (y == 3){
                        continue
                    }
                    if (board[x][y+1] == board[x][y]){
                        ChangeNodeNumber(row: x, col: y+1, value: (board[x][y] * 2))
                        score = score + board[x][y+1]
                        ChangeNodeNumber(row: x, col: y, value: 0)
                        moved = true
                    }
                }
                for y in (0...3).reversed()
                {
                    if (y == 3){
                        continue
                    }
                    for i in (y...3).reversed(){
                        if (board[x][i] == 0){
                            ChangeNodeNumber(row: x, col: i, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
            }
        case 2:
            for y in 0...3
            {
                for x in 0...3
                {
                    if (x == 0){
                        continue
                    }
                    for i in 0...x{
                        if (board[i][y] == 0){
                            ChangeNodeNumber(row: i, col: y, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
                for x in 0...3
                {
                    if (x == 0){
                        continue
                    }
                    if (board[x-1][y] == board[x][y]){
                        ChangeNodeNumber(row: x-1, col: y, value: (board[x][y] * 2))
                        score = score + board[x-1][y]
                        ChangeNodeNumber(row: x, col: y, value: 0)
                        moved = true
                    }
                }
                for x in 0...3
                {
                    if (x == 0){
                        continue
                    }
                    for i in 0...x{
                        if (board[i][y] == 0){
                            ChangeNodeNumber(row: i, col: y, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
            }
        case 3:
            for y in 0...3
            {
                for x in (0...3).reversed()
                {
                    if (x == 3){
                        continue
                    }
                    for i in (x...3).reversed(){
                        if (board[i][y] == 0){
                            ChangeNodeNumber(row: i, col: y, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
                for x in (0...3).reversed()
                {
                    if (x == 3){
                        continue
                    }
                    if (board[x+1][y] == board[x][y]){
                        ChangeNodeNumber(row: x+1, col: y, value: (board[x][y] * 2))
                        score = score + board[x+1][y]
                        ChangeNodeNumber(row: x, col: y, value: 0)
                        moved = true
                    }
                }
                for x in (0...3).reversed()
                {
                    if (x == 3){
                        continue
                    }
                    for i in (x...3).reversed(){
                        if (board[i][y] == 0){
                            ChangeNodeNumber(row: i, col: y, value: board[x][y])
                            ChangeNodeNumber(row: x, col: y, value: 0)
                            moved = true
                            break
                        }
                    }
                }
            }
        default:
            print("default")
        }
        if (moved){
            AddNumber()
            cheekyLeft = false
            cheekyRight = false
            cheekyUp = false
            cheekyDown = false
        }
        else{
            switch direction {
            case 0:
                cheekyLeft = true
            case 1:
                cheekyRight = true
            case 2:
                cheekyUp = true
            case 3:
                cheekyDown = true
            default:
                print("Hey guys!")
            }
        }
        scoreLabel?.text = ("Score: " + String(score))
    }
    
    func InitializeGame(){
        board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        score = 0
        let diceRoll1 = Int(arc4random_uniform(4))
        let diceRoll2 = Int(arc4random_uniform(4))

        var diceRoll3 = Int(arc4random_uniform(4))
        var diceRoll4 = Int(arc4random_uniform(4))

        while (diceRoll1 == diceRoll3 && diceRoll2 == diceRoll4) {
            diceRoll3 = Int(arc4random_uniform(4))
            diceRoll4 = Int(arc4random_uniform(4))
        }
        let diceRoll5 = Int(arc4random_uniform(2) + 1)
        let diceRoll6 = 1
        
        board[diceRoll1][diceRoll2] = 2 ** diceRoll5;
        board[diceRoll3][diceRoll4] = 2 ** diceRoll6;
        print("Location: ",diceRoll1," ",diceRoll2 ,". Number",board[diceRoll1][diceRoll2])
        print("Location: ",diceRoll3," ",diceRoll4 ,". Number",board[diceRoll3][diceRoll4])
        CalculateTurn(direction: -1)
    }
    
   

}
infix operator ** { associativity left precedence 170 }

func ** (num: Int, power: Int) -> Int{
    return Int(pow(Double(num), Double(power)))
}
