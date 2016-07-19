//
//  GameScene.swift
//  Load Levels
//
//  Created by mitchell hudson on 7/11/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//


/*

	This examle loads "game levels" from individual sks files. 
	It then copies these and adds them to nodes which scroll by. 
	As each node is recycled we choose a random "game level" and
	remove the previous "game level"

*/


import SpriteKit

class GameScene: SKScene {
    
    var nextLevelButton: SKSpriteNode!
    var lastNode: SKNode?
    var levelIndex = 1
    let totalLevels = 3
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let buttonSize = CGSize(width: 80, height: 40)
        nextLevelButton = SKSpriteNode(color: UIColor.blueColor(), size: buttonSize)
        addChild(nextLevelButton)
        nextLevelButton.position.x = frame.width - 60
        nextLevelButton.position.y = 40
        nextLevelButton.name = "nextLevelButton"
    }
	
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        let touch = touches.first!
        let location = touch.locationInNode(self)
        let node = nodeAtPoint(location)
        if node.name == "nextLevelButton" {
            print("Next Level!")
            
            // remove previous level
            if let lastNode = lastNode {
                let removeNode = SKAction.removeFromParent()
                let moveOff = SKAction.moveToX(-view!.frame.width, duration: 0.5)
                lastNode.runAction(SKAction.sequence([moveOff, removeNode]))
            }
            
            // Add new level
            let node = SKNode()
            let newLevel = SKScene(fileNamed: "Level_\(levelIndex)")!
            let newScene = newLevel.childNodeWithName("scene")!
            newScene.removeFromParent()
            node.addChild(newScene)
            
            if levelIndex == totalLevels {
                levelIndex = 1
            } else {
                levelIndex += 1
            }
            
            addChild(node)
            node.position.x = view!.frame.width
            let move = SKAction.moveToX(0, duration: 0.5)
            node.runAction(move)
            lastNode = node
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}


