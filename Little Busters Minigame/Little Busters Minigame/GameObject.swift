//
//  GameObject.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/12.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit

class GameObject: SKScene{
    var GameViewSize:CGSize = CGSize(width: 320, height: 320 * (UIScreen.main.bounds.size.height / UIScreen.main.bounds.size.width))
    
    //MARK: 棒球场背景
    internal func Baseballfield() -> SKSpriteNode{
        let Map_Day = "Baseballfield-day"
        let image = SKSpriteNode(imageNamed: "\(Map_Day)")
        let BaseballfieldMagnification:CGFloat = 2
        image.size = CGSize(width: image.size.width * BaseballfieldMagnification, height: image.size.height * BaseballfieldMagnification)
        image.anchorPoint = CGPoint(x: 0.5, y: 0.25)
        image.position = CGPoint(x: 230, y: 200)
        image.zPosition = KittyBaseballGame.Layers.baseballfield.rawValue
        return image
    }
    
    //MARK: 阴影
    internal func Shadow(_ x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) -> SKShapeNode{
        let ShadowForm = SKShapeNode(ellipseOf: CGSize(width: w, height: h))
        ShadowForm.fillColor = SKColor.black
        ShadowForm.strokeColor = SKColor.clear
        ShadowForm.alpha = 0.3
        ShadowForm.position = CGPoint(x: x, y: y)
        ShadowForm.zPosition = KittyBaseballGame.Layers.shadow.rawValue
        return ShadowForm
    }
    
    //MARK: 棒球
    class Baseball: NSObject {
        var set:[Attribute] = [Attribute]()
        var Jumps: CGFloat = 2 //次数
        var Angle: CGFloat = 0.0 //角度
        var Speed: CGFloat = 0 //速度
        var PeopleFrontCatchPoint: CGPoint = CGPoint.zero // 前面人物发球点
        var PeopleBehindCatchPoint:CGPoint = CGPoint.zero // 后面人物发球点
        let TrackPath = SKShapeNode() //棒球移动路径
        
        struct Attribute {
            let Image = GameObject.Baseball().Image_View()
            var Status = GameObject.Baseball.All_Status.b_Static
            var Power = GameObject.Baseball.Power(ball_x: 0,ball_y: 0,height: 0,length: 0)
            var Shadow = SKShapeNode()
            var Unit = SKShapeNode()
        }
        
        func Image_View() -> SKSpriteNode{
            let image = SKSpriteNode(imageNamed: "Baseball")
            image.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 17, y: GameObject().Baseballfield().anchorPoint.y + 200)
            image.size = CGSize(width: 13, height: 13)
            image.anchorPoint = CGPoint(x: 0.5, y: 0)
            image.zPosition = KittyBaseballGame.Layers.baseball.rawValue
            let path = CGMutablePath()
            path.move(to:CGPoint(x:-3, y:7))
            path.addLine(to:CGPoint(x:3, y:7))
            path.addLine(to:CGPoint(x:7, y:3))
            path.addLine(to:CGPoint(x:7, y:-3))
            path.addLine(to:CGPoint(x:3, y:-7))
            path.addLine(to:CGPoint(x:-3, y:-7))
            path.addLine(to:CGPoint(x:-7, y:-3))
            path.addLine(to:CGPoint(x:-7, y:3))
            path.closeSubpath()
            image.physicsBody = SKPhysicsBody(polygonFrom: path)
            image.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.Baseball
            image.physicsBody?.collisionBitMask = 0
            image.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.BaseballBat
            return image
        }
        /// 动作状态
        ///
        /// - b_Static:      静止
        /// - b_Throw:        投出
        /// - b_Return:      击回
        /// - b_ReturnAgain: 扔回
        enum All_Status{
            case b_Static
            case b_Throw
            case b_Return
            case b_ReturnAgain
        }
        /// 棒球运动属性
        struct Power {
            var ball_x: CGFloat //已运动距离
            var ball_y: CGFloat //已运动高度
            var height: CGFloat //高度
            var length: CGFloat //总运动距离
        }
    }
    
    
    //MARK: 按钮
    class MovingButton: NSObject {

        func Main() -> SKSpriteNode{
            let View_Width:CGFloat = 120
            let View = SKSpriteNode(color: SKColor.clear, size: CGSize(width: View_Width, height: View_Width))
            View.anchorPoint = CGPoint(x: 0, y: 0)
            View.position = CGPoint(x: 10, y: 10)
            return View
        }
        
        func UP_View() -> SKShapeNode{
            let image = SKSpriteNode(imageNamed: "shadedDarkUp")
            let image_touch = SKSpriteNode(imageNamed: "shadedDarkUp-touch")
            let TrianglePath = UIBezierPath()
            let MovingButtonFrame = Main().frame
            TrianglePath.move(to: CGPoint(x: 0, y: MovingButtonFrame.height))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
            TrianglePath.addLine(to: CGPoint(x: 0, y: MovingButtonFrame.height))
            let Triangle = SKShapeNode(path: TrianglePath.cgPath)
            Triangle.strokeColor = SKColor.clear
            Triangle.position = CGPoint(x: 0, y: 0)
            let Ratio = (MovingButtonFrame.height / 2) / image.size.height //按钮比例
            image.size = CGSize(width: Ratio * image.size.width, height: Ratio * image.size.height)
            image.anchorPoint = CGPoint(x: 0.5, y: 0)
            image.position = CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2)
            image_touch.size = image.size
            image_touch.anchorPoint = image.anchorPoint
            image_touch.position = image.position
            image_touch.name = "shadedDarkUp-touch"
            image_touch.isHidden = true
            Triangle.addChild(image)
            Triangle.addChild(image_touch)
            return Triangle
        }
        
        func Down_View() -> SKShapeNode{
            let image = SKSpriteNode(imageNamed: "shadedDarkDown")
            let image_touch = SKSpriteNode(imageNamed: "shadedDarkDown-touch")
            let TrianglePath = UIBezierPath()
            let MovingButtonFrame = Main().frame
            TrianglePath.move(to: CGPoint(x: 0, y: 0))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: 0))
            TrianglePath.addLine(to: CGPoint(x: 0, y: 0))
            let Triangle = SKShapeNode(path: TrianglePath.cgPath)
            Triangle.strokeColor = SKColor.clear
            Triangle.position = CGPoint(x: 0, y: 0)
            let Ratio = (MovingButtonFrame.height / 2) / image.size.height //按钮比例
            image.size = CGSize(width: Ratio * image.size.width, height: Ratio * image.size.height)
            image.anchorPoint = CGPoint(x: 0.5, y: 1)
            image.position = CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2)
            image_touch.size = image.size
            image_touch.anchorPoint = image.anchorPoint
            image_touch.position = image.position
            image_touch.name = "shadedDarkDown-touch"
            image_touch.isHidden = true
            Triangle.addChild(image)
            Triangle.addChild(image_touch)
            return Triangle
        }
        
        func Left_View() -> SKShapeNode{
            let image = SKSpriteNode(imageNamed: "shadedDarkLeft")
            let image_touch = SKSpriteNode(imageNamed: "shadedDarkLeft-touch")
            let TrianglePath = UIBezierPath()
            let MovingButtonFrame = Main().frame
            TrianglePath.move(to: CGPoint(x: 0, y: MovingButtonFrame.height))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
            TrianglePath.addLine(to: CGPoint(x: 0, y: 0))
            TrianglePath.addLine(to: CGPoint(x: 0, y: MovingButtonFrame.height))
            let Triangle = SKShapeNode(path: TrianglePath.cgPath)
            Triangle.strokeColor = SKColor.clear
            Triangle.position = CGPoint(x: 0, y: 0)
            let Ratio = (MovingButtonFrame.width / 2) / image.size.width //按钮比例
            image.size = CGSize(width: Ratio * image.size.width, height: Ratio * image.size.height)
            image.anchorPoint = CGPoint(x: 1, y: 0.5)
            image.position = CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2)
            image_touch.size = image.size
            image_touch.anchorPoint = image.anchorPoint
            image_touch.position = image.position
            image_touch.name = "shadedDarkLeft-touch"
            image_touch.isHidden = true
            Triangle.addChild(image)
            Triangle.addChild(image_touch)
            
            return Triangle
        }
        
        func Right_View() -> SKShapeNode{
            let image = SKSpriteNode(imageNamed: "shadedDarkRight")
            let image_touch = SKSpriteNode(imageNamed: "shadedDarkRight-touch")
            let TrianglePath = UIBezierPath()
            let MovingButtonFrame = Main().frame
            TrianglePath.move(to: CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: 0))
            TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
            let Triangle = SKShapeNode(path: TrianglePath.cgPath)
            Triangle.strokeColor = SKColor.clear
            Triangle.position = CGPoint(x: 0, y: 0)
            let Ratio = (MovingButtonFrame.width / 2) / image.size.width //按钮比例
            image.size = CGSize(width: Ratio * image.size.width, height: Ratio * image.size.height)
            image.anchorPoint = CGPoint(x: 0, y: 0.5)
            image.position = CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2)
            image_touch.size = image.size
            image_touch.anchorPoint = image.anchorPoint
            image_touch.position = image.position
            image_touch.name = "shadedDarkRight-touch"
            image_touch.isHidden = true
            Triangle.addChild(image)
            Triangle.addChild(image_touch)
            
            return Triangle
        }
        
        ///按钮状态
        enum TouchStatus: CGFloat{
            case stop
            case up
            case down
            case left
            case right
        }
    }
    
    //MARK: 菜单按钮
    internal func MenuButton() -> SKSpriteNode{
        let image = SKSpriteNode(imageNamed: "shadedDarkPause")
        
        let View_width:CGFloat = 30
        let View = SKSpriteNode(color: SKColor.clear, size: CGSize(width: View_width, height: View_width))
        View.anchorPoint = CGPoint(x: 1, y: 1)
        View.position = CGPoint(x: GameViewSize.width - 20, y: GameViewSize.height - 20)
        print(GameViewSize)
        image.size = View.size
        image.anchorPoint = View.anchorPoint
        View.addChild(image)
        return View
    }
    
    //MARK: 声音开关
    internal class SoundButton : SKNode {
        var isOn:Bool = true{
            didSet {
                if isOn == true {
                    view.childNode(withName: "shadedDarkSound_Off")?.isHidden = true
                }
                else{
                    
                    view.childNode(withName: "shadedDarkSound_Off")?.isHidden = false
                }
            }
        }
        var view = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 160, height: 44))
        var label = SKLabelNode(text: "")
        
        override init() {
            super.init()
            view.anchorPoint = CGPoint(x: 0.5, y: 0)
            let image = SKSpriteNode(imageNamed: "shadedDarkSound_On")
            let Ratio = (view.size.height / image.size.height)
            image.size = CGSize(width: image.size.width * Ratio * 0.8, height: view.size.height * 0.8)
            image.anchorPoint = CGPoint(x: 0.5, y: 0)
            image.position = CGPoint(x: (view.size.width * -0.5) + (image.size.width / 2), y: 0)
            view.addChild(image)
            label.fontColor = SKColor.gray
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .left
            label.fontName = "kenpixel"
            label.position = CGPoint(x: 0, y: 22)
            view.addChild(label)
            do {
                let image = SKSpriteNode(imageNamed: "shadedDarkSound_Off")
                let Ratio = view.size.height / image.size.height
                image.size = CGSize(width: image.size.width * Ratio * 0.8, height: view.size.height * 0.8)
                image.anchorPoint = CGPoint(x: 0.5, y: 0)
                image.position = CGPoint(x: (view.size.width * -0.5) + (image.size.width / 2), y: 0)
                image.name = "shadedDarkSound_Off"
                view.addChild(image)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    //MARK: 页面背景
    internal class Window : SKNode{
        var view = SKSpriteNode(color: SKColor.clear, size: CGSize(width: GameObject().GameViewSize.width * 0.8, height: GameObject().GameViewSize.height * 0.5))
        var label = SKLabelNode(text: "")
        override init(){
            super.init()
            view.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.position = CGPoint(x: GameObject().GameViewSize.width / 2, y: GameObject().GameViewSize.height / 2)
            do {
                let image = SKSpriteNode(imageNamed: "dropdownTop")
                let Ratio = view.size.width / image.size.width
                image.size = CGSize(width: view.size.width, height: image.size.height * Ratio)
                image.position = CGPoint(x: 0, y: view.size.height * 0.5)
                image.anchorPoint = CGPoint(x: 0.5, y: 0)
                view.addChild(image)
            }
            do {
                let image = SKSpriteNode(imageNamed: "dropdownBottom")
                let Ratio = view.size.width / image.size.width
                image.size = CGSize(width: view.size.width, height: image.size.height * Ratio)
                image.position = CGPoint(x: 0, y: view.size.height * -0.5)
                image.anchorPoint = CGPoint(x: 0.5, y: 1)
                view.addChild(image)
            }
            do {
                let image = SKSpriteNode(imageNamed: "dropdownMid")
                image.size = CGSize(width: view.size.width, height: view.size.height)
                image.position = CGPoint(x: 0, y: 0)
                view.addChild(image)
            }
            do {
                label.fontColor = SKColor.gray
                label.position = CGPoint(x: 0, y: view.size.height * 0.4)
                label.fontSize = 20
                label.verticalAlignmentMode = .center
                label.fontName = "kenpixel"
                view.addChild(label)
            }

        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    internal func WindowBackground() -> SKSpriteNode{
        let view = SKSpriteNode(color: SKColor.init(red: 0, green: 0, blue: 0, alpha: 0.6), size: CGSize(width: GameViewSize.width, height: GameViewSize.height))
        view.position = CGPoint(x: GameViewSize.width / 2, y: GameViewSize.height / 2)
        return view
    }
    
    //MARK: 恢复按钮
    internal func ResumeButton() -> SKSpriteNode{
        let view = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 44))
        do  {
            let image = SKSpriteNode(imageNamed: "green_button02")
            image.size = view.frame.size
            image.anchorPoint = view.anchorPoint
            view.addChild(image)
            let label = SKLabelNode(text: "Resume")
            label.fontColor = SKColor.white
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            image.addChild(label)
        }
        return view
    }
    
    //MARK: 重玩按钮
    internal func ReplayButton() -> SKSpriteNode{
        let view = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 44))
        do  {
            let image = SKSpriteNode(imageNamed: "green_button02")
            image.size = view.frame.size
            image.anchorPoint = view.anchorPoint
            view.addChild(image)
            let label = SKLabelNode(text: "Replay")
            label.fontColor = SKColor.white
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            image.addChild(label)
        }
        return view
    }
    
    
    //MARK: 返回按钮
    internal func BackButton() -> SKSpriteNode{
        let view = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 44))
        
        do  {
            let image = SKSpriteNode(imageNamed: "red_button13")
            image.size = view.frame.size
            image.anchorPoint = view.anchorPoint
            view.addChild(image)
            let label = SKLabelNode(text: "Back")
            label.fontColor = SKColor.white
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            image.addChild(label)
        }
        return view
    }
    
    //MARK: +1S
    internal func Plus_1S_Label(text: String) -> SKLabelNode{
        let label = SKLabelNode(text: text)
        label.fontName = "kenpixel"
        label.verticalAlignmentMode = .center
        label.fontSize = 20
        label.fontColor = SKColor(red: 0.96, green: 0.26, blue: 0.21, alpha: 1)
        label.position = CGPoint(x: 0, y: 60)
        label.zPosition = KittyBaseballGame.Layers.message.rawValue
        return label
    }
    internal func Plus_1S_Animate() -> SKAction{
        let moveView = SKAction.moveBy(x: 0, y: 20, duration: 1)
        let fadeAway = SKAction.fadeOut(withDuration: 1)
        let action = SKAction.group([moveView,fadeAway])
        return action
    }
    
    //MARK: 测试按钮
    internal func TestButton() -> SKSpriteNode{
        let View_Width:CGFloat = 120
        let View = SKSpriteNode(color: SKColor.black, size: CGSize(width: View_Width, height: View_Width ))
        View.alpha = 0.5
        View.anchorPoint = CGPoint(x: 0, y: 0)
        View.position = CGPoint(x: 20, y: 200)
        return View
    }
    
    //MARK: 剩余球数板
    internal class BaseballRemaning : SKNode {
        var view = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 120, height: 44))
        var label = SKLabelNode(text: "")
        
        override init() {
            super.init()
            
            view.anchorPoint = CGPoint(x: 0, y: 1)
            view.position = CGPoint(x: 20, y: GameObject().GameViewSize.height - 20)
            let image = SKSpriteNode(imageNamed: "grey_button06")
            image.size = view.size
            image.anchorPoint = view.anchorPoint
            view.addChild(image)
            label.fontColor = SKColor.red
            label.fontSize = 25
            label.verticalAlignmentMode = .center
            label.horizontalAlignmentMode = .left
            label.fontName = "kenpixel"
            label.position = CGPoint(x: view.frame.width * 0.65, y: view.frame.height * -0.55)
            image.addChild(label)
            do{
                let label = SKLabelNode(text: "Remaning:")
                label.fontColor = SKColor.gray
                label.fontSize = 10
                label.horizontalAlignmentMode = .left
                label.fontName = "kenpixel"
                label.position = CGPoint(x: view.frame.width * 0.05, y: view.frame.height * -0.8)
                image.addChild(label)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    //MARK: 最终得分
    internal class Score : SKNode {
        var view = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 200, height: 100))
        
        var labelScore = SKLabelNode(text: "")
        var labelCombo = SKLabelNode(text: "")
        
        override init(){
            super.init()
            view.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.position = CGPoint(x: 0, y: Window().view.frame.height * 0.1)
            labelScore.fontColor = SKColor(red: 0.0, green: 0.59, blue: 0.53, alpha: 1.0)
            labelScore.fontSize = 20
            labelScore.verticalAlignmentMode = .center
            labelScore.horizontalAlignmentMode = .right
            labelScore.fontName = "kenpixel"
            labelScore.position = CGPoint(x: view.frame.width * 0.5, y: 20)
            view.addChild(labelScore)
            do{
                let label = SKLabelNode(text: "Final Score:")
                label.fontColor = SKColor.gray
                label.fontSize = 20
                label.horizontalAlignmentMode = .left
                label.fontName = "kenpixel"
                label.position = CGPoint(x: view.frame.width * -0.5, y: 10)
                view.addChild(label)
            }
            labelCombo.fontColor = SKColor(red: 0.0, green: 0.59, blue: 0.53, alpha: 1.0)
            labelCombo.fontSize = 20
            labelCombo.verticalAlignmentMode = .center
            labelCombo.horizontalAlignmentMode = .right
            labelCombo.fontName = "kenpixel"
            labelCombo.position = CGPoint(x: view.frame.width * 0.5, y: -20)
            view.addChild(labelCombo)
            do{
                let label = SKLabelNode(text: "Hight Combo:")
                label.fontColor = SKColor.gray
                label.fontSize = 20
                label.horizontalAlignmentMode = .left
                label.fontName = "kenpixel"
                label.position = CGPoint(x: view.frame.width * -0.5, y: -30)
                view.addChild(label)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

}

