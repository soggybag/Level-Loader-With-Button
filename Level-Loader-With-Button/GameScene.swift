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
	var levels = [SKNode]()
    var lastNode: SKNode?
    var levelIndex = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let buttonSize = CGSize(width: 80, height: 40)
        nextLevelButton = SKSpriteNode(color: UIColor.blueColor(), size: buttonSize)
        addChild(nextLevelButton)
        nextLevelButton.position.x = frame.width - 60
        nextLevelButton.position.y = 40
        nextLevelButton.name = "nextLevelButton"
        
        let scene_1 = Level(fileNamed: "Level_1")!
        let scene_2 = Level(fileNamed: "Level_2")!
        let scene_3 = Level(fileNamed: "Level_3")!
        
        let level_1 = scene_1.childNodeWithName("scene")!
        level_1.removeFromParent()
        let level_2 = scene_2.childNodeWithName("scene")!
        level_2.removeFromParent()
        let level_3 = scene_3.childNodeWithName("scene")!
        level_3.removeFromParent()
        
        level_1.name = "level"
        level_2.name = "level"
        level_3.name = "level"
        
        levels = [level_1, level_2, level_3]
        
        /*
        background_1 = childNodeWithName("background_1") as! SKSpriteNode
        background_2 = childNodeWithName("background_2") as! SKSpriteNode
        
        
		
        background_1.addChild(level_1)
		background_2.addChild(level_2)
         */
    }
	
	
	
	func getRandomLevelForNode(node: SKNode) {
		node.childNodeWithName("level")?.removeFromParent()
		let levelNode = levels[Int(arc4random()) % levels.count].copy() as! SKNode
		node.addChild(levelNode)
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
            node.addChild(levels[levelIndex])
            levelIndex += 1
            if levelIndex == levels.count {
                levelIndex = 0
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


