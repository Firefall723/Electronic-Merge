import Foundation
import SpriteKit

class CollosionInfo {
   /* let platformID = 1
    let objectID = 2
    let nilID = 0 */
    let platformSize = CGSize(width: 50, height: 50)
    var items: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    
    func spawnObject(levelMod: Int, platformPos: CGPoint, platformSpot: Int) {
        var object: SKSpriteNode!
        if levelMod == 1 {
            object = SKSpriteNode(imageNamed: "Wire")        }
        else if levelMod == 2 {
            object = SKSpriteNode(imageNamed: "CircuitBoard")
        }
        else {
            object = SKSpriteNode(color: .red, size: platformSize)
        }
        object.size = platformSize
        object.position = CGPoint(x: (platformPos.x), y: (platformPos.y + 5))
        object.name = "object\(platformSpot)level\(levelMod)"
    }
    

    func levelUp(object1: SKSpriteNode, object2: SKSpriteNode, level1: Int, level2: Int, platform1: CGPoint, platform2: CGPoint, platformValue1: Int, platformValue2: Int){
        
        if level1 == level2 {
            object1.removeFromParent()
            object2.removeFromParent()
            let newLevel = (level1 + 1)
            spawnObject(levelMod: newLevel, platformPos: platform2, platformSpot: platformValue2)
            items[(platformValue1 - 1)] = 0
            items[(platformValue2 - 1)] = newLevel
            
            
        }
        else {
            object1.position = platform1
            object2.position = platform2
        }
        
        
        
    }
    
    
}
