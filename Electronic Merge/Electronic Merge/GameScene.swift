import SpriteKit

class GameScene: SKScene {
    var time: Int = 10
    var clock = Timer()
    let timer = SKLabelNode(text: "")
    var items: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let platformSize = CGSize(width: 50, height: 50)
    var activeObject: SKSpriteNode!
    var isFull = false
    var object : SKSpriteNode!
    let platformID = 1
    let objectID = 2
    let nilID = 0
    let crate = SKSpriteNode(imageNamed: "Crate")
    
    
    func physicBodySetUp(sprite: SKSpriteNode, ID1: Int) {
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.categoryBitMask = UInt32(ID1)
        sprite.physicsBody?.contactTestBitMask = UInt32(ID1)
        sprite.physicsBody?.collisionBitMask = UInt32(nilID)
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

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touch = touches.first
    if let touchLocation = touch?.location(in: self) {
    let selectedNode = nodes(at: touchLocation)[0] as! SKSpriteNode
        }
        }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func spawnObject(levelMod: Int, platformPos: CGPoint, platformSpot: Int) {
        var object: SKSpriteNode!
        self.object = object
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
        physicBodySetUp(sprite: object, ID1: objectID)
        addChild(object)
    }
    
    
    
    func updateSpots() {
        if let i = items.firstIndex(of: 0){
        items[i] = 1
            let updatePlatform = childNode(withName: "platform\(i + 1)") as! SKSpriteNode
            spawnObject(levelMod: 1, platformPos: updatePlatform.position, platformSpot: (i + 1))
            isFull = false
        }
        else {
            isFull = true
        }
    }
    
    func startTimer() {
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timeUpdate() {
        if isFull == false {
        if time <= 10 && time >= 1 {
            time = (time - 1)
            timer.text = "\(time)"
        }
        else {
            time = 10
            timer.text = "\(time)"
            updateSpots()
        }
        } else {
            timer.text = "Full"
        }
    }
    
    
    func platforms(positionSetting: Int) {
        let platform = SKSpriteNode(color: UIColor.black, size: platformSize)
        let positionX: [CGFloat] = [0.15, 0.5, 0.85, 0.15, 0.5, 0.85, 0.15, 0.5, 0.85]
        let positionY: [CGFloat] = [0.45, 0.45, 0.45, 0.6, 0.6, 0.6, 0.75, 0.75, 0.75]
            let trueX =  ((self.size.width) * positionX[positionSetting])
            let trueY = ((self.size.height) * positionY[positionSetting])
            platform.position = CGPoint(x: trueX, y: trueY)
            platform.zPosition = -1
            platform.isUserInteractionEnabled = false
            platform.name = "platform\(positionSetting + 1)"
            addChild(platform)
    }
    
    func spawnCrate() {
        //creates the crate also the timer
        crate.scale(to: CGSize(width: 100, height: 100))
        timer.text = "10"
        timer.fontColor = SKColor.black
        timer.fontName = "AvenirNextCondensed-Bold"
        crate.position = CGPoint(x: ((self.size.width) * 0.5) , y: ((self.size.height) * 0.1))
        timer.position = CGPoint(x: (((self.size.width) * 0.5) + 75), y: ((self.size.height) * 0.15))
        addChild(crate)
        addChild(timer)
    }
    
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector.zero
        backgroundColor = SKColor.white
        spawnCrate()
        startTimer()
        for i in 0...8 {
        platforms(positionSetting: i)
        }
    }
}
