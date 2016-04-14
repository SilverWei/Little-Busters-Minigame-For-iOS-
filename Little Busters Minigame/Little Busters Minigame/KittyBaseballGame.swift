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
    let Baseballfield = GameObject().Baseballfield()
    
    //初始化角色
    var Naoe_Riki = GameCharacter.Unit(character: GameCharacter().Naoe_Riki_Attribute,
        image: GameCharacter().Naoe_Riki_Array()
    )
    var Naoe_Riki_View = SKSpriteNode(texture: SKTexture(image: GameCharacter().Naoe_Riki_Array()[0]))
    var Naoe_Riki_Shadow = SKShapeNode()
    var Naoe_Riki_Range = GameCharacter().Naoe_Riki_Range()
    
    //初始化按钮
    var MovingButton_Status = MovingButton_Touch.Stop
    let MovingButton = GameObject().MovingButton()
    let MovingButton_UP = GameObject().MovingButton_UP()
    let MovingButton_Down = GameObject().MovingButton_Down()
    let MovingButton_Left = GameObject().MovingButton_Left()
    let MovingButton_Right = GameObject().MovingButton_Right()
    
    //图层
    enum Layers: CGFloat{
        case Baseballfield //棒球场背景
        case shadow //阴影
        case OtherBody //其他物件
        case Cat //猫
        case CharacterBehind //在后面的人物
        case Baseball //棒球
        case Characterfront //在前面的人物
        case Button //按钮
    }
    
    //按钮状态
    enum MovingButton_Touch: CGFloat{
        case Stop
        case UP
        case Down
        case Left
        case Right
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addChild(GameView)
        Show_Baseballfield()//显示棒球场背景
        Show_Characterfront()//显示在前面的人物
        Show_Shadow()//显示阴影
        Show_Button()//显示按钮
    }
    
    func Show_Baseballfield(){
        Baseballfield.position = CGPoint(x: size.width / 2, y: size.height / 2)
        GameView.addChild(Baseballfield)
    }
    
    func Show_Characterfront(){
        Naoe_Riki_View.position = Naoe_Riki.character.point
        Naoe_Riki_View.zPosition = Layers.Characterfront.rawValue
        Baseballfield.addChild(Naoe_Riki_View)
        Naoe_Riki_Range.zPosition = Layers.Characterfront.rawValue
        Baseballfield.addChild(Naoe_Riki_Range)
    }
    
    func Show_Shadow(){
        Naoe_Riki_Shadow = GameObject().Shadow( Naoe_Riki.character.point.x + Naoe_Riki.character.Shadow_x, y: Naoe_Riki.character.point.y + Naoe_Riki.character.Shadow_y, w: Naoe_Riki.character.Shadow_w, h: Naoe_Riki.character.Shadow_h)
        Baseballfield.addChild(Naoe_Riki_Shadow)
    }
    
    func Show_Button(){
        MovingButton.zPosition = Layers.Button.rawValue
        MovingButton.addChild(MovingButton_UP)
        MovingButton.addChild(MovingButton_Down)
        MovingButton.addChild(MovingButton_Left)
        MovingButton.addChild(MovingButton_Right)
        GameView.addChild(MovingButton)
    }
    
    //MARK: 点击
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if MovingButton_UP.containsPoint(location) {
                MovingButton_Status = .UP
                MovingButton_UP.fillColor = SKColor.whiteColor()
                print("UP")
            }
            else if MovingButton_Down.containsPoint(location) {
                MovingButton_Status = .Down
                MovingButton_Down.fillColor = SKColor.whiteColor()
                print("UP")
            }
            else if MovingButton_Left.containsPoint(location) {
                MovingButton_Status = .Left
                MovingButton_Left.fillColor = SKColor.whiteColor()
                print("UP")
            }
            else if MovingButton_Right.containsPoint(location) {
                MovingButton_Status = .Right
                MovingButton_Right.fillColor = SKColor.whiteColor()
                print("UP")
            }
            else{
                Naoe_Riki.character.status = GameCharacter.Naoe_Riki_Status.NR_Swing.hashValue
            }
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        MovingButton_Status = .Stop
        MovingButton_UP.fillColor = SKColor.clearColor()
        MovingButton_Down.fillColor = SKColor.clearColor()
        MovingButton_Left.fillColor = SKColor.clearColor()
        MovingButton_Right.fillColor = SKColor.clearColor()
        print("Stop")
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        Status_Naoe_Riki() //前面的人物状态
        
    }
    
    func Status_Naoe_Riki(){
        //直枝 理樹
        if(Naoe_Riki.character.status != GameCharacter.Naoe_Riki_Status.NR_static.hashValue){
            if(Naoe_Riki.character.imageNumber.hashValue == 9){
                Naoe_Riki.character.imageNumber = 0
                Naoe_Riki_View.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.character.imageNumber])))
                Naoe_Riki.character.status = GameCharacter.Naoe_Riki_Status.NR_static.hashValue
                return
            }
            //如果动作未完成则继续完成原来的动作
            if((actionForKey("Characterfront_SwingAction")) != nil){
                return
            }
            let Characterfront_Start = SKAction.runBlock(Characterfront_Swing)
            let TimeInterval = SKAction.waitForDuration(NSTimeInterval(0.05))
            let Characterfront_SwingAction = SKAction.sequence([Characterfront_Start,TimeInterval])
            runAction(Characterfront_SwingAction, withKey: "Characterfront_SwingAction")
        }
        switch MovingButton_Status{
        case .UP:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x, y: Naoe_Riki_View.position.y + 1)
            break
        case .Down:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x, y: Naoe_Riki_View.position.y - 1)
            break
        case .Left:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x - 1, y: Naoe_Riki_View.position.y)
            break
        case .Right:
            Naoe_Riki_View.position = CGPoint(x: Naoe_Riki_View.position.x + 1, y: Naoe_Riki_View.position.y)
            break
        default:
            break
        }
        if(Naoe_Riki_View.position.x < Naoe_Riki_Range.position.x){
            Naoe_Riki_View.position.x = Naoe_Riki_Range.position.x
        }
        if(Naoe_Riki_View.position.x > Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width){
            Naoe_Riki_View.position.x = Naoe_Riki_Range.position.x + Naoe_Riki_Range.frame.width
        }
        if(Naoe_Riki_View.position.y < Naoe_Riki_Range.position.y){
            Naoe_Riki_View.position.y = Naoe_Riki_Range.position.y
        }
        if(Naoe_Riki_View.position.y > Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height){
            Naoe_Riki_View.position.y = Naoe_Riki_Range.position.y + Naoe_Riki_Range.frame.height
        }
        Naoe_Riki_Shadow.position = CGPoint(x: Naoe_Riki_View.position.x + Naoe_Riki.character.Shadow_x, y: Naoe_Riki_View.position.y + Naoe_Riki.character.Shadow_y)
    }
    
    func Characterfront_Swing(){
        Naoe_Riki_View.runAction(SKAction.setTexture(SKTexture(image: Naoe_Riki.image[Naoe_Riki.character.imageNumber++])))
    }
    
}
