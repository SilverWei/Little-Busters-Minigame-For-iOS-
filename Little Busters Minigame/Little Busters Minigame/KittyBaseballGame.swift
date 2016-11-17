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
    var Baseball = GameObject.Baseball()
    
    //MARK: 初始化角色
    //直枝 理樹
    var Naoe_Riki = GamePeople.Naoe_Riki.Main()
    //棗 鈴
    var Natsume_Rin = GamePeople.Natsume_Rin.Main()
    //棗 恭介
    var Natsume_Kyousuke = GamePeople.Natsume_Kyousuke.Main()

    //MARK: 初始化按钮
    var MovingButton_View = GameObject.MovingButton().Main()
    var MovingButton_Up = GameObject.MovingButton().UP_View()
    var MovingButton_Down = GameObject.MovingButton().Down_View()
    var MovingButton_Left = GameObject.MovingButton().Left_View()
    var MovingButton_Right = GameObject.MovingButton().Right_View()
    var MovingButton_Status = GameObject.MovingButton.TouchStatus.stop
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
        Show_Baseball()//显示棒球
        Show_Button()//显示按钮
        Show_Shadow()//显示阴影
    }
    
    //MARK: 显示元素
    func Show_Baseballfield(){
        GameView.addChild(Baseballfield)
    }
    
    func Show_PeopleFront(){
        Naoe_Riki.View.position = Naoe_Riki.Unit.attribute.point
        Naoe_Riki.View.zPosition = Layers.peopleFront.rawValue
        Naoe_Riki.Unit.attribute.Unit.position = Naoe_Riki.Unit.attribute.point
        Naoe_Riki.Unit.attribute.Unit.addChild(GamePeople.Naoe_Riki().BodyContact())
        Baseballfield.addChild(Naoe_Riki.Unit.attribute.Unit)
        Baseballfield.addChild(Naoe_Riki.View)

        Naoe_Riki.Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Naoe_Riki.Range)
    }
    
    func Show_PeopleBehind(){
        Natsume_Rin.View.position = Natsume_Rin.Unit.attribute.point
        Natsume_Rin.View.zPosition = Layers.peopleBehind.rawValue
        Baseballfield.addChild(Natsume_Rin.View)
        
        Natsume_Kyousuke.View.position = Natsume_Kyousuke.Unit.attribute.point
        Natsume_Kyousuke.View.zPosition = Layers.peopleBehind.rawValue
        Natsume_Kyousuke.Unit.attribute.Unit.position = Natsume_Kyousuke.View.position
        Natsume_Kyousuke.Unit.attribute.Unit.speed = 0
        Baseballfield.addChild(Natsume_Kyousuke.View)
        Baseballfield.addChild(Natsume_Kyousuke.Unit.attribute.Unit)
        
        Natsume_Kyousuke.Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Natsume_Kyousuke.Range)
    }
    
    func Show_Baseball(){
        Baseball.set.append(GameObject.Baseball.Attribute())
        Baseball.set[0].Image.zPosition = Layers.baseball.rawValue
        Baseballfield.addChild(Baseball.set[0].Image)
        Baseball.set[0].Image.isHidden = true
        
        //棒球位置
        Baseball.set[0].Unit.position = Baseball.set[0].Image.position
        Baseballfield.addChild(Baseball.set[0].Unit)
    }
    
    func Show_Shadow(){
        Naoe_Riki.Unit.attribute.Shadow = GameObject().Shadow(Naoe_Riki.Unit.attribute.point.x + Naoe_Riki.Unit.attribute.Shadow_x, y: Naoe_Riki.Unit.attribute.point.y + Naoe_Riki.Unit.attribute.Shadow_y, w: Naoe_Riki.Unit.attribute.Shadow_w, h: Naoe_Riki.Unit.attribute.Shadow_h)
        Baseballfield.addChild(Naoe_Riki.Unit.attribute.Shadow)
        
        Natsume_Rin.Unit.attribute.Shadow = GameObject().Shadow(Natsume_Rin.Unit.attribute.point.x + Natsume_Rin.Unit.attribute.Shadow_x, y: Natsume_Rin.Unit.attribute.point.y + Natsume_Rin.Unit.attribute.Shadow_y, w: Natsume_Rin.Unit.attribute.Shadow_w, h: Natsume_Rin.Unit.attribute.Shadow_h)
        Baseballfield.addChild(Natsume_Rin.Unit.attribute.Shadow)
        
        Natsume_Kyousuke.Unit.attribute.Shadow = GameObject().Shadow(Natsume_Kyousuke.Unit.attribute.point.x + Natsume_Kyousuke.Unit.attribute.Shadow_x, y: Natsume_Kyousuke.Unit.attribute.point.y + Natsume_Kyousuke.Unit.attribute.Shadow_y, w: Natsume_Kyousuke.Unit.attribute.Shadow_w, h: Natsume_Kyousuke.Unit.attribute.Shadow_h)
        Baseballfield.addChild(Natsume_Kyousuke.Unit.attribute.Shadow)
        
        Baseball.set[0].Shadow = GameObject().Shadow(Baseball.set[0].Image.position.x, y: Baseball.set[0].Image.position.y, w: Baseball.set[0].Image.frame.width, h: Baseball.set[0].Image.frame.height / 2)
        Baseballfield.addChild(Baseball.set[0].Shadow)
        Baseball.set[0].Shadow.isHidden = true
        
    }
    
    func Show_Button(){
        
        MovingButton_View.zPosition = KittyBaseballGame.Layers.button.rawValue
        MovingButton_View.addChild(MovingButton_Up)
        MovingButton_View.addChild(MovingButton_Down)
        MovingButton_View.addChild(MovingButton_Left)
        MovingButton_View.addChild(MovingButton_Right)
        GameView.addChild(MovingButton_View)
        
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
                if(Baseball.set[0].Status != GameObject.Baseball.All_Status.b_Throw && Baseball.set[0].Status != GameObject.Baseball.All_Status.b_Return && Baseball.set[0].Status != GameObject.Baseball.All_Status.b_ReturnAgain && Natsume_Rin.Unit.attribute.status == GamePeople.Natsume_Rin.Status.nr_Static.hashValue){
                    self.Natsume_Rin.Unit.attribute.imageNumber = 0
                    self.Natsume_Rin.Unit.attribute.status = GamePeople.Natsume_Rin.Status.nr_Swing.hashValue
                }
            }
            else{
                if Naoe_Riki.Unit.attribute.status != GamePeople.Naoe_Riki.Status.nr_FallDown.hashValue{
                    Naoe_Riki.Unit.attribute.status = GamePeople.Naoe_Riki.Status.nr_Swing.hashValue
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
                //print("Baseballfield:",Baseballfield.position)
            }
        }
    }
    func touchesButton(_ location: CGPoint) -> Bool {
        if MovingButton_Up.contains(location) {
            MovingButton_Status = .up
            MovingButton_Up.fillColor = SKColor.white
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
        MovingButton_Up.fillColor = SKColor.clear
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
        Baseball.set[0].Power.ball_x = Baseball.set[0].Power.ball_x + CGFloat(DateTime) * 50
        
        //更新人物状态
        Status_Naoe_Riki() //理 树
        Status_Natsume_Rin() //棗 鈴
        Status_Natsume_Kyousuke() //棗 恭介
        Baseball_Status(0) //棒 球
        
        //棒球状态
        switch Baseball.set[0].Status{
        case .b_Static:
            break
        case .b_Throw:
            break
        case .b_Return:
            Status_View(Baseball.set[0].Unit.position)
            break
        case .b_ReturnAgain:
            Status_View(Baseball.set[0].Unit.position)
            break
            
        }

    }
    
    //MARK: 动作更新
    //MARK: 理 樹
    func Status_Naoe_Riki(){
        //移动
        if(Naoe_Riki.Unit.attribute.status != GamePeople.Naoe_Riki.Status.nr_FallDown.hashValue){
            var position = Naoe_Riki.Unit.attribute.Unit.position
            switch MovingButton_Status{
            case .up:
                position = CGPoint(x: position.x, y: position.y + 1)
                break
            case .down:
                position = CGPoint(x: position.x, y: position.y - 1)
                break
            case .left:
                position = CGPoint(x: position.x - 1, y: position.y)
                break
            case .right:
                position = CGPoint(x: position.x + 1, y: position.y)
                break
            default:
                break
            }
            if(position.x < Naoe_Riki.Range.position.x){
                position.x = Naoe_Riki.Range.position.x
            }
            if(position.x > Naoe_Riki.Range.position.x + Naoe_Riki.Range.frame.width){
                position.x = Naoe_Riki.Range.position.x + Naoe_Riki.Range.frame.width
            }
            if(position.y < Naoe_Riki.Range.position.y){
                position.y = Naoe_Riki.Range.position.y
            }
            if(position.y > Naoe_Riki.Range.position.y + Naoe_Riki.Range.frame.height){
                position.y = Naoe_Riki.Range.position.y + Naoe_Riki.Range.frame.height
            }
            Naoe_Riki.Unit.attribute.Shadow.position = CGPoint(x: position.x + Naoe_Riki.Unit.attribute.Shadow_x, y: position.y + Naoe_Riki.Unit.attribute.Shadow_y)
            Naoe_Riki.Unit.attribute.Unit.position = position
            Naoe_Riki.View.position = Naoe_Riki.Unit.attribute.Unit.position
        }
        
        var TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.01)) //帧数刷新延时
        
        ///状态
        switch Naoe_Riki.Unit.attribute.status{
        //挥动
        case GamePeople.Naoe_Riki.Status.nr_Swing.hashValue:
            if((action(forKey: "Naoe_Riki_StatusAction")) != nil){
                return
            }
            if(Naoe_Riki.Unit.attribute.imageNumber.hashValue > 9){
                Naoe_Riki.Unit.attribute.imageNumber = 0
                Naoe_Riki.View.run(SKAction.setTexture(SKTexture(image: Naoe_Riki.Unit.image[Naoe_Riki.Unit.attribute.imageNumber])))
                Naoe_Riki.Unit.attribute.status = GamePeople.Naoe_Riki.Status.nr_Static.hashValue
                return
            }
            switch Naoe_Riki.Unit.attribute.imageNumber.hashValue{
            case 9:
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.2))
                break
            case 3:
                Naoe_Riki.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Naoe_Riki().Contact()[0])
                break
            case 4:
                Naoe_Riki.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Naoe_Riki().Contact()[1])
                break
            case 5:
                Naoe_Riki.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Naoe_Riki().Contact()[2])
                break
            default:
                Naoe_Riki.View.physicsBody = nil
                break
            }
            
            Naoe_Riki.View.physicsBody?.categoryBitMask = Collision.BaseballBat
            Naoe_Riki.View.physicsBody?.collisionBitMask = 0
            Naoe_Riki.View.physicsBody?.contactTestBitMask = Collision.Baseball
            
            break
        //摔倒
        case GamePeople.Naoe_Riki.Status.nr_FallDown.hashValue:
            if((action(forKey: "Naoe_Riki_StatusAction")) != nil && Naoe_Riki.Unit.attribute.status == GamePeople.Naoe_Riki.Status.nr_FallDown.hashValue){
                return
            }
            Naoe_Riki.View.physicsBody = nil
            TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.05))
            if(Naoe_Riki.Unit.attribute.imageNumber.hashValue > 31){
                Naoe_Riki.Unit.attribute.imageNumber = 0
                Naoe_Riki.View.run(SKAction.setTexture(SKTexture(image: Naoe_Riki.Unit.image[Naoe_Riki.Unit.attribute.imageNumber])))
                Naoe_Riki.View.size = Naoe_Riki.Unit.image[Naoe_Riki.Unit.attribute.imageNumber].size
                Naoe_Riki.Unit.attribute.status = GamePeople.Naoe_Riki.Status.nr_Static.hashValue
                return
            }
            if(Naoe_Riki.Unit.attribute.imageNumber.hashValue < 10){
                Naoe_Riki.Unit.attribute.imageNumber = 10
            }
            if(Naoe_Riki.Unit.attribute.imageNumber.hashValue > 16){
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
            }
            if(Naoe_Riki.Unit.attribute.imageNumber.hashValue == 18){
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(2))
            }
            break
        default:
            break
        }
        if(Naoe_Riki.Unit.attribute.status != GamePeople.Naoe_Riki.Status.nr_Static.hashValue){
            let Naoe_Riki_Start = SKAction.run(Naoe_Riki_Swing)
            let Naoe_Riki_SwingAction = SKAction.sequence([Naoe_Riki_Start,TimeInterval])
            run(Naoe_Riki_SwingAction, withKey: "Naoe_Riki_StatusAction")
        }
        
    }
    func Naoe_Riki_Swing(){
        Naoe_Riki.View.size = Naoe_Riki.Unit.image[Naoe_Riki.Unit.attribute.imageNumber].size
        Naoe_Riki.View.run(SKAction.setTexture(SKTexture(image: Naoe_Riki.Unit.image[Naoe_Riki.Unit.attribute.imageNumber])))
        Naoe_Riki.Unit.attribute.imageNumber += 1
    }
    
    //MARK: 棗 鈴
    func Status_Natsume_Rin(){
        if((action(forKey: "Natsume_Rin_StatusAction")) != nil){
            return
        }
        //帧数刷新延时
        var TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.05))
        switch Natsume_Rin.Unit.attribute.status{
        //挥动
        case GamePeople.Natsume_Rin.Status.nr_Swing.hashValue:
            if(Natsume_Rin.Unit.attribute.imageNumber.hashValue < 9){
                Natsume_Rin.Unit.attribute.imageNumber = 9
                self.Baseball.set[0].Status = .b_Throw
                //角色归位
                self.Natsume_Kyousuke_Static()
                self.Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
            }
            if(Natsume_Rin.Unit.attribute.imageNumber.hashValue > 15){
                Natsume_Rin_Static()
                return
            }

            switch Natsume_Rin.Unit.attribute.imageNumber.hashValue{
            case 9:
                Baseballfield.position = GameObject().Baseballfield().position
                break
            case 10:
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(2))
                break
            case 12:
                Baseball.set[0].Power = GameObject.Baseball.Power(ball_x: 2,ball_y: 0,height: 3, length: 30)
                Baseball.Jumps = 2
                Baseball.Speed = 400
                let BallPath = UIBezierPath()
                BallPath.move(to: CGPoint(x: GameObject.Baseball().Image_View().position.x, y: GameObject.Baseball().Image_View().position.y))
                BallPath.addLine(to: CGPoint(x: GameObject.Baseball().Image_View().position.x, y: -(Baseballfield.frame.height * Baseballfield.anchorPoint.y)))
                Baseball_ThrowPath(Number: 0,BallPath: BallPath)
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
        case GamePeople.Natsume_Rin.Status.nr_Surprise.hashValue:
            if(Natsume_Rin.Unit.attribute.imageNumber.hashValue < 15){
                Natsume_Rin.Unit.attribute.imageNumber = 15
            }
            if(Natsume_Rin.Unit.attribute.imageNumber.hashValue > 22){
                Natsume_Rin_Static()
                return
            }
            
            TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
            
            switch Natsume_Rin.Unit.attribute.imageNumber.hashValue{
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
        Natsume_Rin.Unit.attribute.imageNumber = 0
        Natsume_Rin.View.run(SKAction.setTexture(SKTexture(image: Natsume_Rin.Unit.image[Natsume_Rin.Unit.attribute.imageNumber])))
        Natsume_Rin.View.size = Natsume_Rin.Unit.image[Natsume_Rin.Unit.attribute.imageNumber].size
        Natsume_Rin.Unit.attribute.status = GamePeople.Natsume_Rin.Status.nr_Static.hashValue
    }
    func Natsume_Rin_StatusAction(_ TimeInterval:SKAction){
        let Natsume_Rin_Start = SKAction.run(Natsume_Rin_Swing)
        let Natsume_Rin_SwingAction = SKAction.sequence([Natsume_Rin_Start,TimeInterval])
        run(Natsume_Rin_SwingAction, withKey: "Natsume_Rin_StatusAction")
    }
    func Natsume_Rin_Swing(){
        Natsume_Rin.View.size = Natsume_Rin.Unit.image[Natsume_Rin.Unit.attribute.imageNumber].size
        Natsume_Rin.View.run(SKAction.setTexture(SKTexture(image: Natsume_Rin.Unit.image[Natsume_Rin.Unit.attribute.imageNumber])))
        Natsume_Rin.Unit.attribute.imageNumber += 1
    }
    
    //MARK: 棗 恭介
    func Status_Natsume_Kyousuke(){
        //帧数刷新延时
        let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
        switch Natsume_Kyousuke.Unit.attribute.status{
        //跑
        case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
            let PathAngle = GetAngle(Baseball.set[0].Unit.position, b: Natsume_Kyousuke.Unit.attribute.Unit.position) //路径角度
            if(Natsume_Kyousuke.Unit.attribute.Unit.speed == 0){
                Natsume_Kyousuke.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Natsume_Kyousuke.Unit.attribute.Unit.position)
                if(PathAngle > Baseball.Angle){
                    RunPath.addLine(to: CGPoint(x: Natsume_Kyousuke.Range.position.x + Natsume_Kyousuke.Range.frame.width, y: Natsume_Kyousuke.Range.position.y + Natsume_Kyousuke.Range.frame.height))
                }
                else{
                    RunPath.addLine(to: Natsume_Kyousuke.Range.position)
                }
                
                Natsume_Kyousuke.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Natsume_Kyousuke().RunContact())
                Natsume_Kyousuke.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind
                Natsume_Kyousuke.View.physicsBody?.collisionBitMask = 0
                Natsume_Kyousuke.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BallTrackPath
                Natsume_Kyousuke.Unit.attribute.Unit.speed = 1
                Natsume_Kyousuke.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 200), completion: { () -> Void in
                    self.Natsume_Kyousuke_Static()
                    self.Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
                })
            }
            Natsume_Kyousuke.Unit.attribute.Shadow.position = CGPoint(x: Natsume_Kyousuke.Unit.attribute.Unit.position.x + Natsume_Kyousuke.Unit.attribute.Shadow_x, y: Natsume_Kyousuke.Unit.attribute.Unit.position.y + Natsume_Kyousuke.Unit.attribute.Shadow_y)
            Natsume_Kyousuke.View.position = Natsume_Kyousuke.Unit.attribute.Unit.position
            
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if PathAngle > Baseball.Angle{
                if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue < 8 || Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue > 11){
                    Natsume_Kyousuke.Unit.attribute.imageNumber = 8
                }
            }
            else{
                if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue < 24 || Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue > 27){
                    Natsume_Kyousuke.Unit.attribute.imageNumber = 24
                }
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //静止
        case GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue:
            Natsume_Kyousuke.View.physicsBody = nil
            break
        //返回
        case GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue:
            if(Natsume_Kyousuke.Unit.attribute.Unit.speed == 0){
                Natsume_Kyousuke.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Natsume_Kyousuke.Unit.attribute.Unit.position)
                RunPath.addLine(to: GamePeople.Natsume_Kyousuke().Attribute.point)
                Natsume_Kyousuke.Unit.attribute.Unit.speed = 1
                Natsume_Kyousuke.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 200), completion: { () -> Void in
                    self.Natsume_Kyousuke_Static()
                })
            }
            Natsume_Kyousuke.Unit.attribute.Shadow.position = CGPoint(x: Natsume_Kyousuke.Unit.attribute.Unit.position.x + Natsume_Kyousuke.Unit.attribute.Shadow_x, y: Natsume_Kyousuke.Unit.attribute.Unit.position.y + Natsume_Kyousuke.Unit.attribute.Shadow_y)
            Natsume_Kyousuke.View.position = Natsume_Kyousuke.Unit.attribute.Unit.position
            
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if Natsume_Kyousuke.Unit.attribute.Unit.position.x < GamePeople.Natsume_Kyousuke().Attribute.point.x{
                if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue < 8 || Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue > 11){
                    Natsume_Kyousuke.Unit.attribute.imageNumber = 8
                }
            }
            else{
                if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue < 24 || Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue > 27){
                    Natsume_Kyousuke.Unit.attribute.imageNumber = 24
                }
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //接球
        case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
            Natsume_Kyousuke.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Natsume_Kyousuke().BodyContact())
            Natsume_Kyousuke.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind
            Natsume_Kyousuke.View.physicsBody?.collisionBitMask = 0
            Natsume_Kyousuke.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
            
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if(hypot(Natsume_Kyousuke.Unit.attribute.Unit.position.x - Baseball.set[0].Unit.position.x, Natsume_Kyousuke.Unit.attribute.Unit.position.y - Baseball.set[0].Unit.position.y) > 200){
                return
            }
            if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue < 72){
                Natsume_Kyousuke.Unit.attribute.imageNumber = 72
            }
            if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue > 73){
                Natsume_Kyousuke.Unit.attribute.imageNumber = 73
            }
            
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //捡起
        case GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue:
            Natsume_Kyousuke.View.physicsBody = nil
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue < 74){
                Natsume_Kyousuke.Unit.attribute.imageNumber = 74
            }
            if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue > 75){
                Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue
                Natsume_Kyousuke.Unit.attribute.imageNumber = 0
                return
            }
            Natsume_Kyousuke_StatusAction(TimeInterval)
            break
        //挥动
        case GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue:
            if((action(forKey: "Natsume_Kyousuke_StatusAction")) != nil){
                return
            }
            if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue < 48){
                Natsume_Kyousuke.Unit.attribute.imageNumber = 48
            }
            if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue > 51){
                self.Natsume_Kyousuke_Static()
            }
            
            if(Natsume_Kyousuke.Unit.attribute.imageNumber.hashValue == 50){
                Baseball_Throw(Power: GameObject.Baseball.Power(ball_x: 2,ball_y: 0,height: 8, length: 40), Speed: 600, Number: 0)
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
        Natsume_Kyousuke.View.size = Natsume_Kyousuke.Unit.image[Natsume_Kyousuke.Unit.attribute.imageNumber].size
        Natsume_Kyousuke.View.run(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.Unit.image[Natsume_Kyousuke.Unit.attribute.imageNumber])))
        Natsume_Kyousuke.Unit.attribute.imageNumber += 1
    }
    func Natsume_Kyousuke_Static(){
        Natsume_Kyousuke.Unit.attribute.imageNumber = 0
        Natsume_Kyousuke.View.run(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.Unit.image[0])))
        Natsume_Kyousuke.View.size = Natsume_Kyousuke.Unit.image[Natsume_Kyousuke.Unit.attribute.imageNumber].size
        Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue
        Natsume_Kyousuke.Unit.attribute.Unit.speed = 0
    }
    
    //MARK: 棒球
    func Baseball_Status(_ Number: Int){
        Baseball.set[Number].Power.ball_y = (-(Baseball.set[Number].Power.ball_x * Baseball.set[Number].Power.ball_x) + Baseball.set[Number].Power.length * Baseball.set[Number].Power.ball_x) / Baseball.set[Number].Power.height
        if(Baseball.set[Number].Power.ball_y < 0){
            if Baseball.set[Number].Power.height < 12 {
                Baseball.set[Number].Power.ball_x = 0
                Baseball.set[Number].Power.height = Baseball.set[Number].Power.height * Baseball.Jumps
                Baseball.Jumps += 1
            }
            else{
                Baseball.set[Number].Power.ball_y = 0
            }
        }
        
        Baseball.set[Number].Image.position = CGPoint(x: Baseball.set[Number].Unit.position.x, y: Baseball.set[Number].Unit.position.y + Baseball.set[Number].Power.ball_y)
        Baseball.set[Number].Shadow.position = CGPoint(x: Baseball.set[0].Unit.position.x, y: Baseball.set[0].Unit.position.y)
        
    }
    /// 棒球仍回
    ///
    /// - parameter Power:  动作参数
    /// - parameter Speed:  速度
    /// - parameter Number: 棒球目标
    func Baseball_Throw(Power: GameObject.Baseball.Power, Speed: Int, Number: Int){
        Baseball.set[Number].Power = Power
        Baseball.Jumps = 2
        Baseball.Speed = CGFloat(Speed)
        let BallPath = UIBezierPath()
        Baseball.PeopleBehindCatchPoint = Baseball.set[0].Unit.position
        BallPath.move(to: Baseball.PeopleBehindCatchPoint)
        Baseball.PeopleFrontCatchPoint = Naoe_Riki.Unit.attribute.point
        Baseball.PeopleFrontCatchPoint.y -= 20
        Baseball.PeopleFrontCatchPoint.x += 5
        var PathAngle = GetAngle(Baseball.PeopleBehindCatchPoint, b: Naoe_Riki.Unit.attribute.point)
        PathAngle = PathAngle + 90
        let mainPath = UIBezierPath(arcCenter: Baseball.PeopleBehindCatchPoint, radius: 2000, startAngle: 0, endAngle: CGFloat(M_PI) * (PathAngle / 180), clockwise: true)
        print("角度:",PathAngle)
        print("角度2：",GetAngle(mainPath.currentPoint, b: Baseball.PeopleBehindCatchPoint))
        print("位置:",mainPath.currentPoint)
        BallPath.addLine(to: mainPath.currentPoint)
        
        Baseball_ThrowPath(Number: 0,BallPath: BallPath)
        Baseball.set[Number].Unit.run(SKAction.speed(to: 0, duration: 5), completion: { () -> Void in
            self.Baseball_Static(0)
        })
        Baseball.set[Number].Status = GameObject.Baseball.All_Status.b_ReturnAgain
    }
    /// 扔出路径
    ///
    /// - parameter Number: 激活球号
    /// - parameter BallPath:        移动路径
    func Baseball_ThrowPath(Number:Int,BallPath: UIBezierPath){
        Baseball.set[Number].Unit.speed = 1
        Baseball.set[Number].Unit.run(SKAction.follow(BallPath.cgPath, asOffset: false, orientToPath: false, speed: Baseball.Speed), completion: {
            self.Baseball_Static(Number)
        }) 
        Baseball.set[Number].Image.isHidden = false
        Baseball.set[Number].Shadow.isHidden = false
    }
    /// 击回
    ///
    /// - parameter Number: 激活球号
    /// - parameter contact:         接触点
    func Baseball_Return(_ Number: Int,contact: CGPoint){
        Baseball.set[Number].Unit.removeAllActions()
        Baseball.set[Number].Power = GameObject.Baseball.Power(ball_x: 2,ball_y: 0,height: 2, length: 35)
        let BallPath = UIBezierPath()
        BallPath.move(to: Baseball.set[Number].Unit.position)
        switch Naoe_Riki.Unit.attribute.imageNumber.hashValue{
        case 4:
            let HeightRatio = (contact.x - GamePeople.Naoe_Riki().Contact()[0].boundingBox.minX) / GamePeople.Naoe_Riki().Contact()[0].boundingBox.width
            BallPath.addLine(to: CGPoint(x: Baseballfield.frame.width / 2, y: Baseballfield.frame.height * (1 - HeightRatio) - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
            break
        case 5:
            let WidthRatio = (contact.x - GamePeople.Naoe_Riki().Contact()[1].boundingBox.minX) / GamePeople.Naoe_Riki().Contact()[1].boundingBox.width
            BallPath.addLine(to: CGPoint(x: Baseballfield.frame.width * WidthRatio - Baseballfield.frame.width * Baseballfield.anchorPoint.x, y: Baseballfield.frame.height - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
            break
        default:
            let HeightRatio = (contact.x - GamePeople.Naoe_Riki().Contact()[2].boundingBox.minX) / GamePeople.Naoe_Riki().Contact()[2].boundingBox.width
            BallPath.addLine(to: CGPoint(x: -Baseballfield.frame.width / 2, y: Baseballfield.frame.height * HeightRatio - Baseballfield.frame.height * Baseballfield.anchorPoint.y))
            break
        }
        
        let path = CGMutablePath()
        Baseball.Angle = GetAngle(Baseball.set[Number].Unit.position, b: BallPath.currentPoint)
        path.move(to: CGPoint(x: BallPath.currentPoint.x,y: BallPath.currentPoint.y))
        path.addLine(to: CGPoint(x: Baseball.set[Number].Unit.position.x, y: Baseball.set[Number].Unit.position.y))
        Baseball.TrackPath.physicsBody = SKPhysicsBody(edgeChainFrom: path)
        Baseball.TrackPath.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.BallTrackPath
        Baseball.TrackPath.physicsBody?.collisionBitMask = 0
        Baseball.TrackPath.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.PeopleBehind
        Baseballfield.addChild(Baseball.TrackPath)
        
        Baseball.set[Number].Status = .b_Return
        Baseball.set[Number].Unit.speed = 1
        Baseball.set[Number].Unit.run(SKAction.follow(BallPath.cgPath, asOffset: false, orientToPath: false, speed: 500), completion: {
            self.Baseball_Static(Number)
        }) 
        Baseball.set[Number].Unit.run(SKAction.speed(to: 0, duration: 5), completion: { () -> Void in
            self.Baseball_Static(Number)
        })
        
        //各角色运动
        //棗 恭介
        if Baseball.Angle < GetAngle(contact, b: GamePeople.Natsume_Kyousuke().Range().position) && Baseball.Angle > GetAngle(contact, b: CGPoint(x: Natsume_Kyousuke.Range.position.x + Natsume_Kyousuke.Range.frame.width, y: Natsume_Kyousuke.Range.position.y + Natsume_Kyousuke.Range.frame.height)){
            Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
        }
    }
    /// 静止
    ///
    /// - parameter Number: 激活球号
    func Baseball_Static(_ Number: Int){
        Baseball.set[Number].Image.isHidden = true
        Baseball.set[Number].Shadow.isHidden = true
        Baseball.set[Number].Status = .b_Static
        Baseball.set[Number].Unit.removeAllActions()
        Baseballfield.removeChildren(in: [Baseball.TrackPath])
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
                switch Baseball.set[0].Status{
                case .b_Throw, .b_ReturnAgain:
                    Baseball_Return(0, contact: convert(contact.contactPoint, to: Naoe_Riki.View))
                    break
                default:
                    break
                }
                break
            //前方人物单位
            case Collision.PeopleFront:
                switch Baseball.set[0].Status{
                case .b_Throw:
                    Naoe_Riki.Unit.attribute.status = GamePeople.Naoe_Riki.Status.nr_FallDown.hashValue
                    Natsume_Rin.Unit.attribute.status = GamePeople.Natsume_Rin.Status.nr_Surprise.hashValue
                    Baseball_Static(0)
                    break
                default:
                    break
                }
                break
            //后方人物单位
            case Collision.PeopleBehind:
                switch Natsume_Kyousuke.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
                    Baseball_Static(0)
                    Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue
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
                switch Natsume_Kyousuke.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
                    Baseballfield.removeChildren(in: [Baseball.TrackPath])
                    if Natsume_Kyousuke.Unit.attribute.Unit.position.x < Baseball.set[0].Unit.position.x{
                        self.Natsume_Kyousuke_Static()
                        Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue
                    }
                    else{
                        self.Natsume_Kyousuke_Static()
                        self.Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
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

