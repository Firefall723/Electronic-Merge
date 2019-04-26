//
//  GameViewController.swift
//  Electronic Merge
//
//  Created by GERARDO LOZOYA on 4/24/19.
//  Copyright © 2019 CLC.Gerardo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene.init(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)

}
}
