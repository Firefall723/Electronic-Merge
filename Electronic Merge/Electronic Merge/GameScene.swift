import SpriteKit
class GameScene: SKScene {
    var time: Int = 10
    
    
    
    func platforms(positionSetting: Int) {
        let size = CGSize(width: 50, height: 50)
        let platform = SKSpriteNode(color: UIColor.black, size: size)
        let positionX: [CGFloat] = [0.2, 0.5, 0.8, 0.2, 0.5, 0.8, 0.2, 0.5, 0.8]
        let positionY: [CGFloat] = [0.5, 0.5, 0.5, 0.6, 0.6, 0.6, 0.7, 0.7, 0.7]
        
            let trueX =  ((self.size.width) * positionX[positionSetting])
            let trueY = ((self.size.height) * positionY[positionSetting])
            platform.position = CGPoint(x: trueX, y: trueY)
            platform.name = "platform\(positionSetting + 1)"
            addChild(platform)
    }
    
    func spawnCrate() {
        
        let crate = SKSpriteNode(color: SKColor.brown, size: CGSize(width: 100, height: 100))
        let timer = SKLabelNode(text: "\(time)")
        timer.fontColor = SKColor.black
        crate.position = CGPoint(x: ((self.size.width) * 0.5) , y: ((self.size.height) * 0.1))
        timer.position = CGPoint(x: (((self.size.width) * 0.5) + 75), y: ((self.size.height) * 0.15))
        addChild(crate)
        addChild(timer)
    }
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        spawnCrate()
        for i in 0...8 {
        platforms(positionSetting: i)
        }
    }
}
