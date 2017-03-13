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
    var GameName = SKNode()
    var KittyBaseballGame_Button:SKNode! = nil
    var Options_Button:SKNode! = nil
    var OptionsView = GameObject.Window()
    let OptionsBGM = GameObject.SoundButton()
    let OptionsSound = GameObject.SoundButton()
    var OptionsBack_Button:SKSpriteNode! = nil
    
    var PickMapView = GameObject.Window()
    var PickMap_day:SKSpriteNode! = nil
    var PickMap_evening:SKSpriteNode! = nil
    var PickMap_night:SKSpriteNode! = nil
    var PickMapBack_Button:SKSpriteNode! = nil
    
    var MenuStatus:Status = .Menu
    
    let Sound_Ding = SKAction.playSoundFileNamed("ding.mp3", waitForCompletion: false)
    
    
    /// 图层
    enum Layers: CGFloat{
        case background
        case button
        case view
    }
    
    /// 游戏状态
    enum Status {
        case Menu
        case OptionsShow
        case PickMapShow
    }
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        addChild(MenuView)
        ShowBackground()
        ShowButton()
        ShowLabel()
        ShowOptions()
        ShowPickMap()
        
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
    
    func ShowLabel() {
        GameName = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 160, height: 44))
        GameName.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        GameName.zPosition = Layers.button.rawValue
        let label = SKLabelNode(text: "Kitty Baseball")
        label.fontColor = SKColor.white
        label.position = CGPoint(x: 0, y: 0)
        label.fontSize = 20
        label.verticalAlignmentMode = .center
        label.fontName = "kenpixel"
        GameName.addChild(label)
        MenuView.addChild(GameName)

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
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    self.PickMapViewAnimate(isShow: true)
                    
                }
                else if Options_Button.contains(location){
                    print("进入选项！")
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    OptionsViewAnimate(isShow: true)
                }
                break
            case .OptionsShow:
                let location = touch.location(in:OptionsView.view)
                if (OptionsBGM.view.contains(location)){
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    OptionsBGM.isOn = !OptionsBGM.isOn
                    UserDefaults.standard.setValue(OptionsBGM.isOn, forKey: "Options_BGM")
                }
                else if(OptionsSound.view.contains(location)){
                    OptionsSound.isOn = !OptionsSound.isOn
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    UserDefaults.standard.setValue(OptionsSound.isOn, forKey: "Options_Sound")
                }
                else if(OptionsBack_Button.contains(location)){
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    OptionsViewAnimate(isShow: false)
                }
            case .PickMapShow:
                let location = touch.location(in:PickMapView.view)
                if(PickMapBack_Button.contains(location)){
                    if OptionsSound.isOn {
                        run(Sound_Ding)
                    }
                    PickMapViewAnimate(isShow: false)
                }
                else if PickMap_day.contains(location) || PickMap_evening.contains(location) || PickMap_night.contains(location){
                    if PickMap_day.contains(location){
                        UserDefaults.standard.setValue(GameObject.Map.day.rawValue, forKey: "Map")
                    }
                    else if PickMap_evening.contains(location){
                        UserDefaults.standard.setValue(GameObject.Map.evening.rawValue, forKey: "Map")
                    }
                    else if PickMap_night.contains(location){
                        UserDefaults.standard.setValue(GameObject.Map.night.rawValue, forKey: "Map")
                    }
                    
                    if OptionsSound.isOn {
                     run(Sound_Ding, completion: {
                     
                        let nextScene = KittyBaseballGame(size: self.size)
                        self.view?.presentScene(nextScene)
                     return
                     })
                     }
                     else{
                        let nextScene = KittyBaseballGame(size: self.size)
                        self.view?.presentScene(nextScene)
                     }
                }
                break
            }
        }
    }
    
    func OptionsViewAnimate(isShow:Bool){
        if(isShow == true){
            MenuStatus = .OptionsShow
            let MoveView = SKAction.moveBy(x: size.width * -1, y: 0, duration: 0.5)
            OptionsView.view.run(MoveView)
        }
        else{
            MenuStatus = .Menu
            let MoveView = SKAction.moveBy(x: size.width * -1, y: 0, duration: 0.5)
            OptionsView.view.run(MoveView, completion: {
                self.OptionsView.view.position = CGPoint(x: self.size.width * 1.5, y: self.size.height / 2)
            })
        }
    }
    
    func PickMapViewAnimate(isShow:Bool){
        if(isShow == true){
            MenuStatus = .PickMapShow
            let fadeAway = SKAction.fadeIn(withDuration: 0.5)
            PickMapView.view.run(fadeAway)
        }
        else{
            MenuStatus = .Menu
            let fadeAway = SKAction.fadeOut(withDuration: 0.5)
            PickMapView.view.run(fadeAway)
        }
    }
    
    func ShowOptions(){
        OptionsView.view.zPosition = Layers.view.rawValue
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
    
    func ShowPickMap(){
        PickMapView.view.zPosition = Layers.view.rawValue
        PickMapView.label.text = "Map"
        MenuView.addChild(PickMapView.view)
        
        PickMap_day = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 200, height: 60))
        PickMap_day.position = CGPoint(x: 0, y: OptionsView.view.size.height * 0.2)
        do  {
            let label = SKLabelNode(text: "DayTime")
            label.fontColor = SKColor(red: 0.0, green: 0.59, blue: 0.53, alpha: 1.0)
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            PickMap_day.addChild(label)
        }
        PickMapView.view.addChild(PickMap_day)
        PickMap_evening = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 200, height: 60))
        PickMap_evening.position = CGPoint(x: 0, y: OptionsView.view.size.height * 0.0)
        do  {
            let label = SKLabelNode(text: "Evening")
            label.fontColor = SKColor(red: 1.0, green: 0.34, blue: 0.13, alpha: 1.0)
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            PickMap_evening.addChild(label)
        }
        PickMapView.view.addChild(PickMap_evening)
        PickMap_night = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 200, height: 60))
        PickMap_night.position = CGPoint(x: 0, y: OptionsView.view.size.height * -0.2)
        do  {
            let label = SKLabelNode(text: "Night")
            label.fontColor = SKColor(red: 0.25, green: 0.32, blue: 0.71, alpha: 1.0)
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            PickMap_night.addChild(label)
        }
        PickMapView.view.addChild(PickMap_night)
        
        PickMapBack_Button = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 44))
        PickMapBack_Button.position = CGPoint(x: 0, y: PickMapView.view.size.height * -0.4)
        do  {
            let image = SKSpriteNode(imageNamed: "blue_button02")
            image.size = PickMapBack_Button.frame.size
            PickMapBack_Button.addChild(image)
            let label = SKLabelNode(text: "Back")
            label.fontColor = SKColor.white
            label.position = CGPoint(x: 0, y: 0)
            label.fontSize = 20
            label.verticalAlignmentMode = .center
            label.fontName = "kenpixel"
            image.addChild(label)
        }
        PickMapView.view.addChild(PickMapBack_Button)
        PickMapView.view.position = CGPoint(x: size.width / 2, y: size.height / 2)
        PickMapView.view.alpha = 0.0
    }
    
        
    
    
}
