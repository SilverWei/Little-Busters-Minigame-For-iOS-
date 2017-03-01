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
    var Options_Button:SKNode! = nil
    
    enum Layers: CGFloat{
        case background
        case button
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        addChild(MenuView)
        ShowBackground()
        ShowButton()
        
    }

    func ShowBackground(){
        let BackgroundImage = SKSpriteNode(imageNamed: "MenuBackground")
        BackgroundImage.size = CGSize(width: size.height * (BackgroundImage.size.width / BackgroundImage.size.height), height: size.height)
        BackgroundImage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        BackgroundImage.zPosition = Layers.background.rawValue
        MenuView.addChild(BackgroundImage)
    }
    
    func ShowButton(){
        KittyBaseballGame_Button = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 160, height: 44))
        KittyBaseballGame_Button.position = CGPoint(x: size.width / 2, y: size.height / 2)
        KittyBaseballGame_Button.zPosition = Layers.button.rawValue
        do {
            let image = SKSpriteNode(imageNamed: "green_button02")
            image.size = KittyBaseballGame_Button.frame.size
            KittyBaseballGame_Button.addChild(image)
            let label = SKLabelNode(text: "Play")
            label.fontColor = SKColor.white
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            image.addChild(label)
        }
        MenuView.addChild(KittyBaseballGame_Button)
        
        Options_Button = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 160, height: 44))
        Options_Button.position = CGPoint(x: size.width / 2, y: (size.height / 2) - 70)
        Options_Button.zPosition = Layers.button.rawValue
        do  {
            let image = SKSpriteNode(imageNamed: "red_button13")
            image.size = Options_Button.frame.size
            Options_Button.addChild(image)
            let label = SKLabelNode(text: "Options")
            label.fontColor = SKColor.white
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            image.addChild(label)
        }
        MenuView.addChild(Options_Button)
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if KittyBaseballGame_Button.contains(location) {
                print("进入棒球小游戏!")
                let nextScene = KittyBaseballGame(size: self.size)
                self.view?.presentScene(nextScene)
            }
            else if Options_Button.contains(location){
                print("进入选项！")
                
            }
        }
    }
    
    
    
}
