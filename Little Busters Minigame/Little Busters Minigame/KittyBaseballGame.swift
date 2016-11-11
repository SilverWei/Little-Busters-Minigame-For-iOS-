//
//  KittyBaseballGame.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/11.
//  Copyright © 2016 dmqlacgal. All rights reserved.
//

import SpriteKit

class KittyBaseballGame: SKScene, SKPhysicsContactDelegate {
    
    let GameView = SKNode()
    var TouchAmount = 0 //监测触摸数量
    var DateTime: TimeInterval = 0
    var LastDateTime: TimeInterval = 0
    
    //MARK: 初始化物体
    let Baseballfield = GameObject().Baseballfield()
    
    //棒球
    var Baseball = [GameObject.Baseball()]
    var Baseball_Jumps: CGFloat = 2 //激活状态的棒球
    var Baseball_Angle: CGFloat = 0.0 //角度
    var Baseball_ReturnPoint: CGPoint = CGPoint.zero //返回位置
    var Baseball_JumpsHeight: CGFloat = 0.0 //高度
    var Baseball_Speed:CGFloat = 0 //速度
    let BallTrackPath = SKShapeNode() //棒球移动路径
    
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
    var Natsume_Kyousuke_Range = GamePeople().Natsume_Kyousuke_Range()
    
    //MARK: 初始化按钮
    var MovingButton_Status = MovingButton_Touch.stop
    let MovingButton = GameObject().MovingButton()
    let MovingButton_UP = GameObject().MovingButton_UP()
    let MovingButton_Down = GameObject().MovingButton_Down()
    let MovingButton_Left = GameObject().MovingButton_Left()
    let MovingButton_Right = GameObject().MovingButton_Right()
    
    let TestButton = GameObject().TestButton()
    
    //MARK: 图层
    /// 图层
    ///
    /// - baseballfield: 棒球场背景
    /// - shadow:           阴影
    /// - otherBody:      其他物件
    /// - cat:               猫
    /// - peopleBehind: 在后面的人物
    /// - baseball:         棒球
    /// - peopleFront:  在前面的人物
    /// - button:           按钮
    enum Layers: CGFloat{
        case baseballfield
        case shadow
        case otherBody
        case cat
        case peopleBehind
        case baseball
        case peopleFront
        case button
    }
    
    //MARK: 物理层
    struct Collision {
        static let null: UInt32 = 0
        static let Baseball: UInt32 = 0b1 //棒球
        static let BaseballBat: UInt32 = 0b10 //棒球棍
        static let PeopleFront: UInt32 = 0b100 //前方人物单位
        static let PeopleBehind: UInt32 = 0b101 //后方人物单位
        static let BallTrackPath: UInt32 = 0b111 //球运动路径
    }
    
    //MARK: 按钮状态
    enum MovingButton_Touch: CGFloat{
        case stop
        case up
        case down
        case left
        case right
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        //关掉重力
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
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
    
    //MARK: 显示元素
    func Show_Baseballfield(){
        GameView.addChild(Baseballfield)
    }
    
    func Show_PeopleFront(){
        Naoe_Riki_View.position = Naoe_Riki.attribute.point
        Naoe_Riki_View.zPosition = Layers.peopleFront.rawValue
        Naoe_Riki.attribute.Unit.position = Naoe_Riki.attribute.point
        Naoe_Riki.attribute.Unit.addChild(GamePeople().Naoe_Riki_BodyContact())
        Baseballfield.addChild(Naoe_Riki.attribute.Unit)
        Baseballfield.addChild(Naoe_Riki_View)

        Naoe_Riki_Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Naoe_Riki_Range)
    }
    
    func Show_PeopleBehind(){
        Natsume_Rin_View.position = Natsume_Rin.attribute.point
        Natsume_Rin_View.zPosition = Layers.peopleBehind.rawValue
        Baseballfield.addChild(Natsume_Rin_View)
        
        Natsume_Kyousuke_View.position = Natsume_Kyousuke.attribute.point
        Natsume_Kyousuke_View.zPosition = Layers.peopleBehind.rawValue
        Natsume_Kyousuke.attribute.Unit.position = Natsume_Kyousuke_View.position
        Natsume_Kyousuke.attribute.Unit.speed = 0
        Baseballfield.addChild(Natsume_Kyousuke_View)
        Baseballfield.addChild(Natsume_Kyousuke.attribute.Unit)
        
        Natsume_Kyousuke_Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Natsume_Kyousuke_Range)
    }
    
    func Show_Baseball(){
        Baseball[0].Baseball_Image.zPosition = Layers.baseball.rawValue
        Baseballfield.addChild(Baseball[0].Baseball_Image)
        Baseball[0].Baseball_Image.isHidden = true
        
        //棒球位置
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
        Baseball[0].Baseball_Shadow.isHidden = true
        
    }
    
    func Show_Button(){
        MovingButton.zPosition = Layers.button.rawValue
        MovingButton.addChild(MovingButton_UP)
        MovingButton.addChild(MovingButton_Down)
        MovingButton.addChild(MovingButton_Left)
        MovingButton.addChild(MovingButton_Right)
        GameView.addChild(MovingButton)
        
        TestButton.zPosition = Layers.button.rawValue
        GameView.addChild(TestButton)
    }

    
    //MARK: 点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            
            if touchesButton(location) {
                
            }
            else if TestButton.contains(location){
                if(Baseball[0].Baseball_Status != GameObject.Baseball_Status.b_Throw && Baseball[0].Baseball_Status != GameObject.Baseball_Status.b_Return && Baseball[0].Baseball_Status != GameObject.Baseball_Status.b_ReturnAgain && Natsume_Rin.attribute.status == GamePeople.Natsume_Rin_Status.nr_Static.hashValue){
                    self.Natsume_Rin.attribute.imageNumber = 0
                    self.Natsume_Rin.attribute.status = GamePeople.Natsume_Rin_Status.nr_Swing.hashValue
                }
            }
            else{
                if Naoe_Riki.attribute.status != GamePeople.Naoe_Riki_Status.nr_FallDown.hashValue{
                    Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.nr_Swing.hashValue
                }
            }
        }
        TouchAmount += 1
        if(TouchAmount > 2){
            TouchAmount = 2
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            AllButtonColorClear()
            
            if !touchesButton(location){
                MovingButton_Status = .stop
                
                //移动整个Map
                if(location.y > self.frame.height * 0.25){
                    Baseballfield.position = CGPoint(x: Baseballfield.frame.width * -(location.x / self.frame.width) + Baseballfield.frame.width * 0.55, y: Baseballfield.frame.height * -(location.y / self.frame.height) + Baseballfield.frame.height / 2)
                }
                print("Baseballfield:",Baseballfield.position)
            }
        }
    }
    func touchesButton(_ location: CGPoint) -> Bool {
        if MovingButton_UP.contains(location) {
            MovingButton_Status = .up
            MovingButton_UP.fillColor = SKColor.white
            return true
        }
        else if MovingButton_Down.contains(location) {
            MovingButton_Status = .down
            MovingButton_Down.fillColor = SKColor.white
            return true
        }
        else if MovingButton_Left.contains(location) {
            MovingButton_Status = .left
            MovingButton_Left.fillColor = SKColor.white
            return true
        }
        else if MovingButton_Right.contains(location) {
            MovingButton_Status = .right
            MovingButton_Right.fillColor = SKColor.white
            return true
        }
        return false
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        TouchAmount -= 1
        if(TouchAmount <= 0){
            AllButtonColorClear()
            MovingButton_Status = .stop
        }
    }
    func AllButtonColorClear(){
        MovingButton_UP.fillColor = SKColor.clear
        MovingButton_Down.fillColor = SKColor.clear
        MovingButton_Left.fillColor = SKColor.clear
        MovingButton_Right.fillColor = SKColor.clear
    }
    
    
    //MARK: 帧更新
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if LastDateTime > 0{
            DateTime = currentTime - LastDateTime
        }
        else{
            DateTime = 0
        }
        LastDateTime = currentTime
        
        //棒球位置
        Baseball[0].Baseball_Power.ball_x = Baseball[0].Baseball_Power.ball_x + CGFloat(DateTime) * 50
        
        //更新人物状态
        Status_Naoe_Riki() //理 树
        Status_Natsume_Rin() //棗 鈴
        Status_Natsume_Kyousuke() //棗 恭介
        Status_Baseball(0) //棒 球
        
        //棒球状态
        switch Baseball[0].Baseball_Status{
        case .b_Static:
            break
        case .b_Throw:
            break
        case .b_Return:
            Status_View(Baseball[0].Baseball_Unit.position)
            break
        case .b_ReturnAgain:
            Status_View(Baseball[0].Baseball_Unit.position)
            break
            
        }

    }
    
    //MARK: 动作更新
    //MARK: 理 樹
    func Status_Naoe_Riki(){
        //移动
        if(Naoe_Riki.attribute.status != GamePeople.Naoe_Riki_Status.nr_FallDown.hashValue){
            var Naoe_Riki_position = Naoe_Riki.attribute.Unit.position
            switch MovingButton_Status{
            case .up:
                Naoe_Riki_position = CGPoint(x: Naoe_Riki_position.x, y: Naoe_Riki_position.y + 1)
                break
            case .down:
                Naoe_Riki_position = CGPoint(x: Naoe_Riki_position.x, y: Naoe_Riki_position.y - 1)
                break
            case .left:
                Naoe_Riki_position = CGPoint(x: Naoe_Riki_position.x - 1, y: Naoe_Riki_position.y)
                break
            case .right:
                Naoe_Riki_position = CGPoint(x: Naoe_Riki_position.x + 1, y: Naoe_Riki_position.y)
                break
            default:
                break
            }
            if(Naoe_Riki_position.x < Naoe_Riki_Range.position.x){
                Naoe_Riki_position.x = Naoe_Riki_Range.position.x
            }
            if(Naoe_Riki_position.x > Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width){
                Naoe_Riki_position.x = Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width
            }
            if(Naoe_Riki_position.y < Naoe_Riki_Range.position.y){
                Naoe_Riki_position.y = Naoe_Riki_Range.position.y
            }
            if(Naoe_Riki_position.y > Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height){
                Naoe_Riki_position.y = Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height
            }
            Naoe_Riki.attribute.Shadow.position = CGPoint(x: Naoe_Riki_position.x + Naoe_Riki.attribute.Shadow_x, y: Naoe_Riki_position.y + Naoe_Riki.attribute.Shadow_y)
            Naoe_Riki.attribute.Unit.position = Naoe_Riki_position
            Naoe_Riki_View.position = Naoe_Riki.attribute.Unit.position
        }
        
        var TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.01)) //帧数刷新延时
        
        ///状态
        switch Naoe_Riki.attribute.status{
        //挥动
        case GamePeople.Naoe_Riki_Status.nr_Swing.hashValue:
            if((action(forKey: "Naoe_Riki_StatusAction")) != nil){
                return
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue > 9){
                Naoe_Riki.attribute.imageNumber = 0
                Naoe_Riki_View.run(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber])))
                Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.nr_Static.hashValue
                return
            }
            switch Naoe_Riki.attribute.imageNumber.hashValue{
            case 9:
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.2))
                break
            case 3:
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople().Naoe_Riki_Contact()[0])
                break
            case 4:
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople().Naoe_Riki_Contact()[1])
                break
            case 5:
                Naoe_Riki_View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople().Naoe_Riki_Contact()[2])
                break
            default:
                Naoe_Riki_View.physicsBody = nil
                break
            }
            
            Naoe_Riki_View.physicsBody?.categoryBitMask = Collision.BaseballBat
            Naoe_Riki_View.physicsBody?.collisionBitMask = 0
            Naoe_Riki_View.physicsBody?.contactTestBitMask = Collision.Baseball
            
            break
        //摔倒
        case GamePeople.Naoe_Riki_Status.nr_FallDown.hashValue:
            if((action(forKey: "Naoe_Riki_StatusAction")) != nil && Naoe_Riki.attribute.status == GamePeople.Naoe_Riki_Status.nr_FallDown.hashValue){
                return
            }
            Naoe_Riki_View.physicsBody = nil
            TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.05))
            if(Naoe_Riki.attribute.imageNumber.hashValue > 31){
                Naoe_Riki.attribute.imageNumber = 0
                Naoe_Riki_View.run(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber])))
                Naoe_Riki_View.size = Naoe_Riki.image[Naoe_Riki.attribute.imageNumber].size
                Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.nr_Static.hashValue
                return
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue < 10){
                Naoe_Riki.attribute.imageNumber = 10
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue > 16){
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
            }
            if(Naoe_Riki.attribute.imageNumber.hashValue == 18){
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(2))
            }
            break
        default:
            break
        }
        if(Naoe_Riki.attribute.status != GamePeople.Naoe_Riki_Status.nr_Static.hashValue){
            let Naoe_Riki_Start = SKAction.run(Naoe_Riki_Swing)
            let Naoe_Riki_SwingAction = SKAction.sequence([Naoe_Riki_Start,TimeInterval])
            run(Naoe_Riki_SwingAction, withKey: "Naoe_Riki_StatusAction")
        }
        
    }
    func Naoe_Riki_Swing(){
        Naoe_Riki_View.size = Naoe_Riki.image[Naoe_Riki.attribute.imageNumber].size
        Naoe_Riki_View.run(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.attribute.imageNumber])))
        Naoe_Riki.attribute.imageNumber += 1
    }
    
    //MARK: 棗 鈴
    func Status_Natsume_Rin(){
        if((action(forKey: "Natsume_Rin_StatusAction")) != nil){
            return
        }
        //帧数刷新延时
        var TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.05))
        switch Natsume_Rin.attribute.status{
        //静止
        case GamePeople.Natsume_Rin_Status.nr_Swing.hashValue:
            if(Natsume_Rin.attribute.imageNumber.hashValue < 9){
                Natsume_Rin.attribute.imageNumber = 9
                self.Baseball[0].Baseball_Status = GameObject.Baseball_Status.b_Throw
                //角色归位
                self.Natsume_Kyousuke_Static()
                self.Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_Return.hashValue
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue > 15){
                Natsume_Rin_Static()
                return
            }

            switch Natsume_Rin.attribute.imageNumber.hashValue{
            case 9:
                Baseballfield.position = GameObject().Baseballfield().position
                break
            case 10:
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(2))
                break
            case 12:
                print("球已投出")
                Baseball[0].Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 3, length: 30)
                Baseball_Jumps = 2
                Baseball_Speed = 400
                let BallPath = UIBezierPath()
                BallPath.move(to: CGPoint(x: GameObject.Baseball().Baseball_Image.position.x, y: GameObject.Baseball().Baseball_Image.position.y))
                BallPath.addLine(to: CGPoint(x: GameObject.Baseball().Baseball_Image.position.x, y: -(Baseballfield.frame.height * Baseballfield.anchorPoint.y)))
                Baseball_Throw(0,BallPath: BallPath)
                break
            case 14:
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.5))
                break
            default:
                break
            }
            
            Natsume_Rin_StatusAction(TimeInterval)
            break
        //惊讶
        case GamePeople.Natsume_Rin_Status.nr_Surprise.hashValue:
            if(Natsume_Rin.attribute.imageNumber.hashValue < 15){
                Natsume_Rin.attribute.imageNumber = 15
            }
            if(Natsume_Rin.attribute.imageNumber.hashValue > 22){
                Natsume_Rin_Static()
                return
            }
            
            TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
            
            switch Natsume_Rin.attribute.imageNumber.hashValue{
            case 18:
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(1))
                break
            case 22:
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(1))
                break
            default:
                break
            }
            
            Natsume_Rin_StatusAction(TimeInterval)
            break
        default:
            break
        }
        
    }
    func Natsume_Rin_Static(){
        Natsume_Rin.attribute.imageNumber = 0
        Natsume_Rin_View.run(SKAction.setTexture(SKTexture(image: Natsume_Rin.image[Natsume_Rin.attribute.imageNumber])))
        Natsume_Rin_View.size = Natsume_Rin.image[Natsume_Rin.attribute.imageNumber].size
        Natsume_Rin.attribute.status = GamePeople.Natsume_Rin_Status.nr_Static.hashValue
    }
    func Natsume_Rin_StatusAction(_ TimeInterval:SKAction){
        let Natsume_Rin_Start = SKAction.run(Natsume_Rin_Swing)
        let Natsume_Rin_SwingAction = SKAction.sequence([Natsume_Rin_Start,TimeInterval])
        run(Natsume_Rin_SwingAction, withKey: "Natsume_Rin_StatusAction")
    }
    func Natsume_Rin_Swing(){
        Natsume_Rin_View.size = Natsume_Rin.image[Natsume_Rin.attribute.imageNumber].size
        Natsume_Rin_View.run(SKAction.setTexture(SKTexture(image: Natsume_Rin.image[Natsume_Rin.attribute.imageNumber])))
        Natsume_Rin.attribute.imageNumber += 1
    }
    
    //MARK: 棗 恭介
    func Status_Natsume_Kyousuke(){
        //帧数刷新延时
        let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
        switch Natsume_Kyousuke.attribute.status{
        //跑
        case GamePeople.Natsume_Kyousuke_Status.nk_Run.hashValue:
            print("恭介在定位")
            if(Natsume_Kyousuke.attribute.Unit.speed == 0){
                Natsume_Kyousuke.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Natsume_Kyousuke.attribute.Unit.position)
                if(GetAngle(Baseball[0].Baseball_Unit.position, b: Natsume_Kyousuke.attribute.Unit.position) > Baseball_Angle){
                    RunPath.addLine(to: CGPoint(x: Natsume_Kyousuke_Range.position.x + Natsume_Kyousuke_Range.frame.width, y: Natsume_Kyousuke_Range.position.y + Natsume_Kyousuke_Range.frame.height))
                }
                else{
                    RunPath.addLine(to: Natsume_Kyousuke_Range.position)
                }
                
                let path = CGMutablePath()
                path.move(to: CGPoint(x: 3,y: -20))
                path.addLine(to: CGPoint(x: 3, y: -25))
                path.addLine(to: CGPoint(x: -1, y: -25))
                path.addLine(to: CGPoint(x: -1, y: -20))
                path.closeSubpath()
                Natsume_Kyousuke_View.physicsBody = SKPhysicsBody(polygonFrom: path)
                Natsume_Kyousuke_View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind
                Natsume_Kyousuke_View.physicsBody?.collisionBitMask = 0
                Natsume_Kyousuke_View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BallTrackPath
                Natsume_Kyousuke.attribute.Unit.speed = 1
                Natsume_Kyousuke.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 200), completion: { () -> Void in
                    self.Natsume_Kyousuke_Static()
                    self.Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_Return.hashValue
                })
            }
            Natsume_Kyousuke.attribute.Shadow.position = CGPoint(x: Natsume_Kyousuke.attribute.Unit.position.x + Natsume_Kyousuke.attribute.Shadow_x, y: Natsume_Kyousuke.attribute.Unit.position.y + Natsume_Kyousuke.attribute.Shadow_y)
            Natsume_Kyousuke_View.position = Natsume_Kyousuke.attribute.Unit.position
            
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if GetAngle(Baseball_ReturnPoint, b: Natsume_Kyousuke.attribute.Unit.position) > Baseball_Angle{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 8 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 11){
                    Natsume_Kyousuke.attribute.imageNumber = 8
                }
            }
            else{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 24 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 27){
                    Natsume_Kyousuke.attribute.imageNumber = 24
                }
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //静止
        case GamePeople.Natsume_Kyousuke_Status.nk_Static.hashValue:
            Natsume_Kyousuke_View.physicsBody = nil
            break
        //返回
        case GamePeople.Natsume_Kyousuke_Status.nk_Return.hashValue:
            print("恭介往回跑")
            if(Natsume_Kyousuke.attribute.Unit.speed == 0){
                Natsume_Kyousuke.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Natsume_Kyousuke.attribute.Unit.position)
                RunPath.addLine(to: GamePeople().Natsume_Kyousuke_Attribute.point)
                Natsume_Kyousuke.attribute.Unit.speed = 1
                Natsume_Kyousuke.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 200), completion: { () -> Void in
                    self.Natsume_Kyousuke_Static()
                })
            }
            Natsume_Kyousuke.attribute.Shadow.position = CGPoint(x: Natsume_Kyousuke.attribute.Unit.position.x + Natsume_Kyousuke.attribute.Shadow_x, y: Natsume_Kyousuke.attribute.Unit.position.y + Natsume_Kyousuke.attribute.Shadow_y)
            Natsume_Kyousuke_View.position = Natsume_Kyousuke.attribute.Unit.position
            
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if Natsume_Kyousuke.attribute.Unit.position.x < GamePeople().Natsume_Kyousuke_Attribute.point.x{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 8 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 11){
                    Natsume_Kyousuke.attribute.imageNumber = 8
                }
            }
            else{
                if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 24 || Natsume_Kyousuke.attribute.imageNumber.hashValue > 27){
                    Natsume_Kyousuke.attribute.imageNumber = 24
                }
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //接球
        case GamePeople.Natsume_Kyousuke_Status.nk_Catch.hashValue:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0,y: 30))
            path.addLine(to: CGPoint(x: 0, y: -40))
            path.addLine(to: CGPoint(x: -10, y: -40))
            path.addLine(to: CGPoint(x: -10, y: 30))
            path.closeSubpath()
            Natsume_Kyousuke_View.physicsBody = SKPhysicsBody(polygonFrom: path)
            Natsume_Kyousuke_View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind
            Natsume_Kyousuke_View.physicsBody?.collisionBitMask = 0
            Natsume_Kyousuke_View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
            
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if(hypot(Natsume_Kyousuke.attribute.Unit.position.x - Baseball[0].Baseball_Unit.position.x, Natsume_Kyousuke.attribute.Unit.position.y - Baseball[0].Baseball_Unit.position.y) > 200){
                return
            }
            if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 72){
                Natsume_Kyousuke.attribute.imageNumber = 72
            }
            if(Natsume_Kyousuke.attribute.imageNumber.hashValue > 73){
                Natsume_Kyousuke.attribute.imageNumber = 73
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //捡起
        case GamePeople.Natsume_Kyousuke_Status.nk_PickUp.hashValue:
            Natsume_Kyousuke_View.physicsBody = nil
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 74){
                Natsume_Kyousuke.attribute.imageNumber = 74
            }
            if(Natsume_Kyousuke.attribute.imageNumber.hashValue > 75){
                Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_Swing.hashValue
                Natsume_Kyousuke.attribute.imageNumber = 0
                return
            }
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //挥动
        case GamePeople.Natsume_Kyousuke_Status.nk_Swing.hashValue:
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if(Natsume_Kyousuke.attribute.imageNumber.hashValue < 48){
                Natsume_Kyousuke.attribute.imageNumber = 48
            }
            if(Natsume_Kyousuke.attribute.imageNumber.hashValue > 51){
                self.Natsume_Kyousuke_Static()
            }
            
            if(Natsume_Kyousuke.attribute.imageNumber.hashValue == 50){
                Baseball[0].Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 8, length: 40)
                Baseball_Jumps = 2
                Baseball_Speed = 800
                let BallPath = UIBezierPath()
                BallPath.move(to: Baseball[0].Baseball_Unit.position)
                Baseball_ReturnPoint.y = Baseball_ReturnPoint.y + 20
                let BallAddPath = CGSize(width: Baseball_ReturnPoint.x - Baseball[0].Baseball_Unit.position.x, height: Baseball[0].Baseball_Unit.position.y - Baseball_ReturnPoint.y)
                BallPath.addLine(to: CGPoint(x: BallPath.currentPoint.x + (BallAddPath.width * 3), y: BallPath.currentPoint.y - (BallAddPath.height * 3)))
                Baseball_Throw(0,BallPath: BallPath)
                Baseball[0].Baseball_Unit.run(SKAction.speed(to: 0, duration: 5), completion: { () -> Void in
                    self.Baseball_Static(0)
                })
                Baseball[0].Baseball_Status = GameObject.Baseball_Status.b_ReturnAgain
            }

            Natsume_Kyousuke_StatusAction(TimeInterval)

            break
        default:
            break
        }
    }

    func Natsume_Kyousuke_StatusAction(_ TimeInterval:SKAction){
        let Natsume_Kyousuke_Start = SKAction.run(Natsume_Kyousuke_Swing)
        let Natsume_Kyousuke_SwingAction = SKAction.sequence([Natsume_Kyousuke_Start,TimeInterval])
        run(Natsume_Kyousuke_SwingAction, withKey: "Natsume_Kyousuke_StatusAction")
    }
    func Natsume_Kyousuke_Swing(){
        Natsume_Kyousuke_View.size = Natsume_Kyousuke.image[Natsume_Kyousuke.attribute.imageNumber].size
        Natsume_Kyousuke_View.run(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.image[Natsume_Kyousuke.attribute.imageNumber])))
        Natsume_Kyousuke.attribute.imageNumber += 1
    }
    func Natsume_Kyousuke_Static(){
        Natsume_Kyousuke.attribute.imageNumber = 0
        Natsume_Kyousuke_View.run(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.image[0])))
        Natsume_Kyousuke_View.size = Natsume_Rin.image[Natsume_Kyousuke.attribute.imageNumber].size
        Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_Static.hashValue
        Natsume_Kyousuke.attribute.Unit.speed = 0
    }
    
    //MARK: 棒球
    func Status_Baseball(_ Baseball_Number: Int){
        Baseball[Baseball_Number].Baseball_Power.ball_y = (-(Baseball[Baseball_Number].Baseball_Power.ball_x * Baseball[Baseball_Number].Baseball_Power.ball_x) + Baseball[Baseball_Number].Baseball_Power.length * Baseball[Baseball_Number].Baseball_Power.ball_x) / Baseball[Baseball_Number].Baseball_Power.height
        if(Baseball[Baseball_Number].Baseball_Power.ball_y < 0){
            if Baseball[Baseball_Number].Baseball_Power.height < 12 {
                Baseball[Baseball_Number].Baseball_Power.ball_x = 0
                Baseball[Baseball_Number].Baseball_Power.height = Baseball[Baseball_Number].Baseball_Power.height * Baseball_Jumps
                Baseball_Jumps += 1
            }
            else{
                Baseball[Baseball_Number].Baseball_Power.ball_y = 0
            }
        }
        
        Baseball[Baseball_Number].Baseball_Image.position = CGPoint(x: Baseball[Baseball_Number].Baseball_Unit.position.x, y: Baseball[Baseball_Number].Baseball_Unit.position.y + Baseball[Baseball_Number].Baseball_Power.ball_y)
        Baseball[Baseball_Number].Baseball_Shadow.position = CGPoint(x: Baseball[0].Baseball_Unit.position.x, y: Baseball[0].Baseball_Unit.position.y)
        
    }
    
    /// 扔出
    ///
    /// - parameter Baseball_Number: 激活球号
    /// - parameter BallPath:        移动路径
    func Baseball_Throw(_ Baseball_Number:Int,BallPath: UIBezierPath){
        Baseball[Baseball_Number].Baseball_Unit.speed = 1
        Baseball[Baseball_Number].Baseball_Unit.run(SKAction.follow(BallPath.cgPath, asOffset: false, orientToPath: false, speed: Baseball_Speed), completion: {
            self.Baseball_Static(Baseball_Number)
        }) 
        Baseball[Baseball_Number].Baseball_Image.isHidden = false
        Baseball[Baseball_Number].Baseball_Shadow.isHidden = false
    }
    /// 扔回
    ///
    /// - parameter Baseball_Number: 激活球号
    /// - parameter contact:         接触点
    func Baseball_Return(_ Baseball_Number: Int,contact: CGPoint){
        Baseball[Baseball_Number].Baseball_Unit.removeAllActions()
        
        Baseball[Baseball_Number].Baseball_Power = GameObject.Baseball_Power(ball_x: 2,ball_y: 0,height: 2, length: 35)
        let BallPath = UIBezierPath()
        BallPath.move(to: Baseball[Baseball_Number].Baseball_Unit.position)
        switch Naoe_Riki.attribute.imageNumber.hashValue{
        case 4:
            let HeightRatio = (contact.x - GamePeople().Naoe_Riki_Contact()[0].boundingBox.minX) / GamePeople().Naoe_Riki_Contact()[0].boundingBox.width
            BallPath.addLine(to: CGPoint(x: Baseballfield.frame.width / 2, y: Baseballfield.frame.height * (1 - HeightRatio) - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
            break
        case 5:
            let WidthRatio = (contact.x - GamePeople().Naoe_Riki_Contact()[1].boundingBox.minX) / GamePeople().Naoe_Riki_Contact()[1].boundingBox.width
            BallPath.addLine(to: CGPoint(x: Baseballfield.frame.width * WidthRatio - Baseballfield.frame.width * Baseballfield.anchorPoint.x, y: Baseballfield.frame.height - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
            break
        default:
            let HeightRatio = (contact.x - GamePeople().Naoe_Riki_Contact()[2].boundingBox.minX) / GamePeople().Naoe_Riki_Contact()[2].boundingBox.width
            BallPath.addLine(to: CGPoint(x: -Baseballfield.frame.width / 2, y: Baseballfield.frame.height * HeightRatio - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
            break
        }
        
        let path = CGMutablePath()
        Baseball_ReturnPoint = Baseball[Baseball_Number].Baseball_Unit.position
        Baseball_Angle = GetAngle(Baseball[Baseball_Number].Baseball_Unit.position, b: BallPath.currentPoint)
        path.move(to: CGPoint(x: BallPath.currentPoint.x,y: BallPath.currentPoint.y))
        path.addLine(to: CGPoint(x: Baseball[Baseball_Number].Baseball_Unit.position.x, y: Baseball[Baseball_Number].Baseball_Unit.position.y))
        BallTrackPath.physicsBody = SKPhysicsBody(edgeChainFrom: path)
        BallTrackPath.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.BallTrackPath
        BallTrackPath.physicsBody?.collisionBitMask = 0
        BallTrackPath.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.PeopleBehind
        Baseballfield.addChild(BallTrackPath)
        
        Baseball[Baseball_Number].Baseball_Status = .b_Return
        Baseball[Baseball_Number].Baseball_Unit.speed = 1
        Baseball[Baseball_Number].Baseball_Unit.run(SKAction.follow(BallPath.cgPath, asOffset: false, orientToPath: false, speed: 500), completion: {
            self.Baseball_Static(Baseball_Number)
        }) 
        Baseball[Baseball_Number].Baseball_Unit.run(SKAction.speed(to: 0, duration: 5), completion: { () -> Void in
            self.Baseball_Static(Baseball_Number)
        })
        
        //各角色运动
        //棗 恭介
        if Baseball_Angle < GetAngle(contact, b: GamePeople().Natsume_Kyousuke_Range().position) && Baseball_Angle > GetAngle(contact, b: CGPoint(x: Natsume_Kyousuke_Range.position.x + Natsume_Kyousuke_Range.frame.width, y: Natsume_Kyousuke_Range.position.y + Natsume_Kyousuke_Range.frame.height)){
            Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_Run.hashValue
        }
    }
    /// 静止
    ///
    /// - parameter Baseball_Number: 激活球号
    func Baseball_Static(_ Baseball_Number: Int){
        Baseball[Baseball_Number].Baseball_Image.isHidden = true
        Baseball[Baseball_Number].Baseball_Shadow.isHidden = true
        Baseball[Baseball_Number].Baseball_Status = .b_Static
        Baseball[Baseball_Number].Baseball_Unit.removeAllActions()
        Baseballfield.removeChildren(in: [BallTrackPath])
    }
    /// 获得角度
    ///
    /// - parameter a: 始点
    /// - parameter b: 终点
    ///
    /// - returns: 角度
    func GetAngle(_ a: CGPoint, b: CGPoint) -> CGFloat{
        let x = a.x
        let y = a.y
        let dx = b.x - x
        let dy = b.y - y
        let radians = atan2(-dx, dy)
        let degrees = radians * 180 / 3.14
        return degrees
    }
    
    //MARK: 视图
    /// 移动地图
    ///
    /// - parameter Object_Point: 移动点至
    func Status_View(_ Object_Point: CGPoint){
        Baseballfield.position = CGPoint(x: -Object_Point.x + (size.width / 2), y: -Object_Point.y + (size.height / 2))
    }
    
    
    //MARK: 物理撞击
    func didBegin(_ contact: SKPhysicsContact) {
        //棒球碰撞
        if contact.bodyA.categoryBitMask == Collision.Baseball || contact.bodyB.categoryBitMask == Collision.Baseball{
            let ContactUnit = contact.bodyA.categoryBitMask == Collision.Baseball ? contact.bodyB : contact.bodyA
            switch ContactUnit.categoryBitMask{
            //棒球棍
            case Collision.BaseballBat:
                switch Baseball[0].Baseball_Status{
                case .b_Throw, .b_ReturnAgain:
                    print("击球后")
                    Baseball_Return(0, contact: convert(contact.contactPoint, to: Naoe_Riki_View))
                    break
                default:
                    break
                }
                break
            //前方人物单位
            case Collision.PeopleFront:
                switch Baseball[0].Baseball_Status{
                case .b_Throw:
                    print("理树被击中")
                    Naoe_Riki.attribute.status = GamePeople.Naoe_Riki_Status.nr_FallDown.hashValue
                    Natsume_Rin.attribute.status = GamePeople.Natsume_Rin_Status.nr_Surprise.hashValue
                    Baseball_Static(0)
                    break
                default:
                    break
                }
                break
            //后方人物单位
            case Collision.PeopleBehind:
                switch Natsume_Kyousuke.attribute.status{
                case GamePeople.Natsume_Kyousuke_Status.nk_Catch.hashValue:
                    print("投掷")
                    Baseball_Static(0)
                    Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_PickUp.hashValue
                    break
                default:
                    break
                }
                break
            default:
                break
            }
        }
        //球运动路径碰撞
        if contact.bodyA.categoryBitMask == Collision.BallTrackPath || contact.bodyB.categoryBitMask == Collision.BallTrackPath{
            let ContactUnit = contact.bodyA.categoryBitMask == Collision.BallTrackPath ? contact.bodyB : contact.bodyA
            switch ContactUnit.categoryBitMask{
            //后方人物单位
            case Collision.PeopleBehind:
                switch Natsume_Kyousuke.attribute.status{
                case GamePeople.Natsume_Kyousuke_Status.nk_Run.hashValue:
                    Baseballfield.removeChildren(in: [BallTrackPath])
                    if Natsume_Kyousuke.attribute.Unit.position.x < Baseball[0].Baseball_Unit.position.x{
                        self.Natsume_Kyousuke_Static()
                        Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_Catch.hashValue
                        print("定位")
                    }
                    else{
                        self.Natsume_Kyousuke_Static()
                        self.Natsume_Kyousuke.attribute.status = GamePeople.Natsume_Kyousuke_Status.nk_Return.hashValue
                    }
                    break
                default:
                    break
                }
                break
            default:
                break
            }

        }
    }
    
}

