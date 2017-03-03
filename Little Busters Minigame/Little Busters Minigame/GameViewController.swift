//
//  GameViewController.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/11.
//  Copyright (c) 2016年 dmqlacgal. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let MainView = self.view as? SKView{
            if MainView.scene == nil{
                //创建选项页面
                let MainViewAspectRatio = MainView.bounds.size.height / MainView.bounds.size.width
                let GameMenuView = GameMenu(size: CGSize(width: 320, height: 320 * MainViewAspectRatio))
                MainView.showsFPS = true
                MainView.showsNodeCount = true
                MainView.showsDrawCount = true
                MainView.showsPhysics = true //
                MainView.ignoresSiblingOrder = false
                GameMenuView.scaleMode = .aspectFill
                
                
                if((UserDefaults.standard.value(forKey: "Options_BGM")) == nil){
                    UserDefaults.standard.setValue(true, forKey: "Options_BGM")
                }
                if((UserDefaults.standard.value(forKey: "Options_Sound")) == nil){
                    UserDefaults.standard.setValue(true, forKey: "Options_Sound")
                }
                
                MainView.presentScene(GameMenuView)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
