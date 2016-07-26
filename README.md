# Level-Loader-With-Button

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
