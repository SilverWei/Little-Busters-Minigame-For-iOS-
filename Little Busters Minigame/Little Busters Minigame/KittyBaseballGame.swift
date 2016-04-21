//
//  KittyBaseballGame.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/11.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit

class KittyBaseballGame: SKScene, SKPhysicsContactDelegate {
    
    let GameView = SKNode()
    var TouchAmount = 0 //监测触摸数量
    var DateTime: NSTimeInterval = 0
    var LastDateTime: NSTimeInterval = 0
    
    //MARK: 初始化物体
    let Baseballfield = GameObject().Baseballfield()
    
    let Baseball = GameObject().Baseball()
    var Baseball_Status = GameObject.Baseball_Status.B_Static
    var Baseball_UpDown = GameObject.Baseball_UpDown.B_Static
    var Baseball_Power = GameObject.Baseball_Power(ball_x: 0,ball_y: 0,height: 0,length: 0)
    var Baseball_Shadow = SKShapeNode()
    
    //MARK: 初始化角色
    //直枝 理樹
    var Naoe_Riki = GameCharacter.Unit(attribute: GameCharacter().Naoe_Riki_Attribute,
        image: GameCharacter().Naoe_Riki_Array()
    )
    var Naoe_Riki_View = SKSpriteNode(texture: SKTexture(image: GameCharacter().Naoe_Riki_Array()[0]))
    var Naoe_Riki_Shadow = SKShapeNode()
    var Naoe_Riki_Range = GameCharacter().Naoe_Riki_Range()
    
    //棗 鈴
    var Natsume_Rin = GameCharacter.Unit(attribute: GameCharacter().Natsume_Rin_Attribute,
        image: GameCharacter().Natsume_Rin_Array()
    )
    var Natsume_Rin_View = SKSpriteNode(texture: SKTexture(image: GameCharacter().Natsume_Rin_Array()[0]))
    var Natsume_Rin_Shadow = SKShapeNode()
    
    
    //MARK: 初始化按钮
    var MovingButton_Status = MovingButton_Touch.Stop
    let MovingButton = GameObject().MovingButton()
    let MovingButton_UP = GameObject().MovingButton_UP()
    let MovingButton_Down = GameObject().MovingButton_Down()
    let MovingButton_Left = GameObject().MovingButton_Left()
    let MovingButton_Right = GameObject().MovingButton_Right()
    
    let TestButton = GameObject().TestButton()
    
    //MARK: 图层
    enum Layers: CGFloat{
        case Baseballfield //棒球场背景
        case shadow //阴影
        case OtherBody //其他物件
        case Cat //猫
        case CharacterBehind //在后面的人物
        case Baseball //棒球
        case CharacterFront //在前面的人物
        case Button //按钮
    }
    
    //MARK: 物理层
    struct Collision {
        static let null: UInt32 = 0
        static let Baseball: UInt32 = 0b1
        static let BaseballBat: UInt32 = 0b10
        static let CharacterFront: UInt32 = 0b100
    }
    
    //MARK: 按钮状态
    enum MovingButton_Touch: CGFloat{
        case Stop
        case UP
        case Down
        case Left
        case Right
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //关掉重力
        physicsWorld.gravity = CGVectorMake(0, 0)
        
        //设置碰撞代理
        physicsWorld.contactDelegate = self
        
        addChild(GameView)
        Show_Baseballfield()//显示棒球场背景
        Show_CharacterFront()//显示在前面的人物
        Show_CharacterBehind()//显示在后面的人物
        Show_Shadow()//显示阴影
        Show_Button()//显示按钮
        Show_Baseball()//显示棒球
    }
    
    func Show_Baseballfield(){
        Baseballfield.position = CGPoint(x: size.width / 2 + 20, y: size.height / 2 - 30)
        GameView.addChild(Baseballfield)
    }
    
    func Show_CharacterFront(){
        Naoe_Riki_View.position = Naoe_Riki.attribute.point
        Naoe_Riki_View.zPosition = Layers.CharacterFront.rawValue
        Baseballfield.addChild(Naoe_Riki_View)
        
        Naoe_Riki_Range.zPosition = Layers.CharacterFront.rawValue
        Baseballfield.addChild(Naoe_Riki_Range)
    }
    
    func Show_CharacterBehind(){
        Natsume_Rin_View.position = Natsume_Rin.attribute.point
        Natsume_Rin_View.zPosition = Layers.CharacterBehind.rawValue
        Baseballfield.addChild(Natsume_Rin_View)
    }
    
    func Show_Baseball(){
        Baseball.zPosition = Layers.Baseball.rawValue        
        Baseballfield.addChild(Baseball)
        Baseball.hidden = true
    }
    
    func Show_Shadow(){
        Naoe_Riki_Shadow = GameObject().Shadow(Naoe_Riki.attribute.point.x + Naoe_Riki.attribute.Shadow_x, y: Naoe_Riki.attribute.point.y + Naoe_Riki.attribute.Shadow_y, w: Naoe_Riki.attribute.Shadow_w, h: Naoe_Riki.attribute.Shadow_h)
        Baseballfield.addChild(Naoe_Riki_Shadow)
        
        Natsume_Rin_Shadow = GameObject().Shadow(Natsume_Rin.attribute.point.x + Natsume_Rin.attribute.Shadow_x, y: Natsume_Rin.attribute.point.y + Natsume_Rin.attribute.Shadow_y, w: Natsume_Rin.attribute.Shadow_w, h: Natsume_Rin.attribute.Shadow_h)
        Baseballfield.addChild(Natsume_Rin_Shadow)
        
        Baseball_Shadow = GameObject().Shadow(Baseball.position.x, y: Baseball.position.y, w: Baseball.frame.width, h: Baseball.frame.height / 2)
        Baseballfield.addChild(Baseball_Shadow)
        Baseball_Shadow.hidden = true
        
    }
    
    func Show_Button(){
        MovingButton.zPosition = Layers.Button.rawValue
        MovingButton.addChild(MovingButton_UP)
        MovingButton.addChild(MovingButton_Down)
        MovingButton.addChild(MovingButton_Left)
        MovingButton.addChild(MovingButton_Right)
        GameView.addChild(MovingButton)
        
        
        TestButton.zPosition = Layers.Button.rawValue
        GameView.addChild(TestButton)
    }

    
    //MARK: 点击
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if MovingButton_UP.containsPoint(location) {
                MovingButton_Status = .UP
                MovingButton_UP.fillColor = SKColor.whiteColor()
            }
            else if MovingButton_Down.containsPoint(location) {
                MovingButton_Status = .Down
                MovingButton_Down.fillColor = SKColor.whiteColor()
            }
            else if MovingButton_Left.containsPoint(location) {
                MovingButton_Status = .Left
                MovingButton_Left.fillColor = SKColor.whiteColor()
            }
            else if MovingButton_Right.containsPoint(location) {
                MovingButton_Status = .Right
                MovingButton_Right.fillColor = SKColor.whiteColor()
            }
            else if TestButton.containsPoint(location){
                if(Baseball_Status != GameObject.Baseball_Status.B_Cast){
                    self.Natsume_Rin.attribute.status = GameCharacter.Natsume_Rin_Status.NR_Swing.hashValue
                    self.Baseball_Status = GameObject.Baseball_Status.B_Cast
                }
            }
            else{
                Naoe_Riki.attribute.status = GameCharacter.Naoe_Riki_Status.NR_Swing.hashValue
            }
        }
        if(++TouchAmount > 2){
            TouchAmount = 2
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            AllButtonColorClear()
            
            if MovingButton_UP.containsPoint(location) {
                MovingButton_Status = .UP
                MovingButton_UP.fillColor = SKColor.whiteColor()
            }
            else if MovingButton_Down.containsPoint(location) {
                MovingButton_Status = .Down
                MovingButton_Down.fillColor = SKColor.whiteColor()
            }
            else if MovingButton_Left.containsPoint(location) {
                MovingButton_Status = .Left
                MovingButton_Left.fillColor = SKColor.whiteColor()
            }
            else if MovingButton_Right.containsPoint(location) {
                MovingButton_Status = .Right
                MovingButton_Right.fillColor = SKColor.whiteColor()
            }
            else{
                MovingButton_Status = .Stop
                
                //移动整个Map
                if(location.y > self.frame.height * 0.25){
                    Baseballfield.position = CGPoint(x: Baseballfield.frame.width * -(location.x / self.frame.width) + Baseballfield.frame.width * 0.55, y: Baseballfield.frame.height * -(location.y / self.frame.height) + Baseballfield.frame.height / 2)
                }
            }
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(--TouchAmount <= 0){
            AllButtonColorClear()
            MovingButton_Status = .Stop
        }
    }
    func AllButtonColorClear(){
        MovingButton_UP.fillColor = SKColor.clearColor()
        MovingButton_Down.fillColor = SKColor.clearColor()
        MovingButton_Left.fillColor = SKColor.clearColor()
        MovingButton_Right.fillColor = SKColor.clearColor()
    }
    
    
    //MARK: 更新
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if LastDateTime > 0{
            DateTime = currentTime - LastDateTime
        }
        else{
            DateTime = 0
        }
        LastDateTime = currentTime
       
        Baseball_Power.ball_x = Baseball_Power.ball_x + CGFloat(DateTime) * 50
        
        //更新人物状态
        Status_Naoe_Riki() //理 树
        Status_Natsume_Rin() //棗 鈴
        Status_Baseball() //棒 球

    }
    
    //MARK: 动作更新
    //MARK: 理 樹
    func Status_Naoe_Riki(){
        switch MovingButton_Status{
        case .UP:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x, y: Naoe_Riki_View.position.y + 1)
            break
        case .Down:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x, y: Naoe_Riki_View.position.y - 1)
            break
        case .Left:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x - 1, y: Naoe_Riki_View.position.y)
            break
        case .Right:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x + 1, y: Naoe_Riki_View.position.y)
            break
        default:
            break
        }
        if(Naoe_Riki_View.position.x < Naoe_Riki_Range.position.x){
            Naoe_Riki_View.position.x = Naoe_Riki_Range.position.x
        }
        if(Naoe_Riki_View.position.x > Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width){
            Naoe_Riki_View.position.x = Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width
        }
        if(Naoe_Riki_View.position.y < Naoe_Riki_Range.position.y){
            Naoe_Riki_View.position.y = Naoe_Riki_Range.position.y
        }
        if(Naoe_Riki_View.position.y > Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height){
            Naoe_Riki_View.position.y = Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height
        }
        Naoe_Riki_Shadow.position = CGPoint(x: Naoe_Riki_View.position.x + Naoe_Riki.attribute.Shadow_x, y: Naoe_Riki_View.position.y + Naoe_Riki.attribute.Shadow_y)
        
        if((actionForKey("Naoe_Riki_SwingAction")) != nil){
            return
        }
        switch Naoe_Riki.attribute.status{
        case GameCharacter.Naoe_Riki_Status.NR_Swing.hashValue:
            if(Naoe_Riki.attribute.imageNumber.hashValue > 9){
                Naoe_Riki.attribute.imageNumber = 0
                Naoe_Riki_View.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber])))
                Naoe_Riki.attribute.status = GameCharacter.Naoe_Riki_Status.NR_Static.hashValue
                return
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue == 3){
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 13, -10)
                CGPathAddLineToPoint(path, nil, 37, -19)
                CGPathAddLineToPoint(path, nil, 21, -29)
                CGPathCloseSubpath(path)
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: path)
            }
            else if(Naoe_Riki.attribute.imageNumber.hashValue == 4){
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 19, -6)
                CGPathAddLineToPoint(path, nil, 48, -5)
                CGPathAddLineToPoint(path, nil, 39, -12)
                CGPathCloseSubpath(path)
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: path)
            }
            else if(Naoe_Riki.attribute.imageNumber.hashValue == 5){
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 15, -3)
                CGPathAddLineToPoint(path, nil, 41, 8)
                CGPathAddLineToPoint(path, nil, 37, -2)
                CGPathCloseSubpath(path)
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: path)
            }
            else{
                Naoe_Riki_View.physicsBody = nil
            }
            Naoe_Riki_View.physicsBody?.categoryBitMask = Collision.BaseballBat
            Naoe_Riki_View.physicsBody?.collisionBitMask = 0
            Naoe_Riki_View.physicsBody?.contactTestBitMask = Collision.Baseball
            
            let Naoe_Riki_Start = SKAction.runBlock(Naoe_Riki_Swing)
            var TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.01)) //帧数刷新延时
            if(Naoe_Riki.attribute.imageNumber.hashValue == 9){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.2))
            }/*
            if(Naoe_Riki.attribute.imageNumber.hashValue == 3){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(2))
            }*/
            let Naoe_Riki_SwingAction = SKAction.sequence([Naoe_Riki_Start,TimeInterval])
            runAction(Naoe_Riki_SwingAction, withKey: "Naoe_Riki_SwingAction")
            break
        default:
            break
        }
    }
    func Naoe_Riki_Swing(){
        Naoe_Riki_View.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber++])))
    }
    
    //MARK: 棗 鈴
    func Status_Natsume_Rin(){
        if((actionForKey("Natsume_Rin_SwingAction")) != nil){
            return
        }
        switch Natsume_Rin.attribute.status{
        case GameCharacter.Natsume_Rin_Status.NR_Swing.hashValue:
            if(Natsume_Rin.attribute.imageNumber.hashValue < 9){
                Natsume_Rin.attribute.imageNumber = 9
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue > 15){
                Natsume_Rin.attribute.imageNumber = 0
                Natsume_Rin_View.runAction(SKAction.setTexture(SKTexture(image: Natsume_Rin.image[Natsume_Rin.attribute.imageNumber])))
                Natsume_Rin.attribute.status = GameCharacter.Natsume_Rin_Status.NR_Static.hashValue
                return
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue == 12){
                //球已投出
                Baseball_Cast()
            }
            let Natsume_Rin_Start = SKAction.runBlock(Natsume_Rin_Swing)
            //帧数刷新延时
            var TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.05))
            if(Naoe_Riki.attribute.imageNumber.hashValue == 14){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.5))
            }
            let Natsume_Rin_SwingAction = SKAction.sequence([Natsume_Rin_Start,TimeInterval])
            runAction(Natsume_Rin_SwingAction, withKey: "Natsume_Rin_SwingAction")
            break
        default:
            break
        }
    }
    func Natsume_Rin_Swing(){
        Natsume_Rin_View.runAction(SKAction.setTexture(SKTexture(image: Natsume_Rin.image[Natsume_Rin.attribute.imageNumber++])))
    }
    
    //MARK: 棒球
    func Status_Baseball(){
        
   /*     switch Baseball_UpDown{
        case .B_Up:
            BallSpeed = BallSpeed - Gravity * CGFloat(DateTime)
            if BallSpeed > ClimbingSpeed{
                Baseball_UpDown = .B_Down
            }
            break
        case .B_Down:
            BallSpeed = BallSpeed + Gravity * CGFloat(DateTime)
            if BallSpeed < 0{
                Baseball_UpDown = .B_Static
            }
            break
        case .B_Static:
            break
        }*/
        Baseball_Power.ball_y = (-((Baseball_Power.ball_x * Baseball_Power.ball_x)) + Baseball_Power.length * Baseball_Power.ball_x) / Baseball_Power.height
        if(Baseball_Power.ball_y < 0){
            Baseball_Power.ball_y = 0
        }
        print(Baseball_Power.ball_y)
        Baseball.position = CGPoint(x: Baseball_Shadow.position.x, y: Baseball_Shadow.position.y + Baseball_Power.ball_y)
    }
    
    func Baseball_Cast(){
        Baseball.hidden = false
        Baseball_Shadow.hidden = false

        Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 3, length: 35)
        
        let BallPath = UIBezierPath()
        BallPath.moveToPoint(CGPoint(x: GameObject().Baseball().position.x, y: GameObject().Baseball().position.y))
        BallPath.addLineToPoint(CGPoint(x: Baseball.position.x, y: -(Baseballfield.frame.height * Baseballfield.anchorPoint.y)))
        Baseball_Shadow.runAction(SKAction.followPath(BallPath.CGPath, asOffset: false, orientToPath: true, speed: 500)) {
            self.Baseball.hidden = true
            self.Baseball_Shadow.hidden = true
            self.Baseball_Status = GameObject.Baseball_Status.B_Static
        }
    }
    
    func Baseball_Return(){
        Baseball_Shadow.removeAllActions()
        
        Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 3, length: 35)
        let BallPath = UIBezierPath()
        BallPath.moveToPoint(CGPoint(x: Baseball_Shadow.position.x, y: Baseball_Shadow.position.y))
        BallPath.addLineToPoint(CGPoint(x: Baseball_Shadow.position.x, y: GameObject().Baseball().position.y))
        Baseball_Shadow.runAction(SKAction.followPath(BallPath.CGPath, asOffset: false, orientToPath: true, speed: 500)) {
            self.Baseball.hidden = true
            self.Baseball_Shadow.hidden = true
            self.Baseball_Status = GameObject.Baseball_Status.B_Static
        }
    }
    
    //NARK: 物理撞击
    func didBeginContact(contact: SKPhysicsContact) {
        let ContactUnit = contact.bodyA.categoryBitMask == Collision.Baseball ? contact.bodyB : contact.bodyA
        if ContactUnit.categoryBitMask == Collision.BaseballBat{
            Baseball_Return()
        }
    }
    
}

