//
//  GameObject.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/12.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit

class GameObject{
    //棒球场背景
    internal func Baseballfield() -> SKSpriteNode{
        let image = SKSpriteNode(imageNamed: "Baseballfield-day")
        let BaseballfieldMagnification:CGFloat = 2
        image.size = CGSizeMake(image.size.width * BaseballfieldMagnification, image.size.height * BaseballfieldMagnification)
        image.anchorPoint = CGPoint(x: 0.5, y: 0.25)
        image.zPosition = KittyBaseballGame.Layers.Baseballfield.rawValue
        return image
    }
    
    //阴影
    internal func Shadow(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) -> SKShapeNode{
        let ShadowForm = SKShapeNode(ellipseOfSize: CGSize(width: w, height: h))
        ShadowForm.fillColor = SKColor.blackColor()
        ShadowForm.strokeColor = SKColor.clearColor()
        ShadowForm.alpha = 0.3
        ShadowForm.position = CGPoint(x: x, y: y)
        ShadowForm.zPosition = KittyBaseballGame.Layers.shadow.rawValue
        return ShadowForm
    }
    
    //棒球
    internal func Baseball() -> SKSpriteNode{
        let image = SKSpriteNode(imageNamed: "Baseball")
        image.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 17, y: GameObject().Baseballfield().anchorPoint.y + 200)
        image.size = CGSizeMake(13, 13)
        image.anchorPoint = CGPoint(x: 0.5, y: 0)
        image.zPosition = KittyBaseballGame.Layers.Baseball.rawValue
        return image
    }
    
    //按钮
    internal func MovingButton() -> SKSpriteNode{
        let View_Width:CGFloat = 120
        let View = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: View_Width, height: View_Width * 0.75))
        View.alpha = 0.5
        View.anchorPoint = CGPoint(x: 0, y: 0)
        View.position = CGPoint(x: 10, y: 10)
        return View
    }
    
    internal func MovingButton_UP() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.moveToPoint(CGPoint(x: 0, y: MovingButtonFrame.height))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
        TrianglePath.addLineToPoint(CGPoint(x: 0, y: MovingButtonFrame.height))
        let Triangle = SKShapeNode(path: TrianglePath.CGPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clearColor()
        Triangle.strokeColor = SKColor.whiteColor()
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    
    internal func MovingButton_Down() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.moveToPoint(CGPoint(x: 0, y: 0))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width, y: 0))
        TrianglePath.addLineToPoint(CGPoint(x: 0, y: 0))
        let Triangle = SKShapeNode(path: TrianglePath.CGPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clearColor()
        Triangle.strokeColor = SKColor.whiteColor()
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    
    internal func MovingButton_Left() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.moveToPoint(CGPoint(x: 0, y: MovingButtonFrame.height))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLineToPoint(CGPoint(x: 0, y: 0))
        TrianglePath.addLineToPoint(CGPoint(x: 0, y: MovingButtonFrame.height))
        let Triangle = SKShapeNode(path: TrianglePath.CGPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clearColor()
        Triangle.strokeColor = SKColor.whiteColor()
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    
    internal func MovingButton_Right() -> SKShapeNode{
        let TrianglePath = UIBezierPath()
        let MovingButtonFrame = MovingButton().frame
        TrianglePath.moveToPoint(CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width / 2, y: MovingButtonFrame.height / 2))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width, y: 0))
        TrianglePath.addLineToPoint(CGPoint(x: MovingButtonFrame.width, y: MovingButtonFrame.height))
        let Triangle = SKShapeNode(path: TrianglePath.CGPath)
        Triangle.lineWidth = 1.0
        Triangle.fillColor = SKColor.clearColor()
        Triangle.strokeColor = SKColor.whiteColor()
        Triangle.position = CGPoint(x: 0, y: 0)
        
        return Triangle
    }
    

}

