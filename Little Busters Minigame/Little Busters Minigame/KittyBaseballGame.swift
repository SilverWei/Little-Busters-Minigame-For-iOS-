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
    var GameStatus: Status = .Play{
        didSet {
            GameStatusrRun()
        }
    }
    
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
    //来ヶ谷 唯湖
    var Kurugaya_Yuiko = GamePeople.Kurugaya_Yuiko.Main()
    //三枝 葉留佳
    var Saigusa_Haruka = GamePeople.Saigusa_Haruka.Main()
    //井ノ原 真人
    var Inohara_Masato = GamePeople.Inohara_Masato.Main()

    //MARK: 初始化按钮
    var MovingButton_View = GameObject.MovingButton().Main()
    var MovingButton_Up = GameObject.MovingButton().UP_View()
    var MovingButton_Down = GameObject.MovingButton().Down_View()
    var MovingButton_Left = GameObject.MovingButton().Left_View()
    var MovingButton_Right = GameObject.MovingButton().Right_View()
    var MovingButton_Status = GameObject.MovingButton.TouchStatus.stop
    //let TestButton = GameObject().TestButton()
    var MenuButton = GameObject().MenuButton()
    var BaseballRemaning = GameObject.BaseballRemaning()
    
    //结束菜单
    let OverView = GameObject.Window()
    let ReplayButton = GameObject().ReplayButton()
    var OverBackButton = GameObject().BackButton()
    var OverScore = GameObject.Score()
    
    
    //暂停菜单
    var PauseView = GameObject.Window()
    var PauseBackground = GameObject().WindowBackground()
    let OptionsBGM = GameObject.SoundButton()
    let OptionsSound = GameObject.SoundButton()
    var BackButton = GameObject().BackButton()
    var ResumeButton = GameObject().ResumeButton()
    
    //剩余球数
    var BaseballRemaningNumber:Int = 20
    //最高击回数
    var MostCombo:Int = 0
    //本次击回数
    var NowCombo:Int = 0
    //总分数
    var Score:Int = 0
    
    //MARK: 音效
    let Sound_Dang = SKAction.playSoundFileNamed("dang.mp3", waitForCompletion: false)
    let Sound_Ding = SKAction.playSoundFileNamed("ding.mp3", waitForCompletion: false)
    let Sound_Dong = SKAction.playSoundFileNamed("dong.mp3", waitForCompletion: false)
    let Sound_Over = SKAction.playSoundFileNamed("over.mp3", waitForCompletion: false)
    var Sound_BGM = SKAudioNode()
    
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
    /// - message:      信息
    /// - button:           按钮
    /// - PauseView:       暂停窗口
    enum Layers: CGFloat{
        case baseballfield
        case shadow
        case otherBody
        case cat
        case peopleBehind
        case baseball
        case peopleFront
        case message
        case button
        case PauseView
    }
    
    
    /// 游戏状态
    ///
    /// - Play:   游戏中
    /// - Menu:   菜单
    /// - Dialog: 对话
    /// - Other:  其他
    /// - Over:   结束
    /// - Wait:   等待
    enum Status {
        case Play
        case Menu
        case Dialog
        case Other
        case Over
        case Wait
    }
    
    //MARK: 物理层
    struct Collision {
        static let null: UInt32 = 0
        static let Baseball: UInt32 = 0b1 //棒球
        static let BaseballBat: UInt32 = 0b10 //棒球棍
        static let PeopleFront: UInt32 = 0b100 //前方人物单位
        static let PeopleBehind: [UInt32] = [0b1010,0b1011,0b10110,0b10111] //后方人物单位
        static let BallTrackPath: UInt32 = 0b111 //球运动路径
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        //关掉重力
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        //设置碰撞代理
        physicsWorld.contactDelegate = self
        
        addChild(GameView)
        
        
        Sound_BGM = SKAudioNode(fileNamed: "BGM2.mp3")
        
        Show_Baseballfield()//显示棒球场背景
        Show_PeopleFront()//显示在前面的人物
        Show_PeopleBehind()//显示在后面的人物
        Show_Baseball()//显示棒球
        Show_Button()//显示按钮
        Show_Shadow()//显示阴影
        Show_PauseView()//显示暂停页面
        
        let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(3))
        run(TimeInterval) {
            self.GameWait()
        }
        
        do{
            let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.5))
            run(TimeInterval) {
                self.addChild(self.Sound_BGM)
            }
        }
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
        
        Kurugaya_Yuiko.View.position = Kurugaya_Yuiko.Unit.attribute.point
        Kurugaya_Yuiko.View.zPosition = Layers.peopleBehind.rawValue
        Kurugaya_Yuiko.Unit.attribute.Unit.position = Kurugaya_Yuiko.View.position
        Kurugaya_Yuiko.Unit.attribute.Unit.speed = 0
        Baseballfield.addChild(Kurugaya_Yuiko.View)
        Baseballfield.addChild(Kurugaya_Yuiko.Unit.attribute.Unit)
        
        Saigusa_Haruka.View.position = Saigusa_Haruka.Unit.attribute.point
        Saigusa_Haruka.View.zPosition = Layers.peopleBehind.rawValue
        Saigusa_Haruka.Unit.attribute.Unit.position = Saigusa_Haruka.View.position
        Saigusa_Haruka.Unit.attribute.Unit.speed = 0
        Baseballfield.addChild(Saigusa_Haruka.View)
        Baseballfield.addChild(Saigusa_Haruka.Unit.attribute.Unit)
        
        Inohara_Masato.View.position = Inohara_Masato.Unit.attribute.point
        Inohara_Masato.View.zPosition = Layers.peopleBehind.rawValue
        Inohara_Masato.Unit.attribute.Unit.position = Inohara_Masato.View.position
        Inohara_Masato.Unit.attribute.Unit.speed = 0
        Baseballfield.addChild(Inohara_Masato.View)
        Baseballfield.addChild(Inohara_Masato.Unit.attribute.Unit)
        
        //移动范围显示
        Natsume_Kyousuke.Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Natsume_Kyousuke.Range)
        
        Kurugaya_Yuiko.Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Kurugaya_Yuiko.Range)
        
        Saigusa_Haruka.Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Saigusa_Haruka.Range)
        
        Inohara_Masato.Range.zPosition = Layers.peopleFront.rawValue
        Baseballfield.addChild(Inohara_Masato.Range)
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
        
        Kurugaya_Yuiko.Unit.attribute.Shadow = GameObject().Shadow(Kurugaya_Yuiko.Unit.attribute.point.x + Kurugaya_Yuiko.Unit.attribute.Shadow_x, y: Kurugaya_Yuiko.Unit.attribute.point.y + Kurugaya_Yuiko.Unit.attribute.Shadow_y, w: Kurugaya_Yuiko.Unit.attribute.Shadow_w, h: Kurugaya_Yuiko.Unit.attribute.Shadow_h)
        Baseballfield.addChild(Kurugaya_Yuiko.Unit.attribute.Shadow)
        
        Saigusa_Haruka.Unit.attribute.Shadow = GameObject().Shadow(Saigusa_Haruka.Unit.attribute.point.x + Saigusa_Haruka.Unit.attribute.Shadow_x, y: Saigusa_Haruka.Unit.attribute.point.y + Saigusa_Haruka.Unit.attribute.Shadow_y, w: Saigusa_Haruka.Unit.attribute.Shadow_w, h: Saigusa_Haruka.Unit.attribute.Shadow_h)
        Baseballfield.addChild(Saigusa_Haruka.Unit.attribute.Shadow)
        
        Inohara_Masato.Unit.attribute.Shadow = GameObject().Shadow(Inohara_Masato.Unit.attribute.point.x + Inohara_Masato.Unit.attribute.Shadow_x, y: Inohara_Masato.Unit.attribute.point.y + Inohara_Masato.Unit.attribute.Shadow_y, w: Inohara_Masato.Unit.attribute.Shadow_w, h: Inohara_Masato.Unit.attribute.Shadow_h)
        Baseballfield.addChild(Inohara_Masato.Unit.attribute.Shadow)
        
        Baseball.set[0].Shadow = GameObject().Shadow(Baseball.set[0].Image.position.x, y: Baseball.set[0].Image.position.y, w: Baseball.set[0].Image.frame.width, h: Baseball.set[0].Image.frame.height / 2)
        Baseballfield.addChild(Baseball.set[0].Shadow)
        Baseball.set[0].Shadow.isHidden = true
        
    }
    
    func Show_Button(){
        
        MovingButton_View.zPosition = Layers.button.rawValue
        MovingButton_View.addChild(MovingButton_Up)
        MovingButton_View.addChild(MovingButton_Down)
        MovingButton_View.addChild(MovingButton_Left)
        MovingButton_View.addChild(MovingButton_Right)
        GameView.addChild(MovingButton_View)
        
        //TestButton.zPosition = Layers.button.rawValue
        //GameView.addChild(TestButton)
        MenuButton.zPosition = Layers.button.rawValue
        GameView.addChild(MenuButton)
        BaseballRemaning.view.zPosition = Layers.button.rawValue
        GameView.addChild(BaseballRemaning.view)
        BaseballRemaning_Status()
        
    }
    
    func Show_PauseView(){
        PauseView.view.zPosition = Layers.PauseView.rawValue
        PauseView.label.text = "Pause"
        OptionsBGM.view.position = CGPoint(x: 0, y: PauseView.view.size.height * 0.15)
        OptionsBGM.label.text = "BGM"
        OptionsBGM.name = "OptionsBGM"
        PauseView.view.addChild(OptionsBGM.view)
        
        OptionsSound.view.position = CGPoint(x: 0, y: PauseView.view.size.height * -0.05)
        OptionsSound.label.text = "Sound"
        OptionsSound.name = "OptionsBGM"
        PauseView.view.addChild(OptionsSound.view)
        
        ResumeButton.position = CGPoint(x: 0, y: PauseView.view.size.height * -0.4)
        PauseView.view.addChild(ResumeButton)
        
        BackButton.position = CGPoint(x: 0, y: PauseView.view.size.height * -0.2)
        PauseView.view.addChild(BackButton)
        
        OptionsBGM.isOn = UserDefaults.standard.value(forKey: "Options_BGM")! as! Bool
        OptionsSound.isOn = UserDefaults.standard.value(forKey: "Options_Sound")! as! Bool
        PauseView.view.alpha = 0
        PauseBackground.alpha = 0
        PauseBackground.zPosition = Layers.PauseView.rawValue
        GameView.addChild(PauseBackground)
        GameView.addChild(PauseView.view)
        
        if !OptionsBGM.isOn {
            Sound_BGM.run(SKAction.stop())
        }
        Sound_BGM.autoplayLooped = true
    }
    
    //MARK: 弹窗动画
    func PauseViewAnimate(isShow: Bool){
        if(isShow == true){
            GameStatus = .Menu
            let fadeAway = SKAction.fadeIn(withDuration: 0.5)
            PauseView.view.run(fadeAway)
            PauseBackground.run(fadeAway)
        }
        else{
            GameStatus = .Play
            let fadeAway = SKAction.fadeOut(withDuration: 0.5)
            PauseView.view.run(fadeAway)
            PauseBackground.run(fadeAway)
        }
    }
    
    //MARK: 剩余球数状态
    func BaseballRemaning_Status() {
        BaseballRemaning.label.text = "\(BaseballRemaningNumber)"
    }
    
    //MARK: 游戏结束
    func GameOver() {
        OverView.view.zPosition = Layers.PauseView.rawValue
        OverView.label.text = "Game Over"
        if OptionsSound.isOn {
            run(Sound_Over)
        }
        
        OverScore.labelScore.text = "\(Score)"
        OverScore.labelCombo.text = "\(MostCombo)"
        OverView.view.addChild(OverScore.view)
        
        ReplayButton.position = CGPoint(x: 0, y: PauseView.view.size.height * -0.4)
        OverView.view.addChild(ReplayButton)
        
        OverBackButton.position = CGPoint(x: 0, y: PauseView.view.size.height * -0.2)
        OverView.view.addChild(OverBackButton)
        OverView.view.alpha = 0
        GameView.addChild(OverView.view)
        
        
        let fadeAway = SKAction.fadeIn(withDuration: 0.5)
        OverView.view.run(fadeAway)
        PauseBackground.run(fadeAway)
    }
    
    //MARK: 游戏等待
    func GameWait() {
        if MostCombo < NowCombo{
            MostCombo = NowCombo
        }
        if BaseballRemaningNumber < 1 {
            GameStatus = .Over
            return
        }
        
        NowCombo = 0
        
        //角色归位
        self.Natsume_Kyousuke_Static()
        self.Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
        
        self.Kurugaya_Yuiko_Static()
        self.Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
        
        self.Saigusa_Haruka_Static()
        self.Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
        
        self.Inohara_Masato_Static()
        self.Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
        
        BaseballRemaningNumber -= 1
        BaseballRemaning_Status()
        let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(2))
        run(TimeInterval) {
            self.Baseball_Static(0)
            if(self.Baseball.set[0].Status != GameObject.Baseball.All_Status.b_Throw && self.Baseball.set[0].Status != GameObject.Baseball.All_Status.b_Return && self.Baseball.set[0].Status != GameObject.Baseball.All_Status.b_ReturnAgain && self.Natsume_Rin.Unit.attribute.status == GamePeople.Natsume_Rin.Status.nr_Static.hashValue){
                self.Natsume_Rin.Unit.attribute.imageNumber = 0
                self.Natsume_Rin.Unit.attribute.status = GamePeople.Natsume_Rin.Status.nr_Swing.hashValue
            }
        }
    }

    
    //MARK: 点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TouchAmount += 1
        if(TouchAmount > 2){
            TouchAmount = 2
        }
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            //print("Baseballfield:",touch.location(in: Baseballfield))
            switch GameStatus {
            case .Play:
                if MovingButton_View.contains(location) {
                    if touchesButton(touches){
                        
                    }
                }
               /* else if TestButton.contains(location){
                    if(Baseball.set[0].Status != GameObject.Baseball.All_Status.b_Throw && Baseball.set[0].Status != GameObject.Baseball.All_Status.b_Return && Baseball.set[0].Status != GameObject.Baseball.All_Status.b_ReturnAgain && Natsume_Rin.Unit.attribute.status == GamePeople.Natsume_Rin.Status.nr_Static.hashValue){
                        self.Natsume_Rin.Unit.attribute.imageNumber = 0
                        self.Natsume_Rin.Unit.attribute.status = GamePeople.Natsume_Rin.Status.nr_Swing.hashValue
                    }
                }*/
                else if MenuButton.contains(location){
                    if OptionsSound.isOn{
                        run(Sound_Ding)
                    }
                    PauseViewAnimate(isShow: true)
                }
                else{
                    if(GameStatus == .Play){
                        if Naoe_Riki.Unit.attribute.status != GamePeople.Naoe_Riki.Status.nr_FallDown.hashValue{
                            Naoe_Riki.Unit.attribute.status = GamePeople.Naoe_Riki.Status.nr_Swing.hashValue
                        }
                    }
                }
                break
            case .Menu:
                let location = touch.location(in:PauseView.view)
                if (OptionsBGM.view.contains(location)){
                    if !OptionsBGM.isOn {
                        Sound_BGM.run(SKAction.play())
                    }
                    else{
                        Sound_BGM.run(SKAction.stop())
                    }
                    
                    OptionsBGM.isOn = !OptionsBGM.isOn
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    UserDefaults.standard.setValue(OptionsBGM.isOn, forKey: "Options_BGM")
                }
                else if(OptionsSound.view.contains(location)){
                    OptionsSound.isOn = !OptionsSound.isOn
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    UserDefaults.standard.setValue(OptionsSound.isOn, forKey: "Options_Sound")
                }
                else if(ResumeButton.contains(location)){
                    if OptionsSound.isOn{
                        run(Sound_Ding)
                    }
                    PauseViewAnimate(isShow: false)
                }
                else if(BackButton.contains(location)){
                    if OptionsSound.isOn{
                        run(Sound_Ding)
                    }
                    let nextScene = GameMenu(size: self.size)
                    self.view?.presentScene(nextScene)
                }
                break
            case .Over:
                let location = touch.location(in:OverView.view)
                if(ReplayButton.contains(location)){
                    if OptionsSound.isOn{
                        run(Sound_Ding)
                    }
                    let nextScene = KittyBaseballGame(size: self.size)
                    self.view?.presentScene(nextScene)
                }
                else if(OverBackButton.contains(location)){
                    if OptionsSound.isOn{
                        run(Sound_Ding)
                    }
                    let nextScene = GameMenu(size: self.size)
                    self.view?.presentScene(nextScene)
                }
                break
            default:
                break
            }
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _: AnyObject in touches {
            // Get the location of the touch in this scene
            // Check if the location of the touch is within the button's bounds
            AllButtonColorClear()
            switch GameStatus {
            case .Play:
                if !touchesButton(touches){
                    MovingButton_Status = .stop
                    
                    //移动整个Map
                    /*if(location.y > self.frame.height * 0.25){
                        Baseballfield.position = CGPoint(x: Baseballfield.frame.width * -(location.x / self.frame.width) + Baseballfield.frame.width * 0.55, y: Baseballfield.frame.height * -(location.y / self.frame.height) + Baseballfield.frame.height / 2)
                    }*/
                    
                }
                break
            default:
                break
            }
        }
    }
    func touchesButton(_ touches: Set<UITouch>) -> Bool {
        for touch: AnyObject in touches {
            let location = touch.location(in: MovingButton_View)
            if GameStatus != .Play{
                return false
            }
            else if MovingButton_Up.contains(location) {
                MovingButton_Status = .up
                MovingButton_Up.childNode(withName: "shadedDarkUp-touch")?.isHidden = false
                return true
            }
            else if MovingButton_Down.contains(location) {
                MovingButton_Status = .down
                MovingButton_Down.childNode(withName: "shadedDarkDown-touch")?.isHidden = false
                return true
            }
            else if MovingButton_Left.contains(location) {
                MovingButton_Status = .left
                MovingButton_Left.childNode(withName: "shadedDarkLeft-touch")?.isHidden = false
                return true
            }
            else if MovingButton_Right.contains(location) {
                MovingButton_Status = .right
                MovingButton_Right.childNode(withName: "shadedDarkRight-touch")?.isHidden = false
                return true
            }

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
        MovingButton_Up.childNode(withName: "shadedDarkUp-touch")?.isHidden = true
        MovingButton_Down.childNode(withName: "shadedDarkDown-touch")?.isHidden = true
        MovingButton_Left.childNode(withName: "shadedDarkLeft-touch")?.isHidden = true
        MovingButton_Right.childNode(withName: "shadedDarkRight-touch")?.isHidden = true
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
        if (GameStatus == .Play){
            //棒球位置
            Baseball.set[0].Power.ball_x = Baseball.set[0].Power.ball_x + CGFloat(DateTime) * 50
            
            //更新人物状态
            Baseball_Status(0) //棒 球
            Status_Naoe_Riki() //理 树
            Status_Natsume_Rin() //棗 鈴
            Status_Natsume_Kyousuke() //棗 恭介
            Status_Kurugaya_Yuiko() //来ヶ谷 唯湖
            Status_Saigusa_Haruka() //三枝 葉留佳
            Status_Inohara_Masato() //井ノ原 真人
            
            //棒球状态
            switch Baseball.set[0].Status{
            case .b_Static:
                break
            case .b_Throw:
                break
            case .b_Return:
                Status_View(Baseball.set[0].Unit.position)
                
                //Status_View(Natsume_Kyousuke.View.position)
                break
            case .b_ReturnAgain:
                Status_View(Baseball.set[0].Unit.position)
                break
                
            }
        }


    }
    
    //MARK: 游戏状态
    func GameStatusrRun(){
        switch GameStatus {
        case .Play:
            Baseballfield.isPaused = false
            break
        case .Menu:
            Baseballfield.isPaused = true
            break
        case .Dialog:
            break
        case .Other:
            break
        case .Over:
            GameOver()
            break
        case .Wait:
            GameWait()
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
                GameWait()
                return
            }
            if(Naoe_Riki.Unit.attribute.imageNumber.hashValue < 10){
                Naoe_Riki.Unit.attribute.imageNumber = 10
                if OptionsSound.isOn {
                    run(Sound_Dong)
                }
            }
            if(Naoe_Riki.Unit.attribute.imageNumber.hashValue > 16){
                TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.3))
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
                Natsume_Kyousuke.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[0]
                Natsume_Kyousuke.View.physicsBody?.collisionBitMask = 0
                Natsume_Kyousuke.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BallTrackPath
                Natsume_Kyousuke.Unit.attribute.Unit.speed = 1
                Natsume_Kyousuke.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
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
            if Baseball.set[0].Status == GameObject.Baseball.All_Status.b_Return{
                Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
            }
            Natsume_Kyousuke.View.physicsBody = nil
            break
        //跑回
        case GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue:
            if(Natsume_Kyousuke.Unit.attribute.Unit.speed == 0){
                Natsume_Kyousuke.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Natsume_Kyousuke.Unit.attribute.Unit.position)
                RunPath.addLine(to: GamePeople.Natsume_Kyousuke().Attribute.point)
                Natsume_Kyousuke.Unit.attribute.Unit.speed = 1
                Natsume_Kyousuke.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
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
            Natsume_Kyousuke.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[0]
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
                let Plus_1 = GameObject().Plus_1S_Label(text: "+1S")
                Natsume_Kyousuke.View.addChild(Plus_1)
                Plus_1.run(GameObject().Plus_1S_Animate())
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
        let Start = SKAction.run(Natsume_Kyousuke_Swing)
        let SwingAction = SKAction.sequence([Start,TimeInterval])
        run(SwingAction, withKey: "Natsume_Kyousuke_StatusAction")
    }
    func Natsume_Kyousuke_Swing(){
        Natsume_Kyousuke.View.size = Natsume_Kyousuke.Unit.image[Natsume_Kyousuke.Unit.attribute.imageNumber].size
        Natsume_Kyousuke.View.run(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.Unit.image[Natsume_Kyousuke.Unit.attribute.imageNumber])))
        Natsume_Kyousuke.Unit.attribute.imageNumber += 1
    }
    func Natsume_Kyousuke_Static(){
        Natsume_Kyousuke.Unit.attribute.Unit.removeAllActions()
        Natsume_Kyousuke.Unit.attribute.imageNumber = 0
        Natsume_Kyousuke.View.run(SKAction.setTexture(SKTexture(image: Natsume_Kyousuke.Unit.image[0])))
        Natsume_Kyousuke.View.size = Natsume_Kyousuke.Unit.image[Natsume_Kyousuke.Unit.attribute.imageNumber].size
        Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue
        Natsume_Kyousuke.Unit.attribute.Unit.speed = 0
    }
    
    //MARK: 来ヶ谷 唯湖
    func Status_Kurugaya_Yuiko(){
        //帧数刷新延时
        let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
        switch Kurugaya_Yuiko.Unit.attribute.status{
        //跑
        case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
            let PathAngle = GetAngle(Baseball.set[0].Unit.position, b: Kurugaya_Yuiko.Unit.attribute.Unit.position) //路径角度
            if(Kurugaya_Yuiko.Unit.attribute.Unit.speed == 0){
                Kurugaya_Yuiko.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Kurugaya_Yuiko.Unit.attribute.Unit.position)
                if(PathAngle > Baseball.Angle){
                    RunPath.addLine(to: CGPoint(x: Kurugaya_Yuiko.Range.position.x + Kurugaya_Yuiko.Range.frame.width, y: Kurugaya_Yuiko.Range.position.y + Kurugaya_Yuiko.Range.frame.height))
                }
                else{
                    RunPath.addLine(to: Kurugaya_Yuiko.Range.position)
                }
                
                Kurugaya_Yuiko.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Kurugaya_Yuiko().RunContact())
                Kurugaya_Yuiko.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[1]
                Kurugaya_Yuiko.View.physicsBody?.collisionBitMask = 0
                Kurugaya_Yuiko.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BallTrackPath
                Kurugaya_Yuiko.Unit.attribute.Unit.speed = 1
                Kurugaya_Yuiko.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
                    self.Kurugaya_Yuiko_Static()
                    self.Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
                })
            }
            Kurugaya_Yuiko.Unit.attribute.Shadow.position = CGPoint(x: Kurugaya_Yuiko.Unit.attribute.Unit.position.x + Kurugaya_Yuiko.Unit.attribute.Shadow_x, y: Kurugaya_Yuiko.Unit.attribute.Unit.position.y + Kurugaya_Yuiko.Unit.attribute.Shadow_y)
            Kurugaya_Yuiko.View.position = Kurugaya_Yuiko.Unit.attribute.Unit.position
            
            if((action(forKey: "Kurugaya_Yuiko_StatusAction")) != nil){
                return
            }
            if PathAngle > Baseball.Angle{
                if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue < 8 || Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue > 11){
                    Kurugaya_Yuiko.Unit.attribute.imageNumber = 8
                }
            }
            else{
                if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue < 24 || Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue > 27){
                    Kurugaya_Yuiko.Unit.attribute.imageNumber = 24
                }
            }
            
            Kurugaya_Yuiko_StatusAction(TimeInterval)
            break
        //静止
        case GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue:
            if Baseball.set[0].Status == GameObject.Baseball.All_Status.b_Return{
                Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
            }
            Kurugaya_Yuiko.View.physicsBody = nil
            break
        //跑回
        case GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue:
            if(Kurugaya_Yuiko.Unit.attribute.Unit.speed == 0){
                Kurugaya_Yuiko.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Kurugaya_Yuiko.Unit.attribute.Unit.position)
                RunPath.addLine(to: GamePeople.Kurugaya_Yuiko().Attribute.point)
                Kurugaya_Yuiko.Unit.attribute.Unit.speed = 1
                Kurugaya_Yuiko.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
                    self.Kurugaya_Yuiko_Static()
                })
            }
            Kurugaya_Yuiko.Unit.attribute.Shadow.position = CGPoint(x: Kurugaya_Yuiko.Unit.attribute.Unit.position.x + Kurugaya_Yuiko.Unit.attribute.Shadow_x, y: Kurugaya_Yuiko.Unit.attribute.Unit.position.y + Kurugaya_Yuiko.Unit.attribute.Shadow_y)
            Kurugaya_Yuiko.View.position = Kurugaya_Yuiko.Unit.attribute.Unit.position
            
            if((action(forKey: "Kurugaya_Yuiko_StatusAction")) != nil){
                return
            }
            if Kurugaya_Yuiko.Unit.attribute.Unit.position.x < GamePeople.Kurugaya_Yuiko().Attribute.point.x{
                if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue < 8 || Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue > 11){
                    Kurugaya_Yuiko.Unit.attribute.imageNumber = 8
                }
            }
            else{
                if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue < 24 || Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue > 27){
                    Kurugaya_Yuiko.Unit.attribute.imageNumber = 24
                }
                
            }
            
            Kurugaya_Yuiko_StatusAction(TimeInterval)
            break
        //接球
        case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
            Kurugaya_Yuiko.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Kurugaya_Yuiko().BodyContact())
            Kurugaya_Yuiko.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[1]
            Kurugaya_Yuiko.View.physicsBody?.collisionBitMask = 0
            Kurugaya_Yuiko.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
            
            if((action(forKey: "Kurugaya_Yuiko_StatusAction")) != nil){
                return
            }
            if(hypot(Kurugaya_Yuiko.Unit.attribute.Unit.position.x - Baseball.set[0].Unit.position.x, Kurugaya_Yuiko.Unit.attribute.Unit.position.y - Baseball.set[0].Unit.position.y) > 200){
                return
            }
            if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue < 72){
                Kurugaya_Yuiko.Unit.attribute.imageNumber = 72
            }
            if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue > 73){
                Kurugaya_Yuiko.Unit.attribute.imageNumber = 73
            }
            
            Kurugaya_Yuiko_StatusAction(TimeInterval)
            break
        //捡起
        case GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue:
            Kurugaya_Yuiko.View.physicsBody = nil
            if((action(forKey: "Kurugaya_Yuiko_StatusAction")) != nil){
                return
            }
            if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue < 74){
                Kurugaya_Yuiko.Unit.attribute.imageNumber = 74
            }
            if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue > 75){
                Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue
                Kurugaya_Yuiko.Unit.attribute.imageNumber = 0
                return
            }
            Kurugaya_Yuiko_StatusAction(TimeInterval)
            break
        //挥动
        case GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue:
            if((action(forKey: "Kurugaya_Yuiko_StatusAction")) != nil){
                return
            }
            if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue < 48){
                Kurugaya_Yuiko.Unit.attribute.imageNumber = 48
                let Plus_1 = GameObject().Plus_1S_Label(text: "+1S")
                Kurugaya_Yuiko.View.addChild(Plus_1)
                Plus_1.run(GameObject().Plus_1S_Animate())
            }
            if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue > 51){
                self.Kurugaya_Yuiko_Static()
            }
            
            if(Kurugaya_Yuiko.Unit.attribute.imageNumber.hashValue == 50){
                Baseball_Throw(Power: GameObject.Baseball.Power(ball_x: 2,ball_y: 0,height: 3, length: 30), Speed: 500, Number: 0)
            }
            
            Kurugaya_Yuiko_StatusAction(TimeInterval)
            
            break
        default:
            break
        }
    }
    func Kurugaya_Yuiko_StatusAction(_ TimeInterval:SKAction){
        let Start = SKAction.run(Kurugaya_Yuiko_Swing)
        let SwingAction = SKAction.sequence([Start,TimeInterval])
        run(SwingAction, withKey: "Kurugaya_Yuiko_StatusAction")
    }
    func Kurugaya_Yuiko_Swing(){
        Kurugaya_Yuiko.View.size = Kurugaya_Yuiko.Unit.image[Kurugaya_Yuiko.Unit.attribute.imageNumber].size
        Kurugaya_Yuiko.View.run(SKAction.setTexture(SKTexture(image: Kurugaya_Yuiko.Unit.image[Kurugaya_Yuiko.Unit.attribute.imageNumber])))
        Kurugaya_Yuiko.Unit.attribute.imageNumber += 1
    }
    func Kurugaya_Yuiko_Static(){
        Kurugaya_Yuiko.Unit.attribute.Unit.removeAllActions()
        Kurugaya_Yuiko.Unit.attribute.imageNumber = 0
        Kurugaya_Yuiko.View.run(SKAction.setTexture(SKTexture(image: Kurugaya_Yuiko.Unit.image[0])))
        Kurugaya_Yuiko.View.size = Kurugaya_Yuiko.Unit.image[Kurugaya_Yuiko.Unit.attribute.imageNumber].size
        Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue
        Kurugaya_Yuiko.Unit.attribute.Unit.speed = 0
    }
    
    //MARK: 三枝 葉留佳
    func Status_Saigusa_Haruka(){
        //帧数刷新延时
        let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
        switch Saigusa_Haruka.Unit.attribute.status{
        //跑
        case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
            let PathAngle = GetAngle(Baseball.set[0].Unit.position, b: Saigusa_Haruka.Unit.attribute.Unit.position) //路径角度
            if(Saigusa_Haruka.Unit.attribute.Unit.speed == 0){
                Saigusa_Haruka.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Saigusa_Haruka.Unit.attribute.Unit.position)
                if(PathAngle < Baseball.Angle){
                    RunPath.addLine(to: CGPoint(x: Saigusa_Haruka.Range.position.x - Saigusa_Haruka.Range.frame.width, y: Saigusa_Haruka.Range.position.y + Saigusa_Haruka.Range.frame.height))
                }
                else{
                    RunPath.addLine(to: Saigusa_Haruka.Range.position)
                }
                
                Saigusa_Haruka.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Saigusa_Haruka().RunContact())
                Saigusa_Haruka.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[2]
                Saigusa_Haruka.View.physicsBody?.collisionBitMask = 0
                Saigusa_Haruka.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BallTrackPath
                Saigusa_Haruka.Unit.attribute.Unit.speed = 1
                Saigusa_Haruka.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
                    self.Saigusa_Haruka_Static()
                    self.Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
                })
            }
            Saigusa_Haruka.Unit.attribute.Shadow.position = CGPoint(x: Saigusa_Haruka.Unit.attribute.Unit.position.x + Saigusa_Haruka.Unit.attribute.Shadow_x, y: Saigusa_Haruka.Unit.attribute.Unit.position.y + Saigusa_Haruka.Unit.attribute.Shadow_y)
            Saigusa_Haruka.View.position = Saigusa_Haruka.Unit.attribute.Unit.position
            
            if((action(forKey: "Saigusa_Haruka_StatusAction")) != nil){
                return
            }
            if PathAngle > Baseball.Angle{
                if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue < 16 || Saigusa_Haruka.Unit.attribute.imageNumber.hashValue > 19){
                    Saigusa_Haruka.Unit.attribute.imageNumber = 16
                }
            }
            else{
                if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue < 32 || Saigusa_Haruka.Unit.attribute.imageNumber.hashValue > 35){
                    Saigusa_Haruka.Unit.attribute.imageNumber = 32
                }
            }
            
            Saigusa_Haruka_StatusAction(TimeInterval)
            break
        //静止
        case GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue:
            if Baseball.set[0].Status == GameObject.Baseball.All_Status.b_Return{
                Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
            }
            Saigusa_Haruka.View.physicsBody = nil
            break
        //跑回
        case GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue:
            if(Saigusa_Haruka.Unit.attribute.Unit.speed == 0){
                Saigusa_Haruka.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Saigusa_Haruka.Unit.attribute.Unit.position)
                RunPath.addLine(to: GamePeople.Saigusa_Haruka().Attribute.point)
                Saigusa_Haruka.Unit.attribute.Unit.speed = 1
                Saigusa_Haruka.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
                    self.Saigusa_Haruka_Static()
                })
            }
            Saigusa_Haruka.Unit.attribute.Shadow.position = CGPoint(x: Saigusa_Haruka.Unit.attribute.Unit.position.x + Saigusa_Haruka.Unit.attribute.Shadow_x, y: Saigusa_Haruka.Unit.attribute.Unit.position.y + Saigusa_Haruka.Unit.attribute.Shadow_y)
            Saigusa_Haruka.View.position = Saigusa_Haruka.Unit.attribute.Unit.position
            
            if((action(forKey: "Saigusa_Haruka_StatusAction")) != nil){
                return
            }
            if Saigusa_Haruka.Unit.attribute.Unit.position.x < GamePeople.Saigusa_Haruka().Attribute.point.x{
                if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue < 16 || Saigusa_Haruka.Unit.attribute.imageNumber.hashValue > 19){
                    Saigusa_Haruka.Unit.attribute.imageNumber = 16
                }
            }
            else{
                if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue < 32 || Saigusa_Haruka.Unit.attribute.imageNumber.hashValue > 35){
                    Saigusa_Haruka.Unit.attribute.imageNumber = 32
                }
                
            }
            
            Saigusa_Haruka_StatusAction(TimeInterval)
            break
        //接球
        case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
            Saigusa_Haruka.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Saigusa_Haruka().BodyContact())
            Saigusa_Haruka.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[2]
            Saigusa_Haruka.View.physicsBody?.collisionBitMask = 0
            Saigusa_Haruka.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
            
            if((action(forKey: "Saigusa_Haruka_StatusAction")) != nil){
                return
            }
            if(hypot(Saigusa_Haruka.Unit.attribute.Unit.position.x - Baseball.set[0].Unit.position.x, Saigusa_Haruka.Unit.attribute.Unit.position.y - Baseball.set[0].Unit.position.y) > 200){
                return
            }
            if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue < 80){
                Saigusa_Haruka.Unit.attribute.imageNumber = 80
            }
            if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue > 81){
                Saigusa_Haruka.Unit.attribute.imageNumber = 81
            }
            
            Saigusa_Haruka_StatusAction(TimeInterval)
            break
        //捡起
        case GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue:
            Saigusa_Haruka.View.physicsBody = nil
            if((action(forKey: "Saigusa_Haruka_StatusAction")) != nil){
                return
            }
            if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue < 82){
                Saigusa_Haruka.Unit.attribute.imageNumber = 82
            }
            if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue > 83){
                Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue
                Saigusa_Haruka.Unit.attribute.imageNumber = 0
                return
            }
            Saigusa_Haruka_StatusAction(TimeInterval)
            break
        //挥动
        case GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue:
            if((action(forKey: "Saigusa_Haruka_StatusAction")) != nil){
                return
            }
            if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue < 56){
                Saigusa_Haruka.Unit.attribute.imageNumber = 56
                let Plus_1 = GameObject().Plus_1S_Label(text: "+1S")
                Saigusa_Haruka.View.addChild(Plus_1)
                Plus_1.run(GameObject().Plus_1S_Animate())
            }
            if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue > 59){
                self.Saigusa_Haruka_Static()
            }
            
            if(Saigusa_Haruka.Unit.attribute.imageNumber.hashValue == 58){
                Baseball_Throw(Power: GameObject.Baseball.Power(ball_x: 2,ball_y: 0,height: 3, length: 30), Speed: 500, Number: 0)
            }
            
            Saigusa_Haruka_StatusAction(TimeInterval)
            
            break
        default:
            break
        }
    }
    func Saigusa_Haruka_StatusAction(_ TimeInterval:SKAction){
        let Start = SKAction.run(Saigusa_Haruka_Swing)
        let SwingAction = SKAction.sequence([Start,TimeInterval])
        run(SwingAction, withKey: "Saigusa_Haruka_StatusAction")
    }
    func Saigusa_Haruka_Swing(){
        Saigusa_Haruka.View.size = Saigusa_Haruka.Unit.image[Saigusa_Haruka.Unit.attribute.imageNumber].size
        Saigusa_Haruka.View.run(SKAction.setTexture(SKTexture(image: Saigusa_Haruka.Unit.image[Saigusa_Haruka.Unit.attribute.imageNumber])))
        Saigusa_Haruka.Unit.attribute.imageNumber += 1
    }
    func Saigusa_Haruka_Static(){
        Saigusa_Haruka.Unit.attribute.Unit.removeAllActions()
        Saigusa_Haruka.Unit.attribute.imageNumber = 0
        Saigusa_Haruka.View.run(SKAction.setTexture(SKTexture(image: Saigusa_Haruka.Unit.image[0])))
        Saigusa_Haruka.View.size = Saigusa_Haruka.Unit.image[Saigusa_Haruka.Unit.attribute.imageNumber].size
        Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue
        Saigusa_Haruka.Unit.attribute.Unit.speed = 0
    }
    
    //MARK: 井ノ原 真人
    func Status_Inohara_Masato(){
        //帧数刷新延时
        let TimeInterval = SKAction.wait(forDuration: Foundation.TimeInterval(0.1))
        switch Inohara_Masato.Unit.attribute.status{
        //跑
        case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
            let PathAngle = GetAngle(Baseball.set[0].Unit.position, b: Inohara_Masato.Unit.attribute.Unit.position) //路径角度
            if(Inohara_Masato.Unit.attribute.Unit.speed == 0){
                Inohara_Masato.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Inohara_Masato.Unit.attribute.Unit.position)
                if(PathAngle < Baseball.Angle){
                    RunPath.addLine(to: CGPoint(x: Inohara_Masato.Range.position.x - Inohara_Masato.Range.frame.width, y: Inohara_Masato.Range.position.y + Inohara_Masato.Range.frame.height))
                }
                else{
                    RunPath.addLine(to: Inohara_Masato.Range.position)
                }
                
                Inohara_Masato.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Inohara_Masato().RunContact())
                Inohara_Masato.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[3]
                Inohara_Masato.View.physicsBody?.collisionBitMask = 0
                Inohara_Masato.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BallTrackPath
                Inohara_Masato.Unit.attribute.Unit.speed = 1
                Inohara_Masato.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
                    self.Inohara_Masato_Static()
                    self.Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
                })
            }
            Inohara_Masato.Unit.attribute.Shadow.position = CGPoint(x: Inohara_Masato.Unit.attribute.Unit.position.x + Inohara_Masato.Unit.attribute.Shadow_x, y: Inohara_Masato.Unit.attribute.Unit.position.y + Inohara_Masato.Unit.attribute.Shadow_y)
            Inohara_Masato.View.position = Inohara_Masato.Unit.attribute.Unit.position
            
            if((action(forKey: "Inohara_Masato_StatusAction")) != nil){
                return
            }
            if PathAngle > Baseball.Angle{
                if(Inohara_Masato.Unit.attribute.imageNumber.hashValue < 16 || Inohara_Masato.Unit.attribute.imageNumber.hashValue > 19){
                    Inohara_Masato.Unit.attribute.imageNumber = 16
                }
            }
            else{
                if(Inohara_Masato.Unit.attribute.imageNumber.hashValue < 32 || Inohara_Masato.Unit.attribute.imageNumber.hashValue > 35){
                    Inohara_Masato.Unit.attribute.imageNumber = 32
                }
            }
            
            Inohara_Masato_StatusAction(TimeInterval)
            break
        //静止
        case GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue:
            if Baseball.set[0].Status == GameObject.Baseball.All_Status.b_Return{
                Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
            }
            Inohara_Masato.View.physicsBody = nil
            break
        //跑回
        case GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue:
            if(Inohara_Masato.Unit.attribute.Unit.speed == 0){
                Inohara_Masato.Unit.attribute.Unit.removeAllActions()
                let RunPath = UIBezierPath()
                RunPath.move(to: Inohara_Masato.Unit.attribute.Unit.position)
                RunPath.addLine(to: GamePeople.Inohara_Masato().Attribute.point)
                Inohara_Masato.Unit.attribute.Unit.speed = 1
                Inohara_Masato.Unit.attribute.Unit.run(SKAction.follow(RunPath.cgPath, asOffset: false, orientToPath: false, speed: 150), completion: { () -> Void in
                    self.Inohara_Masato_Static()
                })
            }
            Inohara_Masato.Unit.attribute.Shadow.position = CGPoint(x: Inohara_Masato.Unit.attribute.Unit.position.x + Inohara_Masato.Unit.attribute.Shadow_x, y: Inohara_Masato.Unit.attribute.Unit.position.y + Inohara_Masato.Unit.attribute.Shadow_y)
            Inohara_Masato.View.position = Inohara_Masato.Unit.attribute.Unit.position
            
            if((action(forKey: "Inohara_Masato_StatusAction")) != nil){
                return
            }
            if Inohara_Masato.Unit.attribute.Unit.position.x < GamePeople.Inohara_Masato().Attribute.point.x{
                if(Inohara_Masato.Unit.attribute.imageNumber.hashValue < 16 || Inohara_Masato.Unit.attribute.imageNumber.hashValue > 19){
                    Inohara_Masato.Unit.attribute.imageNumber = 16
                }
            }
            else{
                if(Inohara_Masato.Unit.attribute.imageNumber.hashValue < 32 || Inohara_Masato.Unit.attribute.imageNumber.hashValue > 35){
                    Inohara_Masato.Unit.attribute.imageNumber = 32
                }
                
            }
            
            Inohara_Masato_StatusAction(TimeInterval)
            break
        //接球
        case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
            Inohara_Masato.View.physicsBody = SKPhysicsBody(polygonFrom: GamePeople.Inohara_Masato().BodyContact())
            Inohara_Masato.View.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleBehind[3]
            Inohara_Masato.View.physicsBody?.collisionBitMask = 0
            Inohara_Masato.View.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
            
            if((action(forKey: "Inohara_Masato_StatusAction")) != nil){
                return
            }
            if(hypot(Inohara_Masato.Unit.attribute.Unit.position.x - Baseball.set[0].Unit.position.x, Inohara_Masato.Unit.attribute.Unit.position.y - Baseball.set[0].Unit.position.y) > 200){
                return
            }
            if(Inohara_Masato.Unit.attribute.imageNumber.hashValue < 80){
                Inohara_Masato.Unit.attribute.imageNumber = 80
            }
            if(Inohara_Masato.Unit.attribute.imageNumber.hashValue > 81){
                Inohara_Masato.Unit.attribute.imageNumber = 81
            }
            
            Inohara_Masato_StatusAction(TimeInterval)
            break
        //捡起
        case GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue:
            Inohara_Masato.View.physicsBody = nil
            if((action(forKey: "Inohara_Masato_StatusAction")) != nil){
                return
            }
            if(Inohara_Masato.Unit.attribute.imageNumber.hashValue < 82){
                Inohara_Masato.Unit.attribute.imageNumber = 82
            }
            if(Inohara_Masato.Unit.attribute.imageNumber.hashValue > 83){
                Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue
                Inohara_Masato.Unit.attribute.imageNumber = 0
                return
            }
            Inohara_Masato_StatusAction(TimeInterval)
            break
        //挥动
        case GamePeople.Natsume_Kyousuke.Status.nk_Swing.hashValue:
            if((action(forKey: "Inohara_Masato_StatusAction")) != nil){
                return
            }
            if(Inohara_Masato.Unit.attribute.imageNumber.hashValue < 56){
                Inohara_Masato.Unit.attribute.imageNumber = 56
                let Plus_1 = GameObject().Plus_1S_Label(text: "+1S")
                Inohara_Masato.View.addChild(Plus_1)
                Plus_1.run(GameObject().Plus_1S_Animate())
            }
            if(Inohara_Masato.Unit.attribute.imageNumber.hashValue > 59){
                self.Inohara_Masato_Static()
            }
            
            if(Inohara_Masato.Unit.attribute.imageNumber.hashValue == 58){
                Baseball_Throw(Power: GameObject.Baseball.Power(ball_x: 2,ball_y: 0,height: 8, length: 40), Speed: 600, Number: 0)
            }
            
            Inohara_Masato_StatusAction(TimeInterval)
            
            break
        default:
            break
        }
    }
    func Inohara_Masato_StatusAction(_ TimeInterval:SKAction){
        let Start = SKAction.run(Inohara_Masato_Swing)
        let SwingAction = SKAction.sequence([Start,TimeInterval])
        run(SwingAction, withKey: "Inohara_Masato_StatusAction")
    }
    func Inohara_Masato_Swing(){
        Inohara_Masato.View.size = Inohara_Masato.Unit.image[Inohara_Masato.Unit.attribute.imageNumber].size
        Inohara_Masato.View.run(SKAction.setTexture(SKTexture(image: Inohara_Masato.Unit.image[Inohara_Masato.Unit.attribute.imageNumber])))
        Inohara_Masato.Unit.attribute.imageNumber += 1
    }
    func Inohara_Masato_Static(){
        Inohara_Masato.Unit.attribute.Unit.removeAllActions()
        Inohara_Masato.Unit.attribute.imageNumber = 0
        Inohara_Masato.View.run(SKAction.setTexture(SKTexture(image: Inohara_Masato.Unit.image[0])))
        Inohara_Masato.View.size = Inohara_Masato.Unit.image[Inohara_Masato.Unit.attribute.imageNumber].size
        Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Static.hashValue
        Inohara_Masato.Unit.attribute.Unit.speed = 0
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
        Score += 5
        
        Baseball.set[Number].Unit.removeAllActions()
        Baseball.set[Number].Power = Power
        Baseball.Jumps = 2
        Baseball.Speed = CGFloat(Speed)
        let BallPath = UIBezierPath()
        Baseball.PeopleBehindCatchPoint = Baseball.set[0].Unit.position
        BallPath.move(to: Baseball.PeopleBehindCatchPoint)
        var PathAngle = GetAngle(Baseball.PeopleBehindCatchPoint, b: Baseball.PeopleFrontCatchPoint)
        PathAngle = PathAngle + 90
        let mainPath = UIBezierPath(arcCenter: Baseball.PeopleBehindCatchPoint, radius: 2000, startAngle: 0, endAngle: CGFloat(M_PI) * (PathAngle / 180), clockwise: true)
        BallPath.addLine(to: mainPath.currentPoint)
        Baseball_ThrowPath(Number: 0,BallPath: BallPath)
        Baseball.set[Number].Status = GameObject.Baseball.All_Status.b_ReturnAgain
        Baseball.set[Number].Unit.run(SKAction.speed(to: 0, duration: 5), completion: { () -> Void in
            self.GameWait()
        })
        
        
    }
    /// 扔出路径
    ///
    /// - parameter Number: 激活球号
    /// - parameter BallPath:        移动路径
    func Baseball_ThrowPath(Number:Int,BallPath: UIBezierPath){
        Baseball.set[Number].Unit.speed = 1
        Baseball.set[Number].Unit.run(SKAction.follow(BallPath.cgPath, asOffset: false, orientToPath: false, speed: Baseball.Speed), completion: {
            self.GameWait()
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
        
        if OptionsSound.isOn{
            run(Sound_Dang)
        }
        
        let Plus_1 = GameObject().Plus_1S_Label(text: "+1S")
        Naoe_Riki.View.addChild(Plus_1)
        Plus_1.run(GameObject().Plus_1S_Animate())
        
        NowCombo += 1
        Score += 10
        
        Baseball.PeopleFrontCatchPoint = Naoe_Riki.Unit.attribute.Unit.position
        Baseball.PeopleFrontCatchPoint.y -= 15
        Baseball.PeopleFrontCatchPoint.x += 16
        
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
        Baseballfield.addChild(Baseball.TrackPath)
        
        Baseball.set[Number].Status = .b_Return
        Baseball.set[Number].Unit.speed = 1
        Baseball.set[Number].Unit.run(SKAction.follow(BallPath.cgPath, asOffset: false, orientToPath: false, speed: 500), completion: {
            self.GameWait()
        }) 
        Baseball.set[Number].Unit.run(SKAction.speed(to: 0, duration: 5), completion: { () -> Void in
            self.GameWait()
        })
        
        //各角色运动
        Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
        Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
        Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
        Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue
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
        //地图显示防出界
        let lengthX = (GameObject().Baseballfield().frame.size.width * GameObject().Baseballfield().anchorPoint.x) - (GameView.frame.width / 2)
        let lengthY = (GameObject().Baseballfield().frame.size.height * GameObject().Baseballfield().anchorPoint.y) - (GameView.frame.height / 2)
        if Baseballfield.position.x < lengthX * -1 {
            Baseballfield.position.x = lengthX * -1
        }
        if Baseballfield.position.x > lengthX {
            Baseballfield.position.x = lengthX
        }
        if Baseballfield.position.y < lengthY * -1 {
            Baseballfield.position.y = lengthY * -1
        }
        if Baseballfield.position.y > lengthY {
            Baseballfield.position.y = lengthY
        }
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
            case Collision.PeopleBehind[0]:
                switch Natsume_Kyousuke.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
                    Natsume_Kyousuke.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue
                    Baseball_Static(0)
                    break
                default:
                    break
                }
                break
            case Collision.PeopleBehind[1]:
                switch Kurugaya_Yuiko.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
                    Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue
                    Baseball_Static(0)
                    break
                default:
                    break
                }
                break
            case Collision.PeopleBehind[2]:
                switch Saigusa_Haruka.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
                    Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue
                    Baseball_Static(0)
                    break
                default:
                    break
                }
                break
            case Collision.PeopleBehind[3]:
                switch Inohara_Masato.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue:
                    Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_PickUp.hashValue
                    Baseball_Static(0)
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
            case Collision.PeopleBehind[0]:
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
            case Collision.PeopleBehind[1]:
                switch Kurugaya_Yuiko.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
                    Baseballfield.removeChildren(in: [Baseball.TrackPath])
                    if Kurugaya_Yuiko.Unit.attribute.Unit.position.x < Baseball.set[0].Unit.position.x{
                        self.Kurugaya_Yuiko_Static()
                        Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue
                    }
                    else{
                        self.Kurugaya_Yuiko_Static()
                        self.Kurugaya_Yuiko.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
                    }
                    break
                default:
                    break
                }
                break
            case Collision.PeopleBehind[2]:
                switch Saigusa_Haruka.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
                    Baseballfield.removeChildren(in: [Baseball.TrackPath])
                    if Saigusa_Haruka.Unit.attribute.Unit.position.x > Baseball.set[0].Unit.position.x{
                        self.Saigusa_Haruka_Static()
                        Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue
                    }
                    else{
                        self.Saigusa_Haruka_Static()
                        self.Saigusa_Haruka.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
                    }
                    break
                default:
                    break
                }
                break
            case Collision.PeopleBehind[3]:
                switch Inohara_Masato.Unit.attribute.status{
                case GamePeople.Natsume_Kyousuke.Status.nk_Run.hashValue:
                    Baseballfield.removeChildren(in: [Baseball.TrackPath])
                    if Inohara_Masato.Unit.attribute.Unit.position.x > Baseball.set[0].Unit.position.x{
                        self.Inohara_Masato_Static()
                        Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Catch.hashValue
                    }
                    else{
                        self.Inohara_Masato_Static()
                        self.Inohara_Masato.Unit.attribute.status = GamePeople.Natsume_Kyousuke.Status.nk_Return.hashValue
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

