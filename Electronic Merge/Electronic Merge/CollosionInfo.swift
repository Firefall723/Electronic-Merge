import Foundation
import SpriteKit

class CollosionInfo {
    let platformID = 1
    let objectID = 2
    let nilID = 0

    func levelUp(object1: SKSpriteNode, object2: SKSpriteNode, level1: Int, level2: Int, platform1: CGPoint, platform2: CGPoint){
        
        if level1 == level2 {
            
        }
        else {
            object1.position = platform1
            object2.position = platform2
        }
        
        
        
    }
    
    
}
