import SpriteKit

class GameScene: SKScene {
    var time: Int = 10
    var clock = Timer()
    let timer = SKLabelNode(text: "")
    var items: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var platformX: [CGFloat] = []
    var platformY: [CGFloat] = []
    let objectSize = CGSize(width: 50, height: 50)
    let objectSize2 = CGSize(width: 30, height: 50)
    let platformSize = CGSize(width: 50, height: 20)
    var activeObject: SKSpriteNode!
    var storedPlatform: Int!
    var storedData: [Character] = []
    var isFull = false
    var object : SKSpriteNode!
    let platformID = 1
    let objectID = 2
    let nilID = 0
    var levelingUp: Bool!
    var crateTapped: Bool!
    var objectExist: Bool!
    var selectedNode2: SKSpriteNode!
    let sprites: [String] = ["Wire", "CircuitBoard", "Screen", "Phone"]
    var objectType: Int!
    
    //Savedata stuff
    let saveData = UserDefaults.standard
    
    
   
    func levelUp(object1: SKSpriteNode, object2: SKSpriteNode, level1: Int, level2: Int, platform2: CGPoint, platformValue1: Int, platformValue2: Int){
        
        if level1 == level2 {
            levelingUp = true
            object1.removeFromParent()
            object2.removeFromParent()
            let newLevel = (level1 + 1)
            if platformValue2 != platformValue1 {
            spawnObject(levelMod: newLevel, platformPos: platform2, platformSpot: platformValue2)
            items[(platformValue1)] = 0
            items[(platformValue2)] = newLevel
                if let test = saveData.array(forKey: "itemsSaved"){
                    saveData.removeObject(forKey: "itemsSaved")
            saveData.set(items, forKey: "itemsSaved")

                }
                else {
                    saveData.set(items, forKey: "itemsSaved")
               }
            }
        }
        else {
            levelingUp = false
        }
        
        
        
    }

    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first{
                let touchLocation = touch.location(in: self)
                if nodes(at: touchLocation).isEmpty == false {
                    objectExist = true
        if let selectedNode = nodes(at: touchLocation)[0] as?
            SKSpriteNode {
            
        
        activeObject = selectedNode
        storedData = Array(activeObject.name!)
            objectType = Int(storedData[0].unicodeScalars.first!.value - Unicode.Scalar("0")!.value)
            if objectType != 18 && objectType! != 19 && objectType != 64{
                crateTapped = false
            if objectType == 31 {
        let platformStoredInt = storedData[2]
                storedPlatform = Int(platformStoredInt.unicodeScalars.first!.value - Unicode.Scalar("0")!.value)
            }
            }
            else if objectType == 19{
                timeUpdate()
            }
            else {
                crateTapped = false
            }
        }
                }
                else {
                    objectExist = false
                }
            }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            let location = touch.location(in: self)
            if  objectType != 18 && objectType != 19 && objectType != 64
            {
            activeObject.position.x = location.x
            activeObject.position.y = location.y
                }
            }
        }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let touchLocation = touch?.location(in: self) {
            if nodes(at: touchLocation).isEmpty == false {
                if objectType != 18 && objectType != 19 && objectType != 64{
                    if nodes(at: touchLocation).count >= 2 {
            if let selectedNode = activeObject {
                if nodes(at: touchLocation)[0] == selectedNode {
                selectedNode2 = nodes(at: touchLocation)[1] as? SKSpriteNode
                }
                else {
                selectedNode2 = nodes(at: touchLocation)[0] as? SKSpriteNode
                }
            let data1 = Array(selectedNode.name!)
            let data2 = Array(selectedNode2.name!)
            
            let objectType1 = String(data1[0].unicodeScalars.first!.value - Unicode.Scalar("0")!.value)
            let objectType2 = String(data2[0].unicodeScalars.first!.value - Unicode.Scalar("0")!.value)
            if Int(objectType1) == 31 && Int(objectType2) == 31{
            
            let level1 = Int(data1[4].unicodeScalars.first!.value - Unicode.Scalar("0")!.value)
            let level2 = Int(data2[4].unicodeScalars.first!.value - Unicode.Scalar("0")!.value)
            let platform2 = Int(data2[2].unicodeScalars.first!.value - Unicode.Scalar("0")!.value)
            let newPlatform = CGPoint(x: platformX[platform2], y: platformY[platform2])
                
                levelUp(object1: selectedNode, object2: selectedNode2, level1: level1, level2: level2, platform2: newPlatform, platformValue1: storedPlatform, platformValue2: platform2)
                    }
                }
                }
            else {
                levelingUp = false
 
 }
        }
            }
        if objectType! != 18 && objectType! != 19 && objectType! != 64 {
        activeObject.position = CGPoint(x: platformX[storedPlatform!], y: platformY[storedPlatform!] + 15)
        }
            }
    }
    func spawnObject(levelMod: Int, platformPos: CGPoint, platformSpot: Int) {
        var object: SKSpriteNode!
        let spriteVal = (levelMod - 1)
        self.object = object
        if levelMod <= sprites.count {
        object = SKSpriteNode(imageNamed: sprites[spriteVal])
        }
        else {
        object = SKSpriteNode(color: .red, size: platformSize)
        }
        if spriteVal == 3 {
        object.size = objectSize2
        }
        else {
        object.size = objectSize
        }
        object.position = CGPoint(x: (platformPos.x), y: (platformPos.y + 20))
        object.name = "O_\(platformSpot)_\(levelMod)"
        object.zPosition = 1
        addChild(object)

    }
    
    
    
    func updateSpots() {
        if let i = items.firstIndex(of: 0){
        items[i] = 1
            let updatePlatform = childNode(withName: "p_\(i + 1)") as! SKSpriteNode
            spawnObject(levelMod: 1, platformPos: updatePlatform.position, platformSpot: (i))
            isFull = false
            if let test = saveData.array(forKey: "itemsSaved") {
                saveData.removeObject(forKey: "itemsSaved")
                saveData.set(items, forKey: "itemsSaved")
            }
            else {
                saveData.set(items, forKey: "itemsSaved")
            }
        }
    }
    
    func startTimer() {
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timeUpdate() {
       if items.contains(0) == true {
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
        let platform = SKSpriteNode(imageNamed: "Platform")
        let positionX: [CGFloat] = [0.15, 0.5, 0.85, 0.15, 0.5, 0.85, 0.15, 0.5, 0.85]
        let positionY: [CGFloat] = [0.45, 0.45, 0.45, 0.6, 0.6, 0.6, 0.75, 0.75, 0.75]
            let trueX =  ((self.size.width) * positionX[positionSetting])
            let trueY = ((self.size.height) * positionY[positionSetting])
        platformX.append(trueX)
        platformY.append(trueY + 5)
        platform.size = platformSize
            platform.position = CGPoint(x: trueX, y: trueY)
            platform.isUserInteractionEnabled = false
            platform.name = "p_\(positionSetting + 1)"
        platform.zPosition = 0
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
        crate.name = "C_0"
        timer.name = "T_0"
        addChild(crate)
        addChild(timer)
    }
    
    
    override func didMove(to view: SKView) {
        let backgroundImage = SKSpriteNode(imageNamed: "woodgrain")
        backgroundImage.size = self.size
        backgroundImage.isUserInteractionEnabled = false
        backgroundImage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        backgroundImage.name = "BG"
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
        self.name = "view"
        spawnCrate()
        startTimer()
        for i in 0...8 {
        platforms(positionSetting: i)
        }
    if let savedObjects = saveData.array(forKey: "itemsSaved") as? [Int] {
        items = savedObjects
        for i in 0...8 {

        if savedObjects[i] != 0 {
            spawnObject(levelMod: savedObjects[i], platformPos: CGPoint(x: platformX[i], y: platformY[i]) , platformSpot: i)
            }
            }
        }
    }
}
