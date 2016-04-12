//
//  KittyBaseballGame.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/11.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit

class KittyBaseballGame: SKScene {
    
    let GameView = SKNode()
    let Baseballfield = GameBackground().Baseballfield
    
    enum Layers: CGFloat{
        case Baseballfield //棒球场背景
        case shadow //阴影
        case OtherBody //其他物件
        case Cat //猫
        case CharacterBehind //在后面的人物
        case Baseball //棒球
        case Characterfront //在前面的人物
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addChild(GameView)
        ShowBaseballfield()//显示棒球场背景
        ShowCharacterfront()//显示在前面的人物
    }
    
    func ShowBaseballfield(){
        Baseballfield.position = CGPoint(x: size.width / 2, y: size.height / 2)
        Baseballfield.zPosition = Layers.Baseballfield.rawValue
        GameView.addChild(Baseballfield)
    }
    
    func ShowCharacterfront(){
        let Naoe_Riki = SKSpriteNode(texture: SKTexture(image: GameCharacter().Naoe_Riki_Array()[20]))
        Naoe_Riki.position = GameCharacter().Naoe_Riki.point
        Naoe_Riki.zPosition = Layers.Characterfront.rawValue
        Baseballfield.addChild(Naoe_Riki)
    }
    
    //MARK: 点击
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
