//
//  ScoreScene.swift
//  2048
//
//  Created by Graphic on 2017-03-16.
//  Copyright © 2017 Graphic. All rights reserved.
//

import SpriteKit
import GameplayKit

class ScoreScene: SKScene {
    
    private var btn_back: SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        self.btn_back = self.childNode(withName: "btn_back") as? SKLabelNode
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if (btn_back?.contains(touch.location(in: self)))! {
            if let scene = TitleScene(fileNamed: "TitleScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1.0));
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
