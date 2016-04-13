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
    
    var Naoe_Riki = GameCharacter.Unit(character: GameCharacter().Naoe_Riki_Attribute,
        image: GameCharacter().Naoe_Riki_Array()
    )
    var Characterfront = SKSpriteNode(texture: SKTexture(image: GameCharacter().Naoe_Riki_Array()[0]))
    
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
        Show_Baseballfield()//显示棒球场背景
        Show_Characterfront()//显示在前面的人物
    }
    
    func Show_Baseballfield(){
        Baseballfield.position = CGPoint(x: size.width / 2, y: size.height / 2)
        Baseballfield.zPosition = Layers.Baseballfield.rawValue
        GameView.addChild(Baseballfield)
    }
    
    func Show_Characterfront(){
        Characterfront.position = Naoe_Riki.character.point
        Characterfront.zPosition = Layers.Characterfront.rawValue
        Baseballfield.addChild(Characterfront)
    }
    
    //MARK: 点击
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Naoe_Riki.character.status = GameCharacter.Naoe_Riki_status.NR_Swing.hashValue
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        Status_Characterfront() //前面的人物状态
    }
    
    func Status_Characterfront(){
        if(Naoe_Riki.character.status != GameCharacter.Naoe_Riki_status.NR_static.hashValue){
            if(Naoe_Riki.character.imageNumber.hashValue == 9){
                Naoe_Riki.character.imageNumber = 0
                Characterfront.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.character.imageNumber])))
                Naoe_Riki.character.status = GameCharacter.Naoe_Riki_status.NR_static.hashValue
                return
            }

            if((actionForKey("Characterfront_SwingAction")) != nil){
                return
            }
            let Characterfront_Start = SKAction.runBlock(Characterfront_Swing)
            let TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.05))
            let Characterfront_SwingAction = SKAction.sequence([Characterfront_Start,TimeInterval])
            runAction(Characterfront_SwingAction, withKey: "Characterfront_SwingAction")
        }
    }
    
    func Characterfront_Swing(){
        Characterfront.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.character.imageNumber++])))
    }
    
}
