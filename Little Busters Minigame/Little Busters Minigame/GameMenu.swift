//
//  GameMenu.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/11.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit



class GameMenu: SKScene {
    
    let MenuView = SKNode()
    var KittyBaseballGame_Button:SKNode! = nil
    
    enum Layers: CGFloat{
        case Background
        case Button
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        addChild(MenuView)
        ShowBackground()
        ShowButton()
        
    }

    func ShowBackground(){
        let BackgroundImage = SKSpriteNode(imageNamed: "MenuBackground")
        BackgroundImage.size = CGSizeMake(size.height * (BackgroundImage.size.width / BackgroundImage.size.height), size.height)
        BackgroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        BackgroundImage.zPosition = Layers.Background.rawValue
        MenuView.addChild(BackgroundImage)
    }
    
    func ShowButton(){
        KittyBaseballGame_Button = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: 150, height: 44))
        KittyBaseballGame_Button.position = CGPoint(x: size.width / 2, y:(size.height / 3) * 2)
        KittyBaseballGame_Button.alpha = 0.7
        KittyBaseballGame_Button.zPosition = Layers.Button.rawValue
        
        let KittyBaseballGame_Label = SKLabelNode(text: "Kitty Baseball")
        KittyBaseballGame_Label.fontColor = SKColor.whiteColor()
        KittyBaseballGame_Label.position = CGPointMake(0, 0)
        KittyBaseballGame_Label.fontSize = 20
        KittyBaseballGame_Label.verticalAlignmentMode = .Center
        KittyBaseballGame_Label.fontName = "AvenirNext-Bold"
        KittyBaseballGame_Button.addChild(KittyBaseballGame_Label)
        MenuView.addChild(KittyBaseballGame_Button)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if KittyBaseballGame_Button.containsPoint(location) {
                print("进入棒球小游戏!")
                let nextScene = KittyBaseballGame(size: self.size)
                self.view?.presentScene(nextScene)
            }
        }
    }
    
}
