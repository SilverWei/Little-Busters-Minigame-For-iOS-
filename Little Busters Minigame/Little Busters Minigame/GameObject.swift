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
    
    

}

