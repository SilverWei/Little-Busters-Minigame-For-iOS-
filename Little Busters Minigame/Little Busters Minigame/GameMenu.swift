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
    var OptionsView = GameObject.Window()
    let OptionsBGM = GameObject.SoundButton()
    let OptionsSound = GameObject.SoundButton()
    var OptionsBack_Button:SKSpriteNode! = nil
    
    var MenuStatus:Status = .Menu
    
    
    /// 图层
    enum Layers: CGFloat{
        case background
        case button
        case View
    }
    
    /// 游戏状态
    enum Status {
        case Menu
        case OptionsShow
    }
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        addChild(MenuView)
        ShowBackground()
        ShowButton()
        ShowOptions()
        
        OptionsBGM.isOn = UserDefaults.standard.value(forKey: "Options_BGM")! as! Bool
        OptionsSound.isOn = UserDefaults.standard.value(forKey: "Options_Sound")! as! Bool
        
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
            switch MenuStatus {
            case .Menu:
                if KittyBaseballGame_Button.contains(location) {
                    print("进入棒球小游戏!")
                    let nextScene = KittyBaseballGame(size: self.size)
                    self.view?.presentScene(nextScene)
                }
                else if Options_Button.contains(location){
                    print("进入选项！")
                    OptionsViewAnimate(isShow: true)
                }
                break
            default:
                let location = touch.location(in:OptionsView.view)
                if (OptionsBGM.view.contains(location)){
                    OptionsBGM.isOn = !OptionsBGM.isOn
                    UserDefaults.standard.setValue(OptionsBGM.isOn, forKey: "Options_BGM")
                }
                else if(OptionsSound.view.contains(location)){
                    OptionsSound.isOn = !OptionsSound.isOn
                    UserDefaults.standard.setValue(OptionsSound.isOn, forKey: "Options_Sound")
                }
                else if(OptionsBack_Button.contains(location)){
                    OptionsViewAnimate(isShow: false)
                }
            }
        }
    }
    
    func OptionsViewAnimate(isShow:Bool){
        if(isShow == true){
            MenuStatus = .OptionsShow
            let MoveView = SKAction.moveBy(x: size.width * -1, y: 0, duration: 0.5)
            OptionsView.view.run(MoveView, completion: {
                
            })
        }
        else{
            MenuStatus = .Menu
            let MoveView = SKAction.moveBy(x: size.width * -1, y: 0, duration: 0.5)
            OptionsView.view.run(MoveView, completion: {
                self.OptionsView.view.position = CGPoint(x: self.size.width * 1.5, y: self.size.height / 2)
            })
        }
    }
    
    func ShowOptions(){
        OptionsView.view.zPosition = Layers.View.rawValue
        OptionsView.label.text = "Options"
        MenuView.addChild(OptionsView.view)
        OptionsBGM.view.position = CGPoint(x: 0, y: OptionsView.view.size.height * 0.1)
        OptionsBGM.label.text = "BGM"
        OptionsBGM.name = "OptionsBGM"
        OptionsView.view.addChild(OptionsBGM.view)
        
        OptionsSound.view.position = CGPoint(x: 0, y: OptionsView.view.size.height * -0.2)
        OptionsSound.label.text = "Sound"
        OptionsSound.name = "OptionsBGM"
        OptionsView.view.addChild(OptionsSound.view)
        
        OptionsBack_Button = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 44))
        OptionsBack_Button.position = CGPoint(x: 0, y: OptionsView.view.size.height * -0.4)
        OptionsBack_Button.anchorPoint = CGPoint(x: 0.5, y: 0)
        do  {
            let image = SKSpriteNode(imageNamed: "blue_button02")
            image.size = OptionsBack_Button.frame.size
            OptionsBack_Button.addChild(image)
            let label = SKLabelNode(text: "Back")
            label.fontColor = SKColor.white
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            image.addChild(label)
        }
        OptionsView.view.addChild(OptionsBack_Button)
        OptionsView.view.position = CGPoint(x: size.width * 1.5, y: size.height / 2)
        
        
    }
    
        
    
    
}
