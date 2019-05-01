import SpriteKit
class GameScene: SKScene {
    
    func platforms(positionSetting: Int) {
        let size = CGSize(width: 50, height: 50)
        let platform = SKSpriteNode(color: UIColor.brown, size: size)
        let positionX: [CGFloat] = [0.2, 0.5, 0.8, 0.2, 0.5, 0.8, 0.2, 0.5, 0.8]
        let positionY: [CGFloat] = [0.5, 0.5, 0.5, 0.6, 0.6, 0.6, 0.7, 0.7, 0.7]
        
            let trueX =  ((self.size.width) * positionX[positionSetting])
            let trueY = ((self.size.height) * positionY[positionSetting])
            platform.position = CGPoint(x: trueX, y: trueY)
            platform.name = "platform\(positionSetting + 1)"
            addChild(platform)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.red
        for i in 0...8 {
        platforms(positionSetting: i)
        }
    }
}
