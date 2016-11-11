//
//  GameObject.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/12.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit

class GameObject{
    ///棒球场背景
    internal func Baseballfield() -> SKSpriteNode{
        let image = SKSpriteNode(imageNamed: "Baseballfield-day")
        let BaseballfieldMagnification:CGFloat = 2
        image.size = CGSize(width: image.size.width * BaseballfieldMagnification, height: image.size.height * BaseballfieldMagnification)
        image.anchorPoint = CGPoint(x: 0.5, y: 0.25)
        image.position = CGPoint(x: 230, y: 200)
        image.zPosition = KittyBaseballGame.Layers.baseballfield.rawValue
        return image
    }
    
    ///阴影
    internal func Shadow(_ x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) -> SKShapeNode{
        let ShadowForm = SKShapeNode(ellipseOf: CGSize(width: w, height: h))
        ShadowForm.fillColor = SKColor.black
        ShadowForm.strokeColor = SKColor.clear
        ShadowForm.alpha = 0.3
        ShadowForm.position = CGPoint(x: x, y: y)
        ShadowForm.zPosition = KittyBaseballGame.Layers.shadow.rawValue
        return ShadowForm
    }
    
    ///棒球
    struct Baseball {
        let Baseball_Image = GameObject().Baseball_Image()
        var Baseball_Status = GameObject.Baseball_Status.b_Static
        var Baseball_Power = GameObject.Baseball_Power(ball_x: 0,ball_y: 0,height: 0,length: 0)
        var Baseball_Shadow = SKShapeNode()
        var Baseball_Unit = SKShapeNode()
    }
    internal func Baseball_Image() -> SKSpriteNode{
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
    enum Baseball_Status{
        case b_Static
        case b_Throw
        case b_Return
        case b_ReturnAgain
    }
    /// 棒球运动属性
    struct Baseball_Power {
        var ball_x: CGFloat //已运动距离
        var ball_y: CGFloat //已运动高度
        var height: CGFloat //高度
        var length: CGFloat //总运动距离
    }
    
    
    ///按钮
    internal func MovingButton() -> SKSpriteNode{
        let View_Width:CGFloat = 120
        let View = SKSpriteNode(color: SKColor.black, size: CGSize(width: View_Width, height: View_Width * 0.75))
        View.alpha = 0.5
        View.anchorPoint = CGPoint(x: 0, y: 0)
        View.position = CGPoint(x: 10, y: 10)
        return View
    }
    
    internal func MovingButton_UP() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.move(to: CGPoint(x: 0, y: MovingButtonFrame.height))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
        TrianglePath.addLine(to: CGPoint(x: 0, y: MovingButtonFrame.height))
        let Triangle = SKShapeNode(path: TrianglePath.cgPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clear
        Triangle.strokeColor = SKColor.white
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    
    internal func MovingButton_Down() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.move(to: CGPoint(x: 0, y: 0))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: 0))
        TrianglePath.addLine(to: CGPoint(x: 0, y: 0))
        let Triangle = SKShapeNode(path: TrianglePath.cgPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clear
        Triangle.strokeColor = SKColor.white
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    
    internal func MovingButton_Left() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.move(to: CGPoint(x: 0, y: MovingButtonFrame.height))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLine(to: CGPoint(x: 0, y: 0))
        TrianglePath.addLine(to: CGPoint(x: 0, y: MovingButtonFrame.height))
        let Triangle = SKShapeNode(path: TrianglePath.cgPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clear
        Triangle.strokeColor = SKColor.white
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    
    internal func MovingButton_Right() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.move(to: CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: 0))
        TrianglePath.addLine(to: CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
        let Triangle = SKShapeNode(path: TrianglePath.cgPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clear
        Triangle.strokeColor = SKColor.white
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    
    ///测试按钮
    internal func TestButton() -> SKSpriteNode{
        let View_Width:CGFloat = 120
        let View = SKSpriteNode(color: SKColor.black, size: CGSize(width: View_Width, height: View_Width * 0.75))
        View.alpha = 0.5
        View.anchorPoint = CGPoint(x: 0, y: 0)
        View.position = CGPoint(x: 20, y: 200)
        return View
    }

}

