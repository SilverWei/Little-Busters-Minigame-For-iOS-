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
        var attribute: Attribute
        var image: [UIImage]
    }
    struct Attribute{
        var image: UIImage
        var point: CGPoint
        var status: Int
        var imageNumber: Int
        var Shadow_x: CGFloat
        var Shadow_y: CGFloat
        var Shadow_w: CGFloat
        var Shadow_h: CGFloat
    }
    
    //直枝 理樹
    var Naoe_Riki_Attribute = Attribute(image: UIImage(named: "NaoeRiki")!,
        point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x, y: GameObject().Baseballfield().anchorPoint.y - 100),
        status: 0,
        imageNumber: 0,
        Shadow_x: -5,
        Shadow_y: -35,
        Shadow_w: 35,
        Shadow_h: 15
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
    //动作状态
    enum Naoe_Riki_Status{
        case NR_static //静止
        case NR_Swing //挥动
    }
    func Naoe_Riki_Range() -> SKShapeNode{
        let RangePath = UIBezierPath()
        RangePath.moveToPoint(CGPoint(x: 0, y: 0))
        RangePath.addLineToPoint(CGPoint(x: 0, y: 100))
        RangePath.addLineToPoint(CGPoint(x: 120, y: 100))
        RangePath.addLineToPoint(CGPoint(x: 120, y: 0))
        RangePath.addLineToPoint(CGPoint(x: 0, y: 0))
        let Range = SKShapeNode(path: RangePath.CGPath)
        Range.lineWidth = 1.0
        Range.fillColor = SKColor.clearColor()
        Range.strokeColor = SKColor.blueColor()
        Range.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 60, y: GameObject().Baseballfield().anchorPoint.y - 150)
        return Range
    }
    
    //棗 鈴
    var Natsume_Rin_Attribute = Attribute(image: UIImage(named: "NatsumeRin")!,
        point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x, y: GameObject().Baseballfield().anchorPoint.y + 200),
        status: 0,
        imageNumber: 0,
        Shadow_x: -5,
        Shadow_y: -35,
        Shadow_w: 35,
        Shadow_h: 15
    )
    func Natsume_Rin_Array() -> [UIImage]{
        var Natsume_Rin_Array:[UIImage] = []
        let Natsume_Rin_H = (Natsume_Rin_Attribute.image.size.height - 64) / 8
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: 0, w: 68, h: Natsume_Rin_H))
        
        return Natsume_Rin_Array
    }
    //动作状态
    enum Natsume_Rin_Status{
        case NR_static //静止
        case NR_Swing //挥动
    }

    func ImageInterception(character: Attribute, x: CGFloat, y: CGFloat, w: CGFloat,h: CGFloat) -> UIImage {
        return UIImage(CGImage: CGImageCreateWithImageInRect(character.image.CGImage, CGRectMake(x, y, w, h))!)
    }
}

