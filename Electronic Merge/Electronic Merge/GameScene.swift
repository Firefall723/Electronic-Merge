import SpriteKit
class GameScene: SKScene {
    var time: Int = 10
    var clock = Timer()
    let timer = SKLabelNode(text: "")
    var items: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let platformSize = CGSize(width: 50, height: 50)
    
    func spawnObject(levelMod: Int, platformPos: CGPoint) {
        //level mod is unused atm
        let object = SKSpriteNode(color: .red, size: platformSize)
        object.position = CGPoint(x: (platformPos.x), y: (platformPos.y + 10))
    }
    
    
    
    func updateSpots() {
        if let i = items.firstIndex(of: 0){
        items[i] = 1
            let updatePlatform = childNode(withName: "platform\(i + 1)") as! SKSpriteNode
        updatePlatform.color = UIColor.green
            
        }
        else {
            print("no empty spaces")
        }
    }
    
    func startTimer() {
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timeUpdate() {
        if time <= 10 && time >= 1 {
            time = (time - 1)
            timer.text = "\(time)"
        }
        else {
            time = 10
            timer.text = "\(time)"
            updateSpots()
        }
    }
    
    
    func platforms(positionSetting: Int) {
        let platform = SKSpriteNode(color: UIColor.black, size: platformSize)
        let positionX: [CGFloat] = [0.2, 0.5, 0.8, 0.2, 0.5, 0.8, 0.2, 0.5, 0.8]
        let positionY: [CGFloat] = [0.5, 0.5, 0.5, 0.6, 0.6, 0.6, 0.7, 0.7, 0.7]
            let trueX =  ((self.size.width) * positionX[positionSetting])
            let trueY = ((self.size.height) * positionY[positionSetting])
            platform.position = CGPoint(x: trueX, y: trueY)
            platform.name = "platform\(positionSetting + 1)"
            addChild(platform)
    }
    
    func spawnCrate() {
        //creates the crate also the timer
        let crate = SKSpriteNode(imageNamed: "Crate")
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
        backgroundColor = SKColor.white
        spawnCrate()
        startTimer()
        for i in 0...8 {
        platforms(positionSetting: i)
        }
    }
}
