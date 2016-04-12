//
//  GameBackground.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/12.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit

class GameBackground{
    //棒球场背景
    let Baseballfield = SKSpriteNode(imageNamed: "Baseballfield-day")
    
    init(){
        let BaseballfieldMagnification:CGFloat = 2
        Baseballfield.size = CGSizeMake(Baseballfield.size.width * BaseballfieldMagnification, Baseballfield.size.height * BaseballfieldMagnification)
        Baseballfield.anchorPoint = CGPoint(x: 0.5, y: 0.25)
    }
}