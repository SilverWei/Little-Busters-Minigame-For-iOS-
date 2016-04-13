//
//  GameCharacter.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/12.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit
import UIKit

class GameCharacter{
    
    struct Unit {
        var character: Character
        var image: [UIImage]
    }

    struct Character{
        var image: UIImage
        var point: CGPoint
        var status: Int
        var imageNumber: Int
    }
    
    //直枝 理樹
    var Naoe_Riki_Attribute = Character(image: UIImage(named: "NaoeRiki")!,
        point: CGPoint(x:  GameBackground().Baseballfield.anchorPoint.x, y: GameBackground().Baseballfield.anchorPoint.y - 100),
        status: 0,
        imageNumber: 0
    )
    func Naoe_Riki_Array() -> [UIImage]{
        var Naoe_Riki_Array:[UIImage] = []
        let Naoe_Riki_H = Naoe_Riki_Attribute.image.size.height / 5
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: 0, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: Naoe_Riki_H, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: Naoe_Riki_H * 2, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: Naoe_Riki_H * 3, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: Naoe_Riki_H * 4, w: 97, h: Naoe_Riki_H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: 0, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: Naoe_Riki_H, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: Naoe_Riki_H * 2, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: Naoe_Riki_H * 3, w: 97, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: Naoe_Riki_H * 4, w: 97, h: Naoe_Riki_H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: 0, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: Naoe_Riki_H, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: Naoe_Riki_H * 2, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: Naoe_Riki_H * 3, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: Naoe_Riki_H * 4, w: 79, h: Naoe_Riki_H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: 0, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: Naoe_Riki_H, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: Naoe_Riki_H * 2, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: Naoe_Riki_H * 3, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: Naoe_Riki_H * 4, w: 79, h: Naoe_Riki_H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79 * 2, y: 0, w: 79, h: Naoe_Riki_H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79 * 2, y: Naoe_Riki_H, w: 79, h: Naoe_Riki_H))
        
        return Naoe_Riki_Array
    }
    enum Naoe_Riki_status{
        case NR_static //静止
        case NR_Swing //挥动
    }

    func ImageInterception(character: Character, x: CGFloat, y: CGFloat, w: CGFloat,h: CGFloat) -> UIImage {
        return UIImage(CGImage: CGImageCreateWithImageInRect(character.image.CGImage, CGRectMake(x, y, w, h))!)
    }
}
