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
    var Baseball_Jumps: CGFloat = 2
    var Baseball_Angle: CGFloat = 0.0
    var Baseball_ReturnPoint: CGPoint = CGPoint.zero
    let BallTrackPath = SKShapeNode()
    
    //MARK: 初始化角色
    //直枝 理樹
    var Naoe_Riki = GamePeople.Unit(attribute: GamePeople().Naoe_Riki_Attribute,image: GamePeople().Naoe_Riki_Array())
    var Naoe_Riki_View = SKSpriteNode(texture: SKTexture(image: GamePeople().Naoe_Riki_Array()[0]))
    var Naoe_Riki_Range = GamePeople().Naoe_Riki_Range()
    
    //棗 鈴
    var Natsume_Rin = GamePeople.Unit(attribute: GamePeople().Natsume_Rin_Attribute,image: GamePeople().Natsume_Rin_Array())
    var Natsume_Rin_View = SKSpriteNode(texture: SKTexture(image: GamePeople().Natsume_Rin_Array()[0]))
    
    //棗 恭介
    var Natsume_Kyousuke = GamePeople.Unit(attribute: GamePeople().Natsume_Kyousuke_Attribute, image: GamePeople().Natsume_Kyousuke_Array())
    var Natsume_Kyousuke_View = SKSpriteNode(texture: SKTexture(image: GamePeople().Natsume_Kyousuke_Array()[0]))
    
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
        case PeopleBehind //在后面的人物
        case Baseball //棒球
        case PeopleFront //在前面的人物
        case Button //按钮
    }
    
    //MARK: 物理层
    struct Collision {
        static let null: UInt32 = 0
        static let Baseball: UInt32 = 0b1
        static let BaseballBat: UInt32 = 0b10
        static let PeopleFront: UInt32 = 0b100
        static let PeopleBehind: UInt32 = 0b101
        static let BallTrackPath: UInt32 = 0b111
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
        Show_PeopleFront()//显示在前面的人物
        Show_PeopleBehind()//显示在后面的人物
        Show_Shadow()//显示阴影
        Show_Button()//显示按钮
        Show_Baseball()//显示棒球
    }
    
    func Show_Baseballfield(){
        GameView.addChild(Baseballfield)
    }
    
    func Show_PeopleFront(){
        Naoe_Riki_View.position = Naoe_Riki.attribute.point
        Naoe_Riki_View.zPosition = Layers.PeopleFront.rawValue
        Naoe_Riki.attribute.Unit.position = Naoe_Riki.attribute.point
        Naoe_Riki.attribute.Unit.addChild(GamePeople().Naoe_Riki_BodyContact())
        Baseballfield.addChild(Naoe_Riki.attribute.Unit)
        Baseballfield.addChild(Naoe_Riki_View)

        Naoe_Riki_Range.zPosition = Layers.PeopleFront.rawValue
        Baseballfield.addChild(Naoe_Riki_Range)
    }
    
    func Show_PeopleBehind(){
        Natsume_Rin_View.position = Natsume_Rin.attribute.point
        Natsume_Rin_View.zPosition = Layers.PeopleBehind.rawValue
        Baseballfield.addChild(Natsume_Rin_View)
        
        Natsume_Kyousuke_View.position = Natsume_Kyousuke.attribute.point
        Natsume_Kyousuke_View.zPosition = Layers.PeopleBehind.rawValue
        Natsume_Kyousuke.attribute.Unit.position = Natsume_Kyousuke_View.position
        Natsume_Kyousuke.attribute.Unit.speed = 0
        Baseballfield.addChild(Natsume_Kyousuke_View)
        Baseballfield.addChild(Natsume_Kyousuke.attribute.Unit)
    }
    
    func Show_Baseball(){
        Baseball[0].Baseball_Image.zPosition = Layers.Baseball.rawValue
        Baseballfield.addChild(Baseball[0].Baseball_Image)
        Baseball[0].Baseball_Image.hidden = true
        
        //位置单位
        Baseball[0].Baseball_Unit.position = Baseball[0].Baseball_Image.position
        Baseballfield.addChild(Baseball[0].Baseball_Unit)
    }
    
    func Show_Shadow(){
        Naoe_Riki.attribute.Shadow = GameObject().Shadow(Naoe_Riki.attribute.point.x + Naoe_Riki.attribute.Shadow_x, y: Naoe_Riki.attribute.point.y + Naoe_Riki.attribute.Shadow_y, w: Naoe_Riki.attribute.Shadow_w, h: Naoe_Riki.attribute.Shadow_h)
        Baseballfield.addChild(Naoe_Riki.attribute.Shadow)
        
        Natsume_Rin.attribute.Shadow = GameObject().Shadow(Natsume_Rin.attribute.point.x + Natsume_Rin.attribute.Shadow_x, y: Natsume_Rin.attribute.point.y + Natsume_Rin.attribute.Shadow_y, w: Natsume_Rin.attribute.Shadow_w, h: Natsume_Rin.attribute.Shadow_h)
        Baseballfield.addChild(Natsume_Rin.attribute.Shadow)
        
        Natsume_Kyousuke.attribute.Shadow = GameObject().Shadow(Natsume_Kyousuke.attribute.point.x + Natsume_Kyousuke.attribute.Shadow_x, y: Natsume_Kyousuke.attribute.point.y + Natsume_Kyousuke.attribute.Shadow_y, w: Natsume_Kyousuke.attribute.Shadow_w, h: Natsume_Kyousuke.attribute.Shadow_h)
        Baseballfield.addChild(Natsume_Kyousuke.attribute.Shadow)
        
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
                if(Baseball[0].Baseball_Status != GameObject.Baseball_Status.B_Cast && Baseball[0].Baseball_Status != GameObject.Baseball_Status.B_Return){
                    self.Natsume_Rin.attribute.status = GamePeople.Natsume_Rin_Status.NR_Swing.hashValue
                    self.Baseball[0].Baseball_Status = GameObject.Baseball_Status.B_Cast
                }
            }
            else{
                if Naoe_Riki.attribute.status != GamePeople.Naoe_Riki_Status.NR_FallDown.hashValue{
                    Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.NR_Swing.hashValue
                }
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
                print("Baseballfield:",Baseballfield.position)
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
        Status_Natsume_Kyousuke() //棗 恭介
        Status_Baseball(0) //棒 球
        
        //棒球状态
        switch Baseball[0].Baseball_Status{
        case .B_Static:
            break
        case .B_Cast:
            break
        case .B_Return:
            //Status_View(Baseball[0].Baseball_Unit.position)
            Status_View(Natsume_Kyousuke.attribute.Unit.position)
            break
        }

    }
    
    //MARK: 动作更新
    //MARK: 理 樹
    func Status_Naoe_Riki(){
        if(Naoe_Riki.attribute.status != GamePeople.Naoe_Riki_Status.NR_FallDown.hashValue){
            switch MovingButton_Status{
            case .UP:
                Naoe_Riki.attribute.Unit.position = CGPoint(x: Naoe_Riki.attribute.Unit.position.x, y: Naoe_Riki.attribute.Unit.position.y + 1)
                break
            case .Down:
                Naoe_Riki.attribute.Unit.position = CGPoint(x: Naoe_Riki.attribute.Unit.position.x, y: Naoe_Riki.attribute.Unit.position.y - 1)
                break
            case .Left:
                Naoe_Riki.attribute.Unit.position = CGPoint(x: Naoe_Riki.attribute.Unit.position.x - 1, y: Naoe_Riki.attribute.Unit.position.y)
                break
            case .Right:
                Naoe_Riki.attribute.Unit.position = CGPoint(x: Naoe_Riki.attribute.Unit.position.x + 1, y: Naoe_Riki.attribute.Unit.position.y)
                break
            default:
                break
            }
            if(Naoe_Riki.attribute.Unit.position.x < Naoe_Riki_Range.position.x){
                Naoe_Riki.attribute.Unit.position.x = Naoe_Riki_Range.position.x
            }
            if(Naoe_Riki.attribute.Unit.position.x > Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width){
                Naoe_Riki.attribute.Unit.position.x = Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width
            }
            if(Naoe_Riki.attribute.Unit.position.y < Naoe_Riki_Range.position.y){
                Naoe_Riki.attribute.Unit.position.y = Naoe_Riki_Range.position.y
            }
            if(Naoe_Riki.attribute.Unit.position.y > Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height){
                Naoe_Riki.attribute.Unit.position.y = Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height
            }
            Naoe_Riki.attribute.Shadow.position = CGPoint(x: Naoe_Riki.attribute.Unit.position.x + Naoe_Riki.attribute.Shadow_x, y: Naoe_Riki.attribute.Unit.position.y + Naoe_Riki.attribute.Shadow_y)
            Naoe_Riki_View.position = Naoe_Riki.attribute.Unit.position
        }
        
        var TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.01)) //帧数刷新延时
        switch Naoe_Riki.attribute.status{
        case GamePeople.Naoe_Riki_Status.NR_Swing.hashValue:
            if((actionForKey("Naoe_Riki_StatusAction")) != nil){
                return
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue > 9){
                Naoe_Riki.attribute.imageNumber = 0
                Naoe_Riki_View.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber])))
                Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.NR_Static.hashValue
                return
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue == 9){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.2))
            }
            
            if(Naoe_Riki.attribute.imageNumber.hashValue == 3){
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: GamePeople().Naoe_Riki_Contact()[0])
            }
            else if(Naoe_Riki.attribute.imageNumber.hashValue == 4){
                
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: GamePeople().Naoe_Riki_Contact()[1])
            }
            else if(Naoe_Riki.attribute.imageNumber.hashValue == 5){
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFromPath: GamePeople().Naoe_Riki_Contact()[2])
            }
            else{
                Naoe_Riki_View.physicsBody = nil
            }
            Naoe_Riki_View.physicsBody?.categoryBitMask = Collision.BaseballBat
            Naoe_Riki_View.physicsBody?.collisionBitMask = 0
            Naoe_Riki_View.physicsBody?.contactTestBitMask = Collision.Baseball
            
            break
        case GamePeople.Naoe_Riki_Status.NR_FallDown.hashValue:
            if((actionForKey("Naoe_Riki_StatusAction")) != nil && Naoe_Riki.attribute.status == GamePeople.Naoe_Riki_Status.NR_FallDown.hashValue){
                return
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue > 31){
                Naoe_Riki.attribute.imageNumber = 0
                Naoe_Riki_View.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber])))
                Naoe_Riki_View.size = Naoe_Riki.image[Naoe_Riki.attribute.imageNumber].size
                Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.NR_Static.hashValue
                return
            }
            TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.05))
            if(Naoe_Riki.attribute.imageNumber.hashValue < 10){
                Naoe_Riki.attribute.imageNumber = 10
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue > 16){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.1))
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue == 18){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(2))
            }
            break
        default:
            break
        }
        if(Naoe_Riki.attribute.status != GamePeople.Naoe_Riki_Status.NR_Static.hashValue){
            let Naoe_Riki_Start = SKAction.runBlock(Naoe_Riki_Swing)
            let Naoe_Riki_SwingAction = SKAction.sequence([Naoe_Riki_Start,TimeInterval])
            runAction(Naoe_Riki_SwingAction, withKey: "Naoe_Riki_StatusAction")
        }
        
    }
    func Naoe_Riki_Swing(){
        Naoe_Riki_View.size = Naoe_Riki.image[Naoe_Riki.attribute.imageNumber].size
        Naoe_Riki_View.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber++])))
    }
    
    //MARK: 棗 鈴
    func Status_Natsume_Rin(){
        if((actionForKey("Natsume_Rin_StatusAction")) != nil){
            return
        }
        //帧数刷新延时
        var TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.05))
        switch Natsume_Rin.attribute.status{
        case GamePeople.Natsume_Rin_Status.NR_Swing.hashValue:
            if(Natsume_Rin.attribute.imageNumber.hashValue < 9){
                Natsume_Rin.attribute.imageNumber = 9
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue > 15){
                Natsume_Rin_Static()
                return
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue == 12){
                //球已投出
                Baseball_Cast(0)
            }

            if(Natsume_Rin.attribute.imageNumber.hashValue == 9){
                Baseballfield.position = GameObject().Baseballfield().position
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue == 10){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(2))
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue == 14){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.5))
            }
            Natsume_Rin_StatusAction(TimeInterval)
            break
        case GamePeople.Natsume_Rin_Status.NR_Surprise.hashValue:
            if(Natsume_Rin.attribute.imageNumber.hashValue < 15){
                Natsume_Rin.attribute.imageNumber = 15
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue > 22){
                Natsume_Rin_Static()
                return
            }
            
            TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.1))
            if(Natsume_Rin.attribute.imageNumber.hashValue == 18){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(1))
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue == 22){
                TimeInterval = SKAction.waitForDuration(NSTimeInterval(1))
            }
            Natsume_Rin_StatusAction(TimeInterval)
            break
        default:
            break
        }
        
    }
    func Natsume_Rin_Static(){
        Natsume_Rin.attribute.imageNumber = 0
        Natsume_Rin_View.runAction(SKAction.setTexture(SKTexture(image: Natsume_Rin.image[Natsume_Rin.attribute.imageNumber])))
        Natsume_Rin_View.size = Natsume_Rin.image[Natsume_Rin.attribute.imageNumber].size
        Natsume_Rin.attribute.status = GamePeople.Natsume_Rin_Status.NR_Static.hashValue
    }
    func Natsume_Rin_StatusAction(TimeInterval:SKAction){
        let Natsume_Rin_Start = SKAction.runBlock(Natsume_Rin_Swing)
        let Natsume_Rin_SwingAction = SKAction.sequence([Natsume_Rin_Start,TimeInterval])
        runAction(Natsume_Rin_SwingAction, withKey: "Natsume_Rin_StatusAction")
    }
    func Natsume_Rin_Swing(){
        Natsume_Rin_View.size = Natsume_Rin.image[Natsume_Rin.attribute.imageNumber].size
        Natsume_Rin_View.runAction(SKAction.setTexture(SKTexture(image: Natsume_Rin.image[Natsume_Rin.attribute.imageNumber++])))
    }
    
    //MARK: 棗 恭介
    func Status_Natsume_Kyousuke(){
        //帧数刷新延时
        let TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.1))
        switch Natsume_Kyousuke.attribute.status{
        case GamePeople.Natsume_Kyousuke_Status.NK_Run.hashValue:
            if(Natsume_Kyousuke.attribute.Unit.speed == 0){
                Natsume_Kyousuke.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.moveToPoint(Natsume_Kyousuke.attribute.Unit.position)
                if(GetAngle(Baseball[0].Baseball_Unit.position, b: Natsume_Kyousuke.attribute.Unit.position) > Baseball_Angle){
                    RunPath.addLineToPoint(CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 310, y: GameObject().Baseballfield().anchorPoint.y + 360))
                }
                else{
                    RunPath.addLineToPoint(CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 870, y: GameObject().Baseballfield().anchorPoint.y + 70))
                }
                
                let path = CGPathCreateMutable()
                CGPathMoveToPoint(path, nil, 3, -20)
                CGPathAddLineToPoint(path, nil, 3, -25)
                CGPathAddLineToPoint(path, nil, -1, -25)
                CGPathAddLineToPoint(path, nil, -1, -20)
                CGPathCloseSubpath(path)
                Natsume_Kyousuke_View.physicsBody = SKPhysicsBody(polygonFromPath: path)
                Natsume_Kyousuke_View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind
                Natsume_Kyousuke_View.physicsBody?.collisionBitMask = 0
                Natsume_Kyousuke_View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BallTrackPath
                Natsume_Kyousuke.attribute.Unit.speed = 1
                Natsume_Kyousuke.attribute.Unit.runAction(SKAction.followPath(RunPath.CGPath, asOffset: false, orientToPath: false, speed: 200), completion: { () -> Void in
                    self.Natsume_Kyousuke_Static()
                    self.Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.NK_Return.hashValue
                })
            }
            Natsume_Kyousuke.attribute.Shadow.position = CGPoint(x: Natsume_Kyousuke.attribute.Unit.position.x + Natsume_Kyousuke.attribute.Shadow_x, y: Natsume_Kyousuke.attribute.Unit.position.y + Natsume_Kyousuke.attribute.Shadow_y)
            Natsume_Kyousuke_View.position = Natsume_Kyousuke.attribute.Unit.position
            
            if((actionForKey("Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if GetAngle(Baseball_ReturnPoint, b: Natsume_Kyousuke.attribute.Unit.position) > Baseball_Angle{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 8 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 11){
                    Natsume_Kyousuke.attribute.imageNumber = 8
                }
            }
            else{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 25 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 27){
                    Natsume_Kyousuke.attribute.imageNumber = 25
                }
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        case GamePeople.Natsume_Kyousuke_Status.NK_Static.hashValue:
            Natsume_Kyousuke_View.physicsBody = nil
            break
        case GamePeople.Natsume_Kyousuke_Status.NK_Return.hashValue:
            if(Natsume_Kyousuke.attribute.Unit.speed == 0){
                Natsume_Kyousuke.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.moveToPoint(Natsume_Kyousuke.attribute.Unit.position)
                RunPath.addLineToPoint(GamePeople().Natsume_Kyousuke_Attribute.point)
                Natsume_Kyousuke.attribute.Unit.speed = 1
                Natsume_Kyousuke.attribute.Unit.runAction(SKAction.followPath(RunPath.CGPath, asOffset: false, orientToPath: false, speed: 200), completion: { () -> Void in
                    self.Natsume_Kyousuke_Static()
                })
            }
            Natsume_Kyousuke.attribute.Shadow.position = CGPoint(x: Natsume_Kyousuke.attribute.Unit.position.x + Natsume_Kyousuke.attribute.Shadow_x, y: Natsume_Kyousuke.attribute.Unit.position.y + Natsume_Kyousuke.attribute.Shadow_y)
            Natsume_Kyousuke_View.position = Natsume_Kyousuke.attribute.Unit.position
            
            if((actionForKey("Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if Natsume_Kyousuke.attribute.Unit.position.x < GamePeople().Natsume_Kyousuke_Attribute.point.x{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 8 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 11){
                    Natsume_Kyousuke.attribute.imageNumber = 8
                }
            }
            else{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 25 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 27){
                    Natsume_Kyousuke.attribute.imageNumber = 25
                }
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        case GamePeople.Natsume_Kyousuke_Status.NK_Catch.hashValue:
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, 0, 30)
            CGPathAddLineToPoint(path, nil, 0, -40)
            CGPathAddLineToPoint(path, nil, -10, -40)
            CGPathAddLineToPoint(path, nil, -10, 30)
            CGPathCloseSubpath(path)
            Natsume_Kyousuke_View.physicsBody = SKPhysicsBody(polygonFromPath: path)
            Natsume_Kyousuke_View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind
            Natsume_Kyousuke_View.physicsBody?.collisionBitMask = 0
            Natsume_Kyousuke_View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
            break
        case GamePeople.Natsume_Kyousuke_Status.NK_Swing.hashValue:
            Natsume_Kyousuke_View.physicsBody = nil
            break
        default:
            break
        }
    }

    func Natsume_Kyousuke_StatusAction(TimeInterval:SKAction){
        let Natsume_Kyousuke_Start = SKAction.runBlock(Natsume_Kyousuke_Swing)
        let Natsume_Kyousuke_SwingAction = SKAction.sequence([Natsume_Kyousuke_Start,TimeInterval])
        runAction(Natsume_Kyousuke_SwingAction, withKey: "Natsume_Kyousuke_StatusAction")
    }
    func Natsume_Kyousuke_Swing(){
        Natsume_Kyousuke_View.size = Natsume_Kyousuke.image[Natsume_Kyousuke.attribute.imageNumber].size
        Natsume_Kyousuke_View.runAction(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.image[Natsume_Kyousuke.attribute.imageNumber++])))
    }
    func Natsume_Kyousuke_Static(){
        Natsume_Kyousuke.attribute.imageNumber = 0
        Natsume_Kyousuke_View.runAction(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.image[0])))
        Natsume_Kyousuke_View.size = Natsume_Rin.image[Natsume_Kyousuke.attribute.imageNumber].size
        Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.NK_Static.hashValue
        Natsume_Kyousuke.attribute.Unit.speed = 0
    }
    
    //MARK: 棒球
    func Status_Baseball(Baseball_Number: Int){
        
        Baseball[Baseball_Number].Baseball_Power.ball_y = (-(Baseball[Baseball_Number].Baseball_Power.ball_x * Baseball[Baseball_Number].Baseball_Power.ball_x) + Baseball[Baseball_Number].Baseball_Power.length * Baseball[Baseball_Number].Baseball_Power.ball_x) / Baseball[Baseball_Number].Baseball_Power.height
        if(Baseball[Baseball_Number].Baseball_Power.ball_y < 0){
            if Baseball[Baseball_Number].Baseball_Power.height < 12 {
                Baseball[Baseball_Number].Baseball_Power.ball_x = 0
                Baseball[Baseball_Number].Baseball_Power.height = Baseball[Baseball_Number].Baseball_Power.height * Baseball_Jumps++
            }
            else{
                Baseball[Baseball_Number].Baseball_Power.ball_y = 0
            }
        }
        Baseball[Baseball_Number].Baseball_Image.position = CGPoint(x: Baseball[Baseball_Number].Baseball_Unit.position.x, y: Baseball[Baseball_Number].Baseball_Unit.position.y + Baseball[Baseball_Number].Baseball_Power.ball_y)
        Baseball[Baseball_Number].Baseball_Shadow.position = CGPoint(x: Baseball[0].Baseball_Unit.position.x, y: Baseball[0].Baseball_Unit.position.y)
        
    }
    
    func Baseball_Cast(Baseball_Number:Int){

        Baseball[Baseball_Number].Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 5, length: 60)
        Baseball_Jumps = 2
        
        let BallPath = UIBezierPath()
        BallPath.moveToPoint(CGPoint(x: GameObject.Baseball().Baseball_Image.position.x, y: GameObject.Baseball().Baseball_Image.position.y))
        BallPath.addLineToPoint(CGPoint(x: GameObject.Baseball().Baseball_Image.position.x, y: -(Baseballfield.frame.height * Baseballfield.anchorPoint.y)))
        Baseball[Baseball_Number].Baseball_Unit.speed = 1
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.followPath(BallPath.CGPath, asOffset: false, orientToPath: false, speed: 400)) {
            self.Baseball_Static(Baseball_Number)
        }
        Baseball[Baseball_Number].Baseball_Image.hidden = false
        Baseball[Baseball_Number].Baseball_Shadow.hidden = false
    }
    
    func Baseball_Return(Baseball_Number: Int,contact: CGPoint){
        Baseball[Baseball_Number].Baseball_Unit.removeAllActions()
        
        Baseball[Baseball_Number].Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 2, length: 35)
        let BallPath = UIBezierPath()
        BallPath.moveToPoint(CGPoint(x: Baseball[Baseball_Number].Baseball_Unit.position.x, y: Baseball[Baseball_Number].Baseball_Unit.position.y))
        if Naoe_Riki.attribute.imageNumber.hashValue == 4 {
            let HeightRatio = (contact.x - CGPathGetBoundingBox(GamePeople().Naoe_Riki_Contact()[0]).minX) / CGPathGetBoundingBox(GamePeople().Naoe_Riki_Contact()[0]).width
            BallPath.addLineToPoint(CGPoint(x: Baseballfield.frame.width / 2, y: Baseballfield.frame.height * (1 - HeightRatio) - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
        }
        else if Naoe_Riki.attribute.imageNumber.hashValue == 5{
            let WidthRatio = (contact.x - CGPathGetBoundingBox(GamePeople().Naoe_Riki_Contact()[1]).minX) / CGPathGetBoundingBox(GamePeople().Naoe_Riki_Contact()[1]).width
            BallPath.addLineToPoint(CGPoint(x: Baseballfield.frame.width * WidthRatio - Baseballfield.frame.width * Baseballfield.anchorPoint.x, y: Baseballfield.frame.height - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
        }
        else{
            let HeightRatio = (contact.x - CGPathGetBoundingBox(GamePeople().Naoe_Riki_Contact()[2]).minX) / CGPathGetBoundingBox(GamePeople().Naoe_Riki_Contact()[2]).width
            BallPath.addLineToPoint(CGPoint(x: -Baseballfield.frame.width / 2, y: Baseballfield.frame.height * HeightRatio - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
        }
        let path = CGPathCreateMutable()
        Baseball_ReturnPoint = Baseball[Baseball_Number].Baseball_Unit.position
        Baseball_Angle = GetAngle(Baseball[Baseball_Number].Baseball_Unit.position, b: BallPath.currentPoint)
        CGPathMoveToPoint(path, nil, BallPath.currentPoint.x, BallPath.currentPoint.y)
        CGPathAddLineToPoint(path, nil, Baseball[Baseball_Number].Baseball_Unit.position.x, Baseball[Baseball_Number].Baseball_Unit.position.y)
        BallTrackPath.physicsBody = SKPhysicsBody(edgeChainFromPath: path)
        BallTrackPath.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.BallTrackPath
        BallTrackPath.physicsBody?.collisionBitMask = 0
        BallTrackPath.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.PeopleBehind
        Baseballfield.addChild(BallTrackPath)
        
        
        Baseball[Baseball_Number].Baseball_Status = .B_Return
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.speedTo(1, duration: 0))
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.followPath(BallPath.CGPath, asOffset: false, orientToPath: false, speed: 500)) {
            self.Baseball_Static(Baseball_Number)
        }
        Baseball[Baseball_Number].Baseball_Unit.runAction(SKAction.speedTo(0, duration: 5), completion: { () -> Void in
            self.Baseball_Static(Baseball_Number)
        })
    }
    func Baseball_Static(Baseball_Number: Int){
        Baseball[Baseball_Number].Baseball_Image.hidden = true
        Baseball[Baseball_Number].Baseball_Shadow.hidden = true
        Baseball[Baseball_Number].Baseball_Status = .B_Static
        Baseball[Baseball_Number].Baseball_Unit.removeAllActions()
        Baseballfield.removeChildrenInArray([BallTrackPath])
    }
    func GetAngle(a: CGPoint, b: CGPoint) -> CGFloat{
        let x = a.x
        let y = a.y
        let dx = b.x - x
        let dy = b.y - y
        let radians = atan2(-dx, dy)
        let degrees = radians * 180 / 3.14
        return degrees
    }
    
    //MARK: 视图
    func Status_View(Object_Point: CGPoint){
        //移动整个Map
        Baseballfield.position = CGPoint(x: -Object_Point.x + (size.width / 2), y: -Object_Point.y + (size.height / 2))
    }
    
    
    //MARK: 物理撞击
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == Collision.Baseball || contact.bodyB.categoryBitMask == Collision.Baseball{
            let ContactUnit = contact.bodyA.categoryBitMask == Collision.Baseball ? contact.bodyB : contact.bodyA
            if ContactUnit.categoryBitMask == Collision.BaseballBat && Baseball[0].Baseball_Status == GameObject.Baseball_Status.B_Cast{
                //击球后
                Baseball_Return(0, contact: convertPoint(contact.contactPoint, toNode: Naoe_Riki_View))
                Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.NK_Run.hashValue
            }
            if ContactUnit.categoryBitMask == Collision.PeopleFront && Baseball[0].Baseball_Status == GameObject.Baseball_Status.B_Cast{
                //理树被击中
                Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.NR_FallDown.hashValue
                Natsume_Rin.attribute.status = GamePeople.Natsume_Rin_Status.NR_Surprise.hashValue
                Baseball_Static(0)
            }
            if ContactUnit.categoryBitMask == Collision.PeopleBehind && Natsume_Kyousuke.attribute.status == GamePeople.Natsume_Kyousuke_Status.NK_Catch.hashValue{
                Baseball_Static(0)
                
                Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.NK_Swing.hashValue
                print("投掷")
            }
        }
        if contact.bodyA.categoryBitMask == Collision.BallTrackPath || contact.bodyB.categoryBitMask == Collision.BallTrackPath{
            if(contact.bodyA.categoryBitMask == Collision.Baseball || contact.bodyB.categoryBitMask == Collision.Baseball){
                return
            }
            let ContactUnit = contact.bodyA.categoryBitMask == Collision.BallTrackPath ? contact.bodyB : contact.bodyA
            Baseballfield.removeChildrenInArray([BallTrackPath])
            if ContactUnit.categoryBitMask == Collision.PeopleBehind && Natsume_Kyousuke.attribute.Unit.position.x > Baseball[0].Baseball_Unit.position.x{
                self.Natsume_Kyousuke_Static()
                self.Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.NK_Return.hashValue
            }
            else{
                self.Natsume_Kyousuke_Static()
                Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.NK_Catch.hashValue
                print("接住")
            }
        }
    }
    
}

