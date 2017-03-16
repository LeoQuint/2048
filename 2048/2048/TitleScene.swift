//
//  TitleScene.swift
//  2048
//
//  Created by Graphic on 2017-03-16.
//  Copyright © 2017 Graphic. All rights reserved.
//

import SpriteKit
import GameplayKit

class TitleScene: SKScene {
    
    private var btn_newGame: SKLabelNode?
    private var btn_highScores: SKLabelNode?
    private var btn_instructions: SKLabelNode?
    private var img_instructions: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.btn_newGame = self.childNode(withName: "btn_play") as? SKLabelNode
        self.btn_instructions = self.childNode(withName: "btn_instructions") as? SKLabelNode
        self.btn_highScores = self.childNode(withName: "btn_highscore") as? SKLabelNode
        self.img_instructions = self.childNode(withName: "img_instructions")as? SKSpriteNode
        
        if !((img_instructions?.isHidden)!)
        {
            img_instructions?.isHidden = true
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if (btn_newGame?.contains(touch.location(in: self)))! {
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1.0));
            }
        }
        if (btn_highScores?.contains(touch.location(in: self)))! {
            if let scene = ScoreScene(fileNamed: "ScoreScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 1.0));
            }
        }
        if (btn_instructions?.contains(touch.location(in: self)))! {
            if !((img_instructions?.isHidden)!)
            {
                img_instructions?.isHidden = true
            }
            else{
                img_instructions?.isHidden = false
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
}
