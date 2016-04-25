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
    
    var Baseball = [GameObject.Baseball()]
    
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
        Baseball[0].Baseball_Image.zPosition = Layers.Baseball.rawValue
        Baseballfield.addChild(Baseball[0].Baseball_Image)
        Baseball[0].Baseball_Image.hidden = true
        
        //位置单位
        Baseball[0].Baseball_Unit.position = CGPoint(x: Baseball[0].Baseball_Image.position.x, y: Baseball[0].Baseball_Image.position.y)
        Baseballfield.addChild(Baseball[0].Baseball_Unit)
    }
    
    func Show_Shadow(){
        Naoe_Riki_Shadow = GameObject().Shadow(Naoe_Riki.attribute.point.x + Naoe_Riki.attribute.Shadow_x, y: Naoe_Riki.attribute.point.y + Naoe_Riki.attribute.Shadow_y, w: Naoe_Riki.attribute.Shadow_w, h: Naoe_Riki.attribute.Shadow_h)
        Baseballfield.addChild(Naoe_Riki_Shadow)
        
        Natsume_Rin_Shadow = GameObject().Shadow(Natsume_Rin.attribute.point.x + Natsume_Rin.attribute.Shadow_x, y: Natsume_Rin.attribute.point.y + Natsume_Rin.attribute.Shadow_y, w: Natsume_Rin.attribute.Shadow_w, h: Natsume_Rin.attribute.Shadow_h)
        Baseballfield.addChild(Natsume_Rin_Shadow)
        
        Baseball[0].Baseball_Shadow = GameObject().Shadow(Baseball[0].Baseball_Image.position.x, y: Baseball[0].Baseball_Image.position.y, w: Baseball[0].Baseball_Image.frame.width, h: Baseball[0].Baseball_Image.frame.height / 2)
        Baseballfield.addChild(Baseball[0].Baseball_Shadow)
        Baseball[0].Baseball_Shadow.hidden = true
        
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
                if(Baseball[0].Baseball_Status != GameObject.Baseball_Status.B_Cast){
                    self.Natsume_Rin.attribute.status = GameCharacter.Natsume_Rin_Status.NR_Swing.hashValue
                    self.Baseball[0].Baseball_Status = GameObject.Baseball_Status.B_Cast
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
        
        Baseball[0].Baseball_Power.ball_x = Baseball[0].Baseball_Power.ball_x + CGFloat(DateTime) * 50
        
        //更新人物状态
        Status_Naoe_Riki() //理 树
        Status_Natsume_Rin() //棗 鈴
        Status_Baseball(0) //棒 球
        
        //棒球状态
        switch Baseball[0].Baseball_Status{
        case .B_Static:
            break
        case .B_Cast:
            break
        case .B_Return:
            Status_View(Baseball[0].Baseball_Unit.position)
            break
        }

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
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: GameCharacter().Naoe_Riki_Contact()[0])
            }
            else if(Naoe_Riki.attribute.imageNumber.hashValue == 4){
                
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: GameCharacter().Naoe_Riki_Contact()[1])
            }
            else if(Naoe_Riki.attribute.imageNumber.hashValue == 5){
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: GameCharacter().Naoe_Riki_Contact()[2])
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
            }
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
                Baseball_Cast(0)
            }
            let Natsume_Rin_Start = SKAction.runBlock(Natsume_Rin_Swing)
            //帧数刷新延时
            var TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.05))
            
            if(Natsume_Rin.attribute.imageNumber.hashValue == 9){
                Baseballfield.position = GameObject().Baseballfield().position
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue == 10){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(2))
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue == 14){
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
    func Status_Baseball(Baseball_Number: Int){
        
        Baseball[Baseball_Number].Baseball_Power.ball_y = (-(Baseball[Baseball_Number].Baseball_Power.ball_x * Baseball[Baseball_Number].Baseball_Power.ball_x) + Baseball[Baseball_Number].Baseball_Power.length * Baseball[Baseball_Number].Baseball_Power.ball_x) / Baseball[Baseball_Number].Baseball_Power.height
        if(Baseball[Baseball_Number].Baseball_Power.ball_y < 0){
            if Baseball[Baseball_Number].Baseball_Power.height < 25 {
                Baseball[Baseball_Number].Baseball_Power.ball_x = 0
                Baseball[Baseball_Number].Baseball_Power.height = Baseball[Baseball_Number].Baseball_Power.height * 3
            }
            else{
                Baseball[Baseball_Number].Baseball_Power.ball_y = 0
            }
        }
        Baseball[Baseball_Number].Baseball_Image.position = CGPoint(x: Baseball[Baseball_Number].Baseball_Unit.position.x, y: Baseball[Baseball_Number].Baseball_Unit.position.y + Baseball[Baseball_Number].Baseball_Power.ball_y)
        Baseball[Baseball_Number].Baseball_Shadow.position = CGPoint(x: Baseball[0].Baseball_Unit.position.x, y: Baseball[0].Baseball_Unit.position.y)
        
    }
    
    func Baseball_Cast(Baseball_Number:Int){
        Baseball[Baseball_Number].Baseball_Image.hidden = false
        Baseball[Baseball_Number].Baseball_Shadow.hidden = false

        Baseball[Baseball_Number].Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 10, length: 50)
        
        let BallPath = UIBezierPath()
        BallPath.moveToPoint(CGPoint(x: GameObject.Baseball().Baseball_Image.position.x, y: GameObject.Baseball().Baseball_Image.position.y))
        BallPath.addLineToPoint(CGPoint(x: GameObject.Baseball().Baseball_Image.position.x, y: -(Baseballfield.frame.height * Baseballfield.anchorPoint.y)))
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.speedTo(1, duration: 0))
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.followPath(BallPath.CGPath, asOffset: false, orientToPath: false, speed: 400)) {
            self.Baseball_Static(0)
        }
    }
    
    func Baseball_Return(Baseball_Number: Int,contact: CGPoint){
        Baseball[Baseball_Number].Baseball_Unit.removeAllActions()
        
        Baseball[Baseball_Number].Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 3, length: 35)
        let BallPath = UIBezierPath()
        BallPath.moveToPoint(CGPoint(x: Baseball[Baseball_Number].Baseball_Unit.position.x, y: Baseball[Baseball_Number].Baseball_Unit.position.y))
        if Naoe_Riki.attribute.imageNumber.hashValue == 4 {
            let HeightRatio = (contact.x - CGPathGetBoundingBox(GameCharacter().Naoe_Riki_Contact()[0]).minX) / CGPathGetBoundingBox(GameCharacter().Naoe_Riki_Contact()[0]).width
            BallPath.addLineToPoint(CGPoint(x: Baseballfield.frame.width / 2, y: Baseballfield.frame.height * (1 - HeightRatio) - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
        }
        else if Naoe_Riki.attribute.imageNumber.hashValue == 5{
            let WidthRatio = (contact.x - CGPathGetBoundingBox(GameCharacter().Naoe_Riki_Contact()[1]).minX) / CGPathGetBoundingBox(GameCharacter().Naoe_Riki_Contact()[1]).width
            BallPath.addLineToPoint(CGPoint(x: Baseballfield.frame.width * WidthRatio - Baseballfield.frame.width * Baseballfield.anchorPoint.x, y: Baseballfield.frame.height - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
        }
        else{
            let HeightRatio = (contact.x - CGPathGetBoundingBox(GameCharacter().Naoe_Riki_Contact()[2]).minX) / CGPathGetBoundingBox(GameCharacter().Naoe_Riki_Contact()[2]).width
            BallPath.addLineToPoint(CGPoint(x: -Baseballfield.frame.width / 2, y: Baseballfield.frame.height * HeightRatio - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
        }
        Baseball[Baseball_Number].Baseball_Status = .B_Return
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.speedTo(1, duration: 0))
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.followPath(BallPath.CGPath, asOffset: false, orientToPath: false, speed: 500)) {
            self.Baseball_Static(0)
        }
        Baseball[0].Baseball_Unit.runAction(SKAction.speedTo(0, duration: 4), completion: { () -> Void in
            self.Baseball_Static(0)
        })
    }
    func Baseball_Static(Baseball_Number: Int){
        Baseball[Baseball_Number].Baseball_Image.hidden = true
        Baseball[Baseball_Number].Baseball_Shadow.hidden = true
        Baseball[Baseball_Number].Baseball_Status = .B_Static
        Baseball[Baseball_Number].Baseball_Unit.removeAllActions()
    }
    
    //MARK: 视图
    func Status_View(Object_Point: CGPoint){
        //移动整个Map
        Baseballfield.position = CGPoint(x: -Object_Point.x + (size.width / 2), y: -Object_Point.y + (size.height / 2))
    }
    
    
    //MARK: 物理撞击
    func didBeginContact(contact: SKPhysicsContact) {
        let ContactUnit = contact.bodyA.categoryBitMask == Collision.Baseball ? contact.bodyB : contact.bodyA
        if ContactUnit.categoryBitMask == Collision.BaseballBat && Baseball[0].Baseball_Status == GameObject.Baseball_Status.B_Cast{
            Baseball_Return(0, contact: convertPoint(contact.contactPoint, toNode: Naoe_Riki_View))
        }
    }
    
}

