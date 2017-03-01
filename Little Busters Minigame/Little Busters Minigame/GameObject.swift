//
//  GameObject.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/12.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit

class GameObject: SKScene{
    //MARK: 棒球场背景
    internal func Baseballfield() -> SKSpriteNode{
        let image = SKSpriteNode(imageNamed: "Baseballfield-day")
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
        /// - b_Cast:        投出
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
        View.position = CGPoint(x: UIScreen.main.bounds.width - 20, y: UIScreen.main.bounds.height - 20)
        image.size = View.size
        image.anchorPoint = View.anchorPoint
        View.addChild(image)
        return View
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

}

