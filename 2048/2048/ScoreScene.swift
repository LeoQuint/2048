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
    
    private var score1 : SKLabelNode?
    private var score2 : SKLabelNode?
    private var score3 : SKLabelNode?
    private var score4 : SKLabelNode?
    private var score5 : SKLabelNode?
    private var score6 : SKLabelNode?
    private var score7 : SKLabelNode?
    private var score8 : SKLabelNode?
    private var score9 : SKLabelNode?
    private var score10 : SKLabelNode?
    
    private var scores = Array(repeating: 0, count: 10)
    
    private var btn_back: SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        self.btn_back = self.childNode(withName: "btn_back") as? SKLabelNode
    }
    
    override func sceneDidLoad() {
        self.score1 = self.childNode(withName: "score1") as? SKLabelNode
        self.score2 = self.childNode(withName: "score2") as? SKLabelNode
        self.score3 = self.childNode(withName: "score3") as? SKLabelNode
        self.score4 = self.childNode(withName: "score4") as? SKLabelNode
        self.score5 = self.childNode(withName: "score5") as? SKLabelNode
        self.score6 = self.childNode(withName: "score6") as? SKLabelNode
        self.score7 = self.childNode(withName: "score7") as? SKLabelNode
        self.score8 = self.childNode(withName: "score8") as? SKLabelNode
        self.score9 = self.childNode(withName: "score9") as? SKLabelNode
        self.score10 = self.childNode(withName: "score10") as? SKLabelNode
        LoadScore()
    }
    
    func LoadScore()
    {
        let defaults = UserDefaults.standard
        for i in 0...10
        {
            scores[i] = Int(defaults.string(forKey: defaultKeys.keys[i])!)!
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if (btn_back?.contains(touch.location(in: self)))! {
            if let scene = TitleScene(fileNamed: "TitleScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                self.scene?.view?.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1.0));
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
