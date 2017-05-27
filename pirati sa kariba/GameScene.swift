//
//  GameScene.swift
//  pirati sa kariba
//
//  Created by Petar Djordjevic on 5/12/17.
//  Copyright © 2017 g11. All rights reserved.
//

import SpriteKit
import GameplayKit

 var CounterOfBlackShip1 = 0
 var CounterOfBlackShip2 = 0
 var CounterOfBlackShip3 = 0
 var CounterOfRedShip = 0
 var CounterOfCannon1 = 0
 var CounterOfCannon2 = 0
 var CounterOfCannon3 = 0
 var CounterOfCannon4 = 0
 var CounterOfCannon5 = 0
 var OverAllCounter = 0

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}
extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    func normalized() -> CGPoint {
        return self / length()
    }
}

    struct MomentOfColision {
        static let ShipRed: UInt32 = 0b10000000000
        static let ProjectileRed: UInt32 = 2
        static let ProjectileBlack1: UInt32 = 4
        static let ShipBlack1: UInt32 = 0b100
        static let ProjectileBlack2: UInt32 = 8
        static let ShipBlack2: UInt32 = 0b1000
        static let ProjectileBlack3: UInt32 = 16
        static let ShipBlack3: UInt32 = 0b10000
        static let ProjectileCannon1: UInt32 = 32
        static let Cannon1: UInt32 = 0b100000
        static let ProjectileCannon2: UInt32 = 64
        static let Cannon2: UInt32 = 0b1000000
        static let ProjectileCannon3: UInt32 = 128
        static let Cannon3: UInt32 = 0b10000000
        static let ProjectileCannon5: UInt32 = 256
        static let Cannon5: UInt32 = 0b100000000
        static let ProjectileCannon4: UInt32 = 512
        static let Cannon4: UInt32 = 0b1000000000
    }

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var blackShip1: SKSpriteNode!
    var blackShip2: SKSpriteNode!
    var blackShip3: SKSpriteNode!
    var redShip: SKSpriteNode!
    var cannon1: SKSpriteNode!
    var cannon2: SKSpriteNode!
    var cannon3: SKSpriteNode!
    var cannon4: SKSpriteNode!
    var cannon5: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        blackShip1 = self.childNode(withName: "blackShip1") as! SKSpriteNode
        blackShip2 = self.childNode(withName: "blackShip2") as! SKSpriteNode
        blackShip3 = self.childNode(withName: "blackShip3") as! SKSpriteNode
        redShip = self.childNode(withName: "redShip") as! SKSpriteNode
        cannon1 = self.childNode(withName: "cannon1") as! SKSpriteNode
        cannon2 = self.childNode(withName: "cannon2") as! SKSpriteNode
        cannon3 = self.childNode(withName: "cannon3") as! SKSpriteNode
        cannon4 = self.childNode(withName: "cannon4") as! SKSpriteNode
        cannon5 = self.childNode(withName: "cannon5") as! SKSpriteNode
        cannon5.isHidden = true
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        stopMovingFunc = Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(GameScene.blackShip1Movement), userInfo: nil, repeats: true)
        stopMovingFunc2 = Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameScene.blackShip1Shot), userInfo: nil, repeats: true)
        stopMovingFunc3 = Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(GameScene.blackShip2Movement), userInfo: nil, repeats: true)
        stopMovingFunc4 = Timer.scheduledTimer(timeInterval: TimeInterval(2.3), target: self, selector: #selector(GameScene.blackShip2Shot), userInfo: nil, repeats: true)
        stopMovingFunc5 = Timer.scheduledTimer(timeInterval: TimeInterval(2.6), target: self, selector: #selector(GameScene.blackShip3Movement), userInfo: nil, repeats: true)
        stopMovingFunc6 = Timer.scheduledTimer(timeInterval: TimeInterval(2.3), target: self, selector: #selector(GameScene.blackShip3Shot), userInfo: nil, repeats: true)
        stopMovingFunc7 = Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(GameScene.shotCannon1), userInfo: nil, repeats: true)
        stopMovingFunc8 = Timer.scheduledTimer(timeInterval: TimeInterval(3.2), target: self, selector: #selector(GameScene.shotCannon2), userInfo: nil, repeats: true)
        stopMovingFunc9 = Timer.scheduledTimer(timeInterval: TimeInterval(3.5), target: self, selector: #selector(GameScene.shotCannon3), userInfo: nil, repeats: true)
        stopMovingFunc10 = Timer.scheduledTimer(timeInterval: TimeInterval(3.7), target: self, selector: #selector(GameScene.shotCannon4), userInfo: nil, repeats: true)
        stopMovingFunc12 = Timer.scheduledTimer(timeInterval: TimeInterval(2.0), target: self, selector: #selector(GameScene.redShipMovement), userInfo: nil, repeats: true)
        wonGameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01), target: self, selector: #selector(GameScene.winGame), userInfo: nil, repeats: true)
        
    }
    
    func winGame() {
        if  OverAllCounter == 7
        {
            let showAlert = UIAlertController(title: "Congratulations!", message: "You Won!!!", preferredStyle: UIAlertControllerStyle.alert)
            
            showAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action: UIAlertAction!) in
                self.reset()
            }))
            wonGameTimer.invalidate()
            self.view?.window?.rootViewController?.present(showAlert, animated: true, completion: nil)
            OverAllCounter = 0
            CounterOfBlackShip1 = 0
            CounterOfBlackShip2 = 0
            CounterOfBlackShip3 = 0
            CounterOfRedShip = 0
            CounterOfCannon1 = 0
            CounterOfCannon2 = 0
            CounterOfCannon3 = 0
            CounterOfCannon4 = 0
            CounterOfCannon5 = 0
            blackShip1Movement()
            blackShip2Movement()
            blackShip3Movement()
            blackShip1Shot()
            blackShip2Shot()
            blackShip3Shot()
            shotCannon1()
            shotCannon2()
            shotCannon3()
            shotCannon4()
            countingBlackShip1()
            countingBlackShip2()
            countingBlackShip3()
            countingCannon1()
            countingCannon2()
            countingCannon3()
            countingCannon4()
            redShipMovement()
        }
        
    }
    
    func reset() {
        
        if let scene = GameScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.doorsCloseVertical(withDuration: TimeInterval(2)))
        }
        CounterOfBlackShip1 = 0
        CounterOfBlackShip2 = 0
        CounterOfBlackShip3 = 0
        CounterOfRedShip = 0
        CounterOfCannon1 = 0
        CounterOfCannon2 = 0
        CounterOfCannon3 = 0
        CounterOfCannon4 = 0
        CounterOfCannon5 = 0
        blackShip1Movement()
        blackShip2Movement()
        blackShip3Movement()
        blackShip1Shot()
        blackShip2Shot()
        blackShip3Shot()
        shotCannon1()
        shotCannon2()
        shotCannon3()
        shotCannon4()
        countingBlackShip1()
        countingBlackShip2()
        countingBlackShip3()
        countingCannon1()
        countingCannon2()
        countingCannon3()
        countingCannon4()
        redShipMovement()
        OverAllCounter = 0
    }
    var wonGameTimer = Timer()
    var stopMovingFunc = Timer()
    var stopMovingFunc2 = Timer()
    var stopMovingFunc3 = Timer()
    var stopMovingFunc4 = Timer()
    var stopMovingFunc5 = Timer()
    var stopMovingFunc6 = Timer()
    var stopMovingFunc7 = Timer()
    var stopMovingFunc8 = Timer()
    var stopMovingFunc9 = Timer()
    var stopMovingFunc10 = Timer()
    var stopMovingFunc11 = Timer()
    var stopMovingFunc12 = Timer()
    
    func DestroyRedShip() {
        redShip.removeFromParent()
    }
    func DestroyBlackShip1() {
        blackShip1.removeFromParent()
    }
    func DestroyBlackShip2() {
        blackShip2.removeFromParent()
    }
    func DestroyBlackShip3() {
        blackShip3.removeFromParent()
    }
    func DestroyCannon1() {
        cannon1.removeFromParent()
    }
    func DestroyCannon2() {
        cannon2.removeFromParent()
    }
    func DestroyCannon3() {
        cannon3.removeFromParent()
    }
    func DestroyCannon4() {
        cannon4.removeFromParent()
    }
    func DestroyCannon5() {
        cannon5.removeFromParent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        if touchLocation.y < CGFloat(-80) {
            let ProjectileMove = SKAction.move(to: touchLocation, duration: TimeInterval(1.0))
            
            redShip.physicsBody = SKPhysicsBody(rectangleOf: redShip.size)
            redShip.physicsBody?.isDynamic = true
            redShip.physicsBody?.categoryBitMask = MomentOfColision.ShipRed
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileBlack1
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileBlack2
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileBlack3
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon1
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon2
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon3
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon4
            redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon5
            
            redShip.run(SKAction.sequence([ProjectileMove]))
        }
        if touchLocation.y > CGFloat(0) {
            let redProjectile = SKSpriteNode(imageNamed: "cannonBall.png")
            redProjectile.position = redShip.position
            let redShot = touchLocation - redProjectile.position
            let directionOfRedShot = redShot.normalized()
            let PowerOfRedShot = directionOfRedShot * 1000
            let DestinationOfRedShot = redProjectile.position + PowerOfRedShot
            let redShotIsFinished = SKAction.move(to: DestinationOfRedShot, duration: 2)
            let DeleteRedShot = SKAction.removeFromParent()
            
            redProjectile.physicsBody = SKPhysicsBody(circleOfRadius: redProjectile.size.width/2)
            redProjectile.physicsBody?.isDynamic = true
            redProjectile.physicsBody?.categoryBitMask = MomentOfColision.ProjectileRed
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.ShipBlack1
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.ShipBlack2
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.ShipBlack3
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.Cannon1
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.Cannon2
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.Cannon3
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.Cannon4
            redProjectile.physicsBody?.contactTestBitMask = MomentOfColision.Cannon5
            redProjectile.physicsBody?.usesPreciseCollisionDetection = true
            redProjectile.zPosition = 5
            addChild(redProjectile)
            
            redProjectile.run(SKAction.sequence([redShotIsFinished,DeleteRedShot]))
        }
    }
    
    func redShipMovement() {
        redShip.physicsBody = SKPhysicsBody(rectangleOf: redShip.size)
        redShip.physicsBody?.isDynamic = true
        redShip.physicsBody?.categoryBitMask = MomentOfColision.ShipRed
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileBlack1
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileBlack2
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileBlack3
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon1
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon2
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon3
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon4
        redShip.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileCannon5
    }
    
    func blackShip1Movement() {
        let actuelX = randomShipMovement(min: -285 , max: -150)
        let actuelY = randomShipMovement(min: 150 , max: 220)
        let TimeShipMovement = randomShipMovement(min: CGFloat(1.0), max: CGFloat(3.0))
        let BlackShipMove = SKAction.move(to: CGPoint(x: actuelX, y: actuelY), duration: TimeInterval(TimeShipMovement))
        
        blackShip1.physicsBody = SKPhysicsBody(rectangleOf: blackShip1.size)
        blackShip1.physicsBody?.isDynamic = true
        blackShip1.physicsBody?.categoryBitMask = MomentOfColision.ShipBlack1
        blackShip1.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
        
        blackShip1.run(SKAction.sequence([BlackShipMove]))
    }
    func blackShip1Shot() {
        if blackShip1.frame.origin.y - 500 <=  redShip.frame.origin.y {
            print("i am in the black ship 1 loop")
            let blackProjectile = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile.position = blackShip1.position
            let blackShot = blackProjectile.position
            let directionBlackShot = blackShot.normalized()
            let destinationBlackShot = redShip.position
            let blackShotMove = SKAction.move(to: destinationBlackShot, duration: 2)
            let deleteBlackShotMove = SKAction.removeFromParent()
            
            blackProjectile.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile.size.width/2)
            blackProjectile.physicsBody?.isDynamic = true
            blackProjectile.physicsBody?.categoryBitMask = MomentOfColision.ProjectileBlack1
            blackProjectile.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile.zPosition = 5
            addChild(blackProjectile)
            
            blackProjectile.run(SKAction.sequence([blackShotMove,deleteBlackShotMove]))
        }
    }
    
    func blackShip2Movement() {
        let actuelX = randomShipMovement(min: 285 , max: 150)
        let actuelY = randomShipMovement(min: 150 , max: 220)
        let TimeShipMovement2 = randomShipMovement(min: CGFloat(1.0), max: CGFloat(3.0))
        let blackShipMove2 = SKAction.move(to: CGPoint(x: actuelX, y: actuelY), duration: TimeInterval(TimeShipMovement2))
        
        blackShip2.physicsBody = SKPhysicsBody(rectangleOf: blackShip2.size)
        blackShip2.physicsBody?.isDynamic = true
        blackShip2.physicsBody?.categoryBitMask = MomentOfColision.ShipBlack2
        blackShip2.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
        
        blackShip2.run(SKAction.sequence([blackShipMove2]))
    }
    func blackShip2Shot() {
        if blackShip2.frame.origin.y - 500 <=  redShip.frame.origin.y {
            print("i am in the black ship 2 loop")
            let blackProjectile2 = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile2.position = blackShip2.position
            let blackShot2 = blackProjectile2.position
            let directionBlackShot2 = blackShot2.normalized()
            let destinationBlackShot2 = redShip.position
            let blackShot2Move = SKAction.move(to: destinationBlackShot2, duration: 2)
            let deleteBlackShot2Move = SKAction.removeFromParent()
            
            blackProjectile2.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile2.size.width/2)
            blackProjectile2.physicsBody?.isDynamic = true
            blackProjectile2.physicsBody?.categoryBitMask = MomentOfColision.ProjectileBlack2
            blackProjectile2.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile2.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile2.zPosition = 5
            addChild(blackProjectile2)
            
            blackProjectile2.run(SKAction.sequence([blackShot2Move,deleteBlackShot2Move]))
        }
    }
    
    func blackShip3Movement() {
        let actuelX = randomShipMovement(min: -50 , max: 50)
        let actuelY = randomShipMovement(min: 170 , max: 250)
        let timeShipMovement3 = randomShipMovement(min: CGFloat(1.0), max: CGFloat(3.0))
        let blackShipMove3 = SKAction.move(to: CGPoint(x: actuelX, y: actuelY), duration: TimeInterval(timeShipMovement3))
        
        blackShip3.physicsBody = SKPhysicsBody(rectangleOf: blackShip3.size)
        blackShip3.physicsBody?.isDynamic = true
        blackShip3.physicsBody?.categoryBitMask = MomentOfColision.ShipBlack3
        blackShip3.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
        
        blackShip3.run(SKAction.sequence([blackShipMove3]))
    }
    func blackShip3Shot() {
        if blackShip3.frame.origin.y - 500 <=  redShip.frame.origin.y  {
            print("i am in the black ship 3 loop")
            let blackProjectile3 = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile3.position = blackShip3.position
            let blackShot3 = blackProjectile3.position
            let directionBlackShot3 = blackShot3.normalized()
            let destinationBlackShot3 = redShip.position
            let blackShot3Move = SKAction.move(to: destinationBlackShot3, duration: 2)
            let deleteBlackShot3Move = SKAction.removeFromParent()
            
            blackProjectile3.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile3.size.width/2)
            blackProjectile3.physicsBody?.isDynamic = true
            blackProjectile3.physicsBody?.categoryBitMask = MomentOfColision.ProjectileBlack3
            blackProjectile3.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile3.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile3.zPosition = 5
            addChild(blackProjectile3)
            
            blackProjectile3.run(SKAction.sequence([blackShot3Move,deleteBlackShot3Move]))
        }
        
    }
    func shotCannon1() {
        if cannon1.frame.origin.y - 950 <=  redShip.frame.origin.y  {
            print("i am in the loop of cannon 1")
            let blackProjectile4 = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile4.position = cannon1.position
            let blackShot4 = blackProjectile4.position
            let directionBlackShot4 = blackShot4.normalized()
            let destinationBlackShot4 = redShip.position
            let blackShot4Move = SKAction.move(to: destinationBlackShot4, duration: 3.33)
            let deleteBlackShot4Move = SKAction.removeFromParent()
            
            cannon1.physicsBody = SKPhysicsBody(rectangleOf: cannon1.size)
            cannon1.physicsBody?.isDynamic = false
            cannon1.physicsBody?.categoryBitMask = MomentOfColision.Cannon1
            cannon1.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
            
            blackProjectile4.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile4.size.width/2)
            blackProjectile4.physicsBody?.isDynamic = true
            blackProjectile4.physicsBody?.categoryBitMask = MomentOfColision.ProjectileCannon1
            blackProjectile4.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile4.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile4.zPosition = 5
            addChild(blackProjectile4)
            
            blackProjectile4.run(SKAction.sequence([blackShot4Move,deleteBlackShot4Move]))
        }
    }
    func shotCannon2() {
        if cannon2.frame.origin.y - 950 <=  redShip.frame.origin.y  {
            print("i am in the loop of cannon 2")
            let blackProjectile5 = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile5.position = cannon2.position
            let blackShot5 = blackProjectile5.position
            let directionBlackShot5 = blackShot5.normalized()
            let destinationBlackShot5 = redShip.position
            let blackShot5Move = SKAction.move(to: destinationBlackShot5, duration: 3.1)
            let deleteBlackShot5Move = SKAction.removeFromParent()
            
            cannon2.physicsBody = SKPhysicsBody(rectangleOf: cannon2.size)
            cannon2.physicsBody?.isDynamic = false
            cannon2.physicsBody?.categoryBitMask = MomentOfColision.Cannon2
            cannon2.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
            
            blackProjectile5.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile5.size.width/2)
            blackProjectile5.physicsBody?.isDynamic = true
            blackProjectile5.physicsBody?.categoryBitMask = MomentOfColision.ProjectileCannon2
            blackProjectile5.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile5.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile5.zPosition = 5
            addChild(blackProjectile5)
            
            blackProjectile5.run(SKAction.sequence([blackShot5Move,deleteBlackShot5Move]))
        }
    }
    func shotCannon3() {
        if cannon3.frame.origin.y - 950 <=  redShip.frame.origin.y  {
            print("i am in the loop of cannon 3")
            let blackProjectile6 = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile6.position = cannon3.position
            let blackShot6 = blackProjectile6.position
            let directionBlackShot6 = blackShot6.normalized()
            let destinationBlackShot6 = redShip.position
            let blackShot6Move = SKAction.move(to: destinationBlackShot6, duration: 3.7)
            let deleteBlackShot6Move = SKAction.removeFromParent()
            
            cannon3.physicsBody = SKPhysicsBody(rectangleOf: cannon3.size)
            cannon3.physicsBody?.isDynamic = false
            cannon3.physicsBody?.categoryBitMask = MomentOfColision.Cannon3
            cannon3.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
            
            blackProjectile6.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile6.size.width/2)
            blackProjectile6.physicsBody?.isDynamic = true
            blackProjectile6.physicsBody?.categoryBitMask = MomentOfColision.ProjectileCannon3
            blackProjectile6.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile6.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile6.zPosition = 5
            addChild(blackProjectile6)
            
            blackProjectile6.run(SKAction.sequence([blackShot6Move,deleteBlackShot6Move]))
        }
    }
    func shotCannon4() {
        if cannon4.frame.origin.y - 950 <=  redShip.frame.origin.y  {
            print("i am in the loop of cannon 4")
            let blackProjectile7 = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile7.position = cannon4.position
            let blackShot7 = blackProjectile7.position
            let directionBlackShot7 = blackShot7.normalized()
            let destinationBlackShot7 = redShip.position
            let blackShot7Move = SKAction.move(to: destinationBlackShot7, duration: 3.5)
            let deleteBlackShot7Move = SKAction.removeFromParent()
            
            cannon4.physicsBody = SKPhysicsBody(rectangleOf: cannon4.size)
            cannon4.physicsBody?.isDynamic = false
            cannon4.physicsBody?.categoryBitMask = MomentOfColision.Cannon4
            cannon4.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
            
            blackProjectile7.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile7.size.width/2)
            blackProjectile7.physicsBody?.isDynamic = true
            blackProjectile7.physicsBody?.categoryBitMask = MomentOfColision.ProjectileCannon4
            blackProjectile7.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile7.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile7.zPosition = 5
            addChild(blackProjectile7)
            
            blackProjectile7.run(SKAction.sequence([blackShot7Move,deleteBlackShot7Move]))
        }
    }
    func shotCannon5() {
        if cannon5.frame.origin.y - 950 <=  redShip.frame.origin.y  {
            print("i am in the loop of cannon 5")
            let blackProjectile8 = SKSpriteNode(imageNamed: "cannonBall.png")
            blackProjectile8.position = cannon5.position
            let blackShot8 = blackProjectile8.position
            let directionBlackShot8 = blackShot8.normalized()
            let destinationBlackShot8 = redShip.position
            let blackShot8Move = SKAction.move(to: destinationBlackShot8, duration: 3.5)
            let deleteBlackShot8Move = SKAction.removeFromParent()
            
            cannon5.physicsBody = SKPhysicsBody(rectangleOf: cannon5.size)
            cannon5.physicsBody?.isDynamic = false
            cannon5.physicsBody?.categoryBitMask = MomentOfColision.Cannon5
            cannon5.physicsBody?.contactTestBitMask = MomentOfColision.ProjectileRed
            
            blackProjectile8.physicsBody = SKPhysicsBody(circleOfRadius: blackProjectile8.size.width/2)
            blackProjectile8.physicsBody?.isDynamic = true
            blackProjectile8.physicsBody?.categoryBitMask = MomentOfColision.ProjectileCannon5
            blackProjectile8.physicsBody?.contactTestBitMask = MomentOfColision.ShipRed
            blackProjectile8.physicsBody?.usesPreciseCollisionDetection = true
            blackProjectile8.zPosition = 5
            addChild(blackProjectile8)
            
            blackProjectile8.run(SKAction.sequence([blackShot8Move,deleteBlackShot8Move]))
        }
    }
    
    func countingBlackShip1() {
        if CounterOfBlackShip1 == 10 {
            blackShip1.texture = SKTexture(imageNamed: "brodCrni2.png")
        } else if CounterOfBlackShip1 == 20 {
            blackShip1.texture = SKTexture(imageNamed: "brodCrni3.png")
        } else if CounterOfBlackShip1 >= 30 {
            blackShip1.texture = SKTexture(imageNamed: "brodCrni4.png")
            stopMovingFunc.invalidate()
            stopMovingFunc2.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameScene.DestroyBlackShip1), userInfo: nil, repeats: false)
            OverAllCounter += 1
        }
    }
    func countingBlackShip2() {
        if CounterOfBlackShip2 == 10 {
            blackShip2.texture = SKTexture(imageNamed: "brodCrni2.png")
        } else if CounterOfBlackShip2 == 20 {
            blackShip2.texture = SKTexture(imageNamed: "brodCrni3.png")
        } else if CounterOfBlackShip2 >= 30 {
            blackShip2.texture = SKTexture(imageNamed: "brodCrni4.png")
            stopMovingFunc3.invalidate()
            stopMovingFunc4.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameScene.DestroyBlackShip2), userInfo: nil, repeats: false)
            OverAllCounter += 1
        }
    }
    func countingBlackShip3() {
        if CounterOfBlackShip3 == 10 {
            blackShip3.texture = SKTexture(imageNamed: "brodCrni2.png")
        } else if CounterOfBlackShip3 == 20 {
            blackShip3.texture = SKTexture(imageNamed: "brodCrni3.png")
        } else if CounterOfBlackShip3 >= 30 {
            blackShip3.texture = SKTexture(imageNamed: "brodCrni4.png")
            stopMovingFunc5.invalidate()
            stopMovingFunc6.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameScene.DestroyBlackShip3), userInfo: nil, repeats: false)
            OverAllCounter += 1
        }
    }
    func countingCannon1() {
        if CounterOfCannon1 == 10 {
            cannon1.texture = SKTexture(imageNamed: "cannonLoose")
            stopMovingFunc7.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameScene.DestroyCannon1), userInfo: nil, repeats: false)
            OverAllCounter += 1
        }
    }
    func countingCannon2() {
        if CounterOfCannon2 == 10 {
            cannon2.texture = SKTexture(imageNamed: "cannonLoose")
            stopMovingFunc8.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameScene.DestroyCannon2), userInfo: nil, repeats: false)
            OverAllCounter += 1
        }
    }
    func countingCannon3() {
        if CounterOfCannon3 == 10 {
            cannon3.texture = SKTexture(imageNamed: "cannonLoose")
            stopMovingFunc9.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameScene.DestroyCannon3), userInfo: nil, repeats: false)
            OverAllCounter += 1
        }
    }
    func countingCannon4() {
        if CounterOfCannon4 == 10 {
            cannon4.texture = SKTexture(imageNamed: "cannonLoose")
            stopMovingFunc10.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(0), target: self, selector: #selector(GameScene.DestroyCannon4), userInfo: nil, repeats: false)
            OverAllCounter += 1
        }
    }
    
    func countingCannon5() {
        if CounterOfCannon5 == 10 {
            cannon5.texture = SKTexture(imageNamed: "cannonLoose")
            stopMovingFunc11.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameScene.DestroyCannon5), userInfo: nil, repeats: false)
        }
        
    }
    
    func countingRedShip() {
        if CounterOfRedShip == 15 {
            redShip.texture = SKTexture(imageNamed: "brodCrveni2.png")
        } else if CounterOfRedShip == 30 {
            redShip.texture = SKTexture(imageNamed: "brodCrveni3.png")
        } else if CounterOfRedShip >= 50 {
            redShip.texture = SKTexture(imageNamed: "brodCrveni4.png")
            
            stopMovingFunc12.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameScene.DestroyRedShip), userInfo: nil, repeats: false)
            
            let showAlert = UIAlertController(title: "GAME OVER", message: "You Lost!!!", preferredStyle: UIAlertControllerStyle.alert)
            
            showAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action: UIAlertAction!) in
                self.reset()
            }))
            self.view?.window?.rootViewController?.present(showAlert, animated: true, completion: nil)
        }
        
    }
    
    func randomShipMovement(min: CGFloat, max: CGFloat) -> CGFloat {
        return randomNumber() * (max - min) + min
    }
    
    func randomNumber() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UInt32.max))
    }
    
    func projectileColisionedWithShip1(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    func projectileColisionedWithShip2(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    func projectileColisionedWithShip3(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    func projectileColisionedWithCannon1(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    func projectileColisionedWithCannon2(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    func projectileColisionedWithCannon3(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    func projectileColisionedWithCannon4(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    func projectileColisionedWithCannon5(projectileNode: SKSpriteNode, shipNode: SKSpriteNode) {
        projectileNode.removeFromParent()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileBlack1 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("black ship 1 has hitted red ship")
            projectileColisionedWithShip1(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipBlack1 != 0)) {
            print("red ship has hitted black ship 1")
            projectileColisionedWithShip1(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfBlackShip1 += 1
            countingBlackShip1()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileBlack2 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("black ship 2 has hitted red ship")
            projectileColisionedWithShip2(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipBlack2 != 0)) {
            print("red ship has hitted black ship 2")
            projectileColisionedWithShip2(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfBlackShip2 += 1
            countingBlackShip2()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileBlack3 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("black ship 3 has hitted red ship")
            projectileColisionedWithShip3(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipBlack3 != 0)) {
            print("red ship has hitted black ship 3")
            projectileColisionedWithShip3(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfBlackShip3 += 1
            countingBlackShip3()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileCannon1 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("cannon 1 hitted red ship")
            projectileColisionedWithCannon1(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.Cannon1 != 0)) {
            print("red ship has hitted cannon 1")
            projectileColisionedWithCannon1(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfCannon1 += 1
            countingCannon1()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileCannon2 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("cannon 2 hitted red ship")
            projectileColisionedWithCannon2(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.Cannon2 != 0)) {
            print("red ship has hitted cannon 2")
            projectileColisionedWithCannon2(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfCannon2 += 1
            countingCannon2()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileCannon3 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("cannon 3 hitted red ship")
            projectileColisionedWithCannon3(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.Cannon3 != 0)) {
            print("red ship has hitted cannon 3")
            projectileColisionedWithCannon3(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfCannon3 += 1
            countingCannon3()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileCannon4 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("cannon 4 hitted red ship")
            projectileColisionedWithCannon4(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.Cannon4 != 0)) {
            print("red ship has hitted cannon 4")
            projectileColisionedWithCannon4(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfCannon4 += 1
            countingCannon4()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileCannon5 != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.ShipRed != 0)) {
            print("cannon 5 hitted red ship")
            projectileColisionedWithCannon5(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfRedShip += 1
            countingRedShip()
        }
        if ((firstBody.categoryBitMask & MomentOfColision.ProjectileRed != 0) &&
            (secondBody.categoryBitMask & MomentOfColision.Cannon5 != 0)) {
            print("red ship has hitted cannon 5")
            projectileColisionedWithCannon5(projectileNode: firstBody.node as! SKSpriteNode, shipNode: secondBody.node as! SKSpriteNode)
            CounterOfCannon5 += 1
            countingCannon5()
        }

    }
  
    
}






