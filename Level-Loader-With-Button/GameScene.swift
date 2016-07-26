//
//  GameScene.swift
//  Load Levels
//
//  Created by mitchell hudson on 7/11/16.
//  Copyright (c) 2016 mitchell hudson. All rights reserved.
//


/*

 This examle loads "game levels" from individual sks files.
 It then copies these and adds them to nodes which scroll into view.
 This system might be good when you want to load new content into the
 current scene without presenting a new scene file.
 
 All of the content is "extracted" from scenes that are loaded. To make 
 this possible each level scene, holds it's content in an SKNode named "scene". 
 
 When a level is loaded the code below looks for the childnode named "scene", 
 removes this node from the level scene, and adds it to the current scene.
 
 In this example there are three levels and each is named Level_x where x is
 the level number. This way we can easily keep track of the level number with 
 levelIndex. 
 
 Remember! your program will crah if try and add a node to a parent node when 
 it is child of another node. You must always call node.removeFromParent() 
 first!

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
            
            // Add a new node to hold the new level content
            let node = SKNode()
            // Load the level scene
            let newLevel = SKScene(fileNamed: "Level_\(levelIndex)")!
            // Get the content node from that level
            let newScene = newLevel.childNodeWithName("scene")!
            // Remove the content node from the it's current parent
            newScene.removeFromParent()
            // Add the new content to the new scene node
            node.addChild(newScene)
            
            // Advance the index to the next level.
            if levelIndex == totalLevels {
                levelIndex = 1
            } else {
                levelIndex += 1
            }
            
            // add the new content node
            addChild(node)
            // Position this node off the right edge
            node.position.x = view!.frame.width
            // Use an action to move the content onto the screen from the right.
            let move = SKAction.moveToX(0, duration: 0.5)
            node.runAction(move)
            // Mark this as the last node. This way we can identify this node to remove when 
            // we need to load a new level. 
            lastNode = node
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
}


