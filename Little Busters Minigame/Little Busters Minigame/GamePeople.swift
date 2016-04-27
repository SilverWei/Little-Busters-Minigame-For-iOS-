//
//  GamePeople.swift
//  Little Busters Minigame
//
//  Created by dmqlMAC on 16/4/12.
//  Copyright © 2016年 dmqlacgal. All rights reserved.
//

import SpriteKit
import UIKit

class GamePeople{
    
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
    func ImageInterception(People: Attribute, x: CGFloat, y: CGFloat, w: CGFloat,h: CGFloat) -> UIImage {
        return UIImage(CGImage: CGImageCreateWithImageInRect(People.image.CGImage, CGRectMake(x, y, w, h))!)
    }
    
    //MARK: 直枝 理樹
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
        let H = Naoe_Riki_Attribute.image.size.height / 5
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: 0, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: H, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: H * 2, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: H * 3, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 0, y: H * 4, w: 97, h: H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: 0, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: H, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: H * 2, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: H * 3, w: 97, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 97, y: H * 4, w: 97, h: H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: 0, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: H, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: H * 2, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: H * 3, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: H * 4, w: 79, h: H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: 0, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: 0, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195, y: H * 4, w: 79, h: H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 2, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
        //
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79 * 2 + 2, y: 0, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79 * 2 + 2, y: 0, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79, y: H * 2, w: 79, h: H))
        
        
        Naoe_Riki_Array.append(ImageInterception(Naoe_Riki_Attribute, x: 195 + 79 * 2 + 2, y: H, w: 79, h: H))
        
        return Naoe_Riki_Array
    }
    //动作状态
    enum Naoe_Riki_Status{
        case NR_Static //静止
        case NR_Swing //挥动
        case NR_FallDown //摔倒
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
    func Naoe_Riki_Contact() -> [CGPath]{
        var Contact_Array:[CGPath] = []
        let path1 = CGPathCreateMutable()
        CGPathMoveToPoint(path1, nil, 13, -10)
        CGPathAddLineToPoint(path1, nil, 37, -19)
        CGPathAddLineToPoint(path1, nil, 21, -29)
        CGPathCloseSubpath(path1)
        Contact_Array.append(path1)
        let path2 = CGPathCreateMutable()
        CGPathMoveToPoint(path2, nil, 19, -6)
        CGPathAddLineToPoint(path2, nil, 48, -5)
        CGPathAddLineToPoint(path2, nil, 39, -12)
        CGPathCloseSubpath(path2)
        Contact_Array.append(path2)
        let path3 = CGPathCreateMutable()
        CGPathMoveToPoint(path3, nil, 15, -3)
        CGPathAddLineToPoint(path3, nil, 41, 8)
        CGPathAddLineToPoint(path3, nil, 37, -2)
        CGPathCloseSubpath(path3)
        Contact_Array.append(path3)
        return Contact_Array
    }
    func Naoe_Riki_BodyContact() -> SKShapeNode{
        let Body = SKShapeNode()
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 3, -15)
        CGPathAddLineToPoint(path, nil, 3, -20)
        CGPathAddLineToPoint(path, nil, -10, -20)
        CGPathAddLineToPoint(path, nil, -10, -15)
        CGPathCloseSubpath(path)
        Body.physicsBody = SKPhysicsBody(polygonFromPath: path)
        Body.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleFront
        Body.physicsBody?.collisionBitMask = 0
        Body.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
        return Body
    }
    
    
    //MARK: 棗 鈴
    var Natsume_Rin_Attribute = Attribute(image: UIImage(named: "NatsumeRin")!,
        point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x, y: GameObject().Baseballfield().anchorPoint.y + 235),
        status: 0,
        imageNumber: 0,
        Shadow_x: -4,
        Shadow_y: -33,
        Shadow_w: 35,
        Shadow_h: 15
    )
    func Natsume_Rin_Array() -> [UIImage]{
        var Natsume_Rin_Array:[UIImage] = []
        var H:CGFloat = 73
        var W:CGFloat = 68
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: -1, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: -1 + H, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: -1 + H * 2, w: W, h: H))
        
        H = 65
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: 224, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: 305, w: W, h: H))
        
        H = 80
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: 375, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: 375 + H, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: 0, y: 375 + H * 2, w: W, h: H))
        
        H = 640 / 8
        var L:CGFloat = 68
        var T:CGFloat = -6
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 2, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 3, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 4, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 5, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 6, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 7, w: W, h: H))
        
        
        L = 135
        W = 56
        T = -6
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 2, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 3, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 4, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 5, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 6, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 7, w: W, h: H))
        
        L = 191
        W = 70
        T = -7
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 2, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 3, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 4, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 5, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 6, w: W, h: H))
        Natsume_Rin_Array.append(ImageInterception(Natsume_Rin_Attribute, x: L, y: T + H * 7, w: W, h: H))
        return Natsume_Rin_Array
    }
    //动作状态
    enum Natsume_Rin_Status{
        case NR_Static //静止
        case NR_Catch //接球
        case NR_Anger //愤怒
        case NR_Swing //挥动
        case NR_Surprise //惊讶
        case NR_ShelterLeft //左躲避
        case NR_ShelterRight //右躲避
    }

    //MARK: 棗 恭介
    var Natsume_Kyousuke_Attribute = Attribute(image: UIImage(named: "NatsumeKyousuke")!,
        point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x - 630, y: GameObject().Baseballfield().anchorPoint.y + 220),
        status: 0,
        imageNumber: 0,
        Shadow_x: 0,
        Shadow_y: -30,
        Shadow_w: 35,
        Shadow_h: 15
    )
    func Natsume_Kyousuke_Array() -> [UIImage]{
        var Natsume_Kyousuke_Array:[UIImage] = []
        let H:CGFloat = 72
        let W:CGFloat = 64
        let T:CGFloat = 5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: 0, y: T, w: W, h: H)) //1:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: 0, y: T + H, w: W, h: H)) //1:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: 0, y: T + H * 2, w: W, h: H)) //1:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: 0, y: T + H * 3, w: W, h: H)) //1:4
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T, w: W, h: H)) //2:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T + H, w: W, h: H)) //2:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T + H * 2, w: W, h: H)) //2:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T + H * 3, w: W, h: H)) //2:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T + H * 4, w: W, h: H)) //2:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T + H * 5, w: W, h: H)) //2:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T + H * 6, w: W, h: H)) //2:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W, y: T + H * 7, w: W, h: H)) //2:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T, w: W, h: H)) //3:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T + H, w: W, h: H)) //3:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T + H * 2, w: W, h: H)) //3:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T + H * 3, w: W, h: H)) //3:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T + H * 4, w: W, h: H)) //3:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T + H * 5, w: W, h: H)) //3:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T + H * 6, w: W, h: H)) //3:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 2, y: T + H * 7, w: W, h: H)) //3:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T, w: W, h: H))			//4:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T + H, w: W, h: H))		//4:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T + H * 2, w: W, h: H)) 	//4:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T + H * 3, w: W, h: H)) 	//4:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T + H * 4, w: W, h: H)) 	//4:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T + H * 5, w: W, h: H)) 	//4:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T + H * 6, w: W, h: H)) 	//4:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 3, y: T + H * 7, w: W, h: H)) 	//4:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T, w: W, h: H))			//5:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T + H, w: W, h: H))		//5:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T + H * 2, w: W, h: H)) 	//5:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T + H * 3, w: W, h: H)) 	//5:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T + H * 4, w: W, h: H)) 	//5:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T + H * 5, w: W, h: H)) 	//5:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T + H * 6, w: W, h: H)) 	//5:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 4, y: T + H * 7, w: W, h: H)) 	//5:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T, w: W, h: H))			//6:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T + H, w: W, h: H))		//6:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T + H * 2, w: W, h: H)) 	//6:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T + H * 3, w: W, h: H)) 	//6:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T + H * 4, w: W, h: H)) 	//6:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T + H * 5, w: W, h: H)) 	//6:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T + H * 6, w: W, h: H)) 	//6:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 5, y: T + H * 7, w: W, h: H)) 	//6:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T, w: W, h: H))			//7:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T + H, w: W, h: H))		//7:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T + H * 2, w: W, h: H)) 	//7:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T + H * 3, w: W, h: H)) 	//7:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T + H * 4, w: W, h: H)) 	//7:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T + H * 5, w: W, h: H)) 	//7:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T + H * 6, w: W, h: H)) 	//7:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 6, y: T + H * 7, w: W, h: H)) 	//7:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T, w: W, h: H))			//8:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T + H, w: W, h: H))		//8:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T + H * 2, w: W, h: H)) 	//8:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T + H * 3, w: W, h: H)) 	//8:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T + H * 4, w: W, h: H)) 	//8:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T + H * 5, w: W, h: H)) 	//8:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T + H * 6, w: W, h: H)) 	//8:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 7, y: T + H * 7, w: W, h: H)) 	//8:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T, w: W, h: H))			//9:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T + H, w: W, h: H))		//9:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T + H * 2, w: W, h: H)) 	//9:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T + H * 3, w: W, h: H)) 	//9:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T + H * 4, w: W, h: H)) 	//9:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T + H * 5, w: W, h: H)) 	//9:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T + H * 6, w: W, h: H)) 	//9:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 8, y: T + H * 7, w: W, h: H)) 	//9:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T, w: W, h: H))			//10:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T + H, w: W, h: H))		//10:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T + H * 2, w: W, h: H)) 	//10:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T + H * 3, w: W, h: H)) 	//10:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T + H * 4, w: W, h: H)) 	//10:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T + H * 5, w: W, h: H)) 	//10:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T + H * 6, w: W, h: H)) 	//10:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 9, y: T + H * 7, w: W, h: H)) 	//10:8
        
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T, w: W, h: H))			//11:1
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T + H, w: W, h: H))		//11:2
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T + H * 2, w: W, h: H)) 	//11:3
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T + H * 3, w: W, h: H)) 	//11:4
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T + H * 4, w: W, h: H)) 	//11:5
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T + H * 5, w: W, h: H)) 	//11:6
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T + H * 6, w: W, h: H)) 	//11:7
        Natsume_Kyousuke_Array.append(ImageInterception(Natsume_Kyousuke_Attribute, x: W * 10, y: T + H * 7, w: W, h: H)) 	//11:8
        
        return Natsume_Kyousuke_Array
    }
    //动作状态
    enum Natsume_Kyousuke_Status{
        case NK_Static //静止
        case NK_Run //跑
        case NK_Swing //挥动
        case NK_Catch //接球
        case NK_Wave //招手
    }
}

