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
    /// 属性
    struct Attribute{
        var image: UIImage
        var point: CGPoint
        var status: Int
        var imageNumber: Int
        var Shadow_x: CGFloat
        var Shadow_y: CGFloat
        var Shadow_w: CGFloat
        var Shadow_h: CGFloat
        var Unit: SKShapeNode
        var Shadow: SKShapeNode
    }
    //图像截取
    func ImageInterception(_ People: Attribute, x: CGFloat, y: CGFloat, w: CGFloat,h: CGFloat) -> UIImage {
        return UIImage(cgImage: People.image.cgImage!.cropping(to: CGRect(x: x, y: y, width: w, height: h))!)
    }
    
    //MARK: 直枝 理樹
    class Naoe_Riki: NSObject {
        class Main: NSObject {
            var Unit = GamePeople.Unit(attribute: Naoe_Riki().Attribute,image: Naoe_Riki().Array())
            var View = SKSpriteNode(texture: SKTexture(image: Naoe_Riki().Array()[0]))
            var Range = Naoe_Riki().Range()
        }
        var Attribute = GamePeople.Attribute(image: UIImage(named: "NaoeRiki")!,
                                            point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x, y: GameObject().Baseballfield().anchorPoint.y - 100),
                                            status: 0,
                                            imageNumber: 0,
                                            Shadow_x: -5,
                                            Shadow_y: -35,
                                            Shadow_w: 35,
                                            Shadow_h: 15,
                                            Unit: SKShapeNode(),
                                            Shadow: SKShapeNode()
        )
        func Array() -> [UIImage]{
            var Array:[UIImage] = []
            let H = Attribute.image.size.height / 5
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: 0, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: H, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: H * 2, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: H * 3, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: H * 4, w: 97, h: H))
            
            Array.append(GamePeople().ImageInterception(Attribute, x: 97, y: 0, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 97, y: H, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 97, y: H * 2, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 97, y: H * 3, w: 97, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 97, y: H * 4, w: 97, h: H))
            
            Array.append(GamePeople().ImageInterception(Attribute, x: 195, y: 0, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195, y: H, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195, y: H * 2, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195, y: H * 3, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195, y: H * 4, w: 79, h: H))
            
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: 0, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: 0, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195, y: H * 4, w: 79, h: H))
            
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 2, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
            
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79 * 2 + 2, y: 0, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
            
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79 * 2 + 2, y: 0, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 4, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 3, w: 79, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79, y: H * 2, w: 79, h: H))
            
            
            Array.append(GamePeople().ImageInterception(Attribute, x: 195 + 79 * 2 + 2, y: H, w: 79, h: H))
            
            return Array
        }
        /// 动作状态
        ///
        /// - nr_Static:   静止
        /// - nr_Swing:    挥动
        /// - nr_FallDown: 摔倒
        enum Status{
            case nr_Static
            case nr_Swing
            case nr_FallDown
        }
        /// 范围
        ///
        /// - returns: SKShapeNode
        func Range() -> SKShapeNode{
            let RangePath = UIBezierPath()
            RangePath.move(to: CGPoint(x: 0, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: 100))
            RangePath.addLine(to: CGPoint(x: 120, y: 100))
            RangePath.addLine(to: CGPoint(x: 120, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: 0))
            let Range = SKShapeNode(path: RangePath.cgPath)
            Range.lineWidth = 1.0
            Range.fillColor = SKColor.clear
            Range.strokeColor = SKColor.blue
            Range.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 60, y: GameObject().Baseballfield().anchorPoint.y - 150)
            return Range
        }
        /// 物理接触点
        ///
        /// - returns: 接触范围
        func Contact() -> [CGPath]{
            var Contact_Array:[CGPath] = []
            let path1 = CGMutablePath()
            path1.move(to: CGPoint(x: 13, y: -10))
            path1.addLine(to:CGPoint(x: 37, y: -19))
            path1.addLine(to:CGPoint(x: 21, y: -29))
            path1.closeSubpath()
            Contact_Array.append(path1)
            let path2 = CGMutablePath()
            path2.move(to: CGPoint(x: 19, y: -6))
            path2.addLine(to:CGPoint(x: 48, y: -5))
            path2.addLine(to:CGPoint(x: 39, y: -12))
            path2.closeSubpath()
            Contact_Array.append(path2)
            let path3 = CGMutablePath()
            path3.move(to: CGPoint(x: 15,y: -3))
            path3.addLine(to:CGPoint(x: 41, y: 8))
            path3.addLine(to:CGPoint(x: 37, y: -2))
            path3.closeSubpath()
            Contact_Array.append(path3)
            return Contact_Array
        }
        /// 身体接触点
        ///
        /// - returns: SKShapeNode
        func BodyContact() -> SKShapeNode{
            let Body = SKShapeNode()
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 3,y: -15))
            path.addLine(to:CGPoint(x: 3, y: -20))
            path.addLine(to:CGPoint(x: -10, y: -20))
            path.addLine(to:CGPoint(x: -10, y: -15))
            path.closeSubpath()
            Body.physicsBody = SKPhysicsBody(polygonFrom: path)
            Body.physicsBody?.categoryBitMask = KittyBaseballGame.Collision.PeopleFront
            Body.physicsBody?.collisionBitMask = 0
            Body.physicsBody?.contactTestBitMask = KittyBaseballGame.Collision.Baseball
            return Body
        }
        
    }
    
    
    //MARK: 棗 鈴
    class Natsume_Rin: NSObject {
        class Main: NSObject {
            var Unit = GamePeople.Unit(attribute: Natsume_Rin().Attribute,image: Natsume_Rin().Array())
            var View = SKSpriteNode(texture: SKTexture(image: Natsume_Rin().Array()[0]))
        }
        var Attribute = GamePeople.Attribute(image: UIImage(named: "NatsumeRin")!,
                                              point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x, y: GameObject().Baseballfield().anchorPoint.y + 235),
                                              status: 0,
                                              imageNumber: 0,
                                              Shadow_x: -4,
                                              Shadow_y: -33,
                                              Shadow_w: 35,
                                              Shadow_h: 15,
                                              Unit: SKShapeNode(),
                                              Shadow: SKShapeNode()
        )
        func Array() -> [UIImage]{
            var Array:[UIImage] = []
            var H:CGFloat = 73
            var W:CGFloat = 68
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: -1, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: -1 + H, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: -1 + H * 2, w: W, h: H))
            
            H = 65
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: 224, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: 305, w: W, h: H))
            
            H = 80
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: 375, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: 375 + H, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: 375 + H * 2, w: W, h: H))
            
            H = 640 / 8
            var L:CGFloat = 68
            var T:CGFloat = -6
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 2, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 3, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 4, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 5, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 6, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 7, w: W, h: H))
            
            L = 135
            W = 56
            T = -6
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 2, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 3, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 4, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 5, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 6, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 7, w: W, h: H))
            
            L = 191
            W = 70
            T = -7
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 2, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 3, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 4, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 5, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 6, w: W, h: H))
            Array.append(GamePeople().ImageInterception(Attribute, x: L, y: T + H * 7, w: W, h: H))
            return Array
        }
        /// 动作状态
        ///
        /// - nr_Static:        静止
        /// - nr_Catch:         接球
        /// - nr_Anger:         愤怒
        /// - nr_Swing:         挥动
        /// - nr_Surprise:      惊讶
        /// - nr_ShelterLeft:  左躲避
        /// - nr_ShelterRight: 右躲避
        enum Status{
            case nr_Static
            case nr_Catch
            case nr_Anger
            case nr_Swing
            case nr_Surprise
            case nr_ShelterLeft
            case nr_ShelterRight
        }

    }

    //MARK: 棗 恭介
    class Natsume_Kyousuke: NSObject {
        class Main: NSObject {
            var Unit = GamePeople.Unit(attribute: Natsume_Kyousuke().Attribute, image: Natsume_Kyousuke().Array())
            var View = SKSpriteNode(texture: SKTexture(image: Natsume_Kyousuke().Array()[0]))
            var Range = Natsume_Kyousuke().Range()
        }
        var Attribute = GamePeople.Attribute(image: UIImage(named: "NatsumeKyousuke")!,
                                                   point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x - 630, y: GameObject().Baseballfield().anchorPoint.y + 220),
                                                   status: 0,
                                                   imageNumber: 0,
                                                   Shadow_x: 0,
                                                   Shadow_y: -30,
                                                   Shadow_w: 35,
                                                   Shadow_h: 15,
                                                   Unit: SKShapeNode(),
                                                   Shadow: SKShapeNode()
        )
        func Array() -> [UIImage]{
            var Array:[UIImage] = []
            let H:CGFloat = 72
            let W:CGFloat = 64
            let T:CGFloat = 3
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: T, w: W, h: H)) //1:1
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: T + H, w: W, h: H)) //1:2
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: T + H * 2, w: W, h: H)) //1:3
            Array.append(GamePeople().ImageInterception(Attribute, x: 0, y: T + H * 3, w: W, h: H)) //1:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T, w: W, h: H)) //2:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T + H, w: W, h: H)) //2:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T + H * 2, w: W, h: H)) //2:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T + H * 3, w: W, h: H)) //2:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T + H * 4, w: W, h: H)) //2:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T + H * 5, w: W, h: H)) //2:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T + H * 6, w: W, h: H)) //2:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W, y: T + H * 7, w: W, h: H)) //2:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T, w: W, h: H)) //3:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T + H, w: W, h: H)) //3:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T + H * 2, w: W, h: H)) //3:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T + H * 3, w: W, h: H)) //3:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T + H * 4, w: W, h: H)) //3:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T + H * 5, w: W, h: H)) //3:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T + H * 6, w: W, h: H)) //3:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 2, y: T + H * 7, w: W, h: H)) //3:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T, w: W, h: H))			//4:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T + H, w: W, h: H))		//4:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T + H * 2, w: W, h: H)) 	//4:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T + H * 3, w: W, h: H)) 	//4:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T + H * 4, w: W, h: H)) 	//4:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T + H * 5, w: W, h: H)) 	//4:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T + H * 6, w: W, h: H)) 	//4:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 3, y: T + H * 7, w: W, h: H)) 	//4:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T, w: W, h: H))			//5:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T + H, w: W, h: H))		//5:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T + H * 2, w: W, h: H)) 	//5:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T + H * 3, w: W, h: H)) 	//5:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T + H * 4, w: W, h: H)) 	//5:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T + H * 5, w: W, h: H)) 	//5:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T + H * 6, w: W, h: H)) 	//5:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 4, y: T + H * 7, w: W, h: H)) 	//5:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T, w: W, h: H))			//6:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T + H, w: W, h: H))		//6:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T + H * 2, w: W, h: H)) 	//6:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T + H * 3, w: W, h: H)) 	//6:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T + H * 4, w: W, h: H)) 	//6:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T + H * 5, w: W, h: H)) 	//6:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T + H * 6, w: W, h: H)) 	//6:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 5, y: T + H * 7, w: W, h: H)) 	//6:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T, w: W, h: H))			//7:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T + H, w: W, h: H))		//7:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T + H * 2, w: W, h: H)) 	//7:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T + H * 3, w: W, h: H)) 	//7:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T + H * 4, w: W, h: H)) 	//7:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T + H * 5, w: W, h: H)) 	//7:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T + H * 6, w: W, h: H)) 	//7:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 6, y: T + H * 7, w: W, h: H)) 	//7:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T, w: W, h: H))			//8:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T + H, w: W, h: H))		//8:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T + H * 2, w: W, h: H)) 	//8:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T + H * 3, w: W, h: H)) 	//8:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T + H * 4, w: W, h: H)) 	//8:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T + H * 5, w: W, h: H)) 	//8:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T + H * 6, w: W, h: H)) 	//8:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 7, y: T + H * 7, w: W, h: H)) 	//8:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T, w: W, h: H))			//9:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T + H, w: W, h: H))		//9:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T + H * 2, w: W, h: H)) 	//9:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T + H * 3, w: W, h: H)) 	//9:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T + H * 4, w: W, h: H)) 	//9:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T + H * 5, w: W, h: H)) 	//9:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T + H * 6, w: W, h: H)) 	//9:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 8, y: T + H * 7, w: W, h: H)) 	//9:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T, w: W, h: H))			//10:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T + H, w: W, h: H))		//10:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T + H * 2, w: W, h: H)) 	//10:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T + H * 3, w: W, h: H)) 	//10:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T + H * 4, w: W, h: H)) 	//10:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T + H * 5, w: W, h: H)) 	//10:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T + H * 6, w: W, h: H)) 	//10:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 9, y: T + H * 7, w: W, h: H)) 	//10:8
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T, w: W, h: H))			//11:1
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T + H, w: W, h: H))		//11:2
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T + H * 2, w: W, h: H)) 	//11:3
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T + H * 3, w: W, h: H)) 	//11:4
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T + H * 4, w: W, h: H)) 	//11:5
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T + H * 5, w: W, h: H)) 	//11:6
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T + H * 6, w: W, h: H)) 	//11:7
            Array.append(GamePeople().ImageInterception(Attribute, x: W * 10, y: T + H * 7, w: W, h: H)) 	//11:8
            
            return Array
        }
        /// 动作状态
        ///
        /// - nk_Static: 静止
        /// - nk_Run:     跑
        /// - nk_Return: 返回
        /// - nk_Swing:  挥动
        /// - nk_Catch:  接球
        /// - nk_Wave:   招手
        /// - nk_PickUp: 捡起
        enum Status{
            case nk_Static
            case nk_Run
            case nk_Return
            case nk_Swing
            case nk_Catch
            case nk_Wave
            case nk_PickUp
        }
        /// 棒球接触点
        ///
        /// - returns: CGMutablePath
        func BodyContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 20,y: 30))
            path.addLine(to: CGPoint(x: 20, y: -40))
            path.addLine(to: CGPoint(x: -10, y: -40))
            path.addLine(to: CGPoint(x: -10, y: 30))
            path.closeSubpath()
            return path
        }
        /// 跑步接触点
        ///
        /// - returns: CGMutablePath
        func RunContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 5,y: -10))
            path.addLine(to: CGPoint(x: 5, y: -30))
            path.addLine(to: CGPoint(x: -5, y: -30))
            path.addLine(to: CGPoint(x: -5, y: -10))
            path.closeSubpath()
            return path
        }
        /// 移动范围
        ///
        /// - returns: SKShapeNode
        func Range() -> SKShapeNode{
            let RangePath = UIBezierPath()
            let x = 410
            let y = 240
            RangePath.move(to: CGPoint(x: 0, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: 0))
            let Range = SKShapeNode(path: RangePath.cgPath)
            Range.lineWidth = 1.0
            Range.fillColor = SKColor.clear
            Range.strokeColor = SKColor.blue
            Range.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 810, y: GameObject().Baseballfield().anchorPoint.y + 70)
            return Range
        }
    }
    
    //MARK: 来ヶ谷 唯湖
    class Kurugaya_Yuiko: NSObject {
        class Main: NSObject {
            var Unit = GamePeople.Unit(attribute: Kurugaya_Yuiko().Attribute, image: Natsume_Kyousuke().Array())
            var View = SKSpriteNode(texture: SKTexture(image: Natsume_Kyousuke().Array()[0]))
            var Range = Kurugaya_Yuiko().Range()
        }
        var Attribute = GamePeople.Attribute(image: UIImage(named: "NatsumeKyousuke")!,
                                             point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x - 180, y: GameObject().Baseballfield().anchorPoint.y + 450),
                                             status: 0,
                                             imageNumber: 0,
                                             Shadow_x: 0,
                                             Shadow_y: -30,
                                             Shadow_w: 35,
                                             Shadow_h: 15,
                                             Unit: SKShapeNode(),
                                             Shadow: SKShapeNode()
        )
        
        /// 棒球接触点
        ///
        /// - returns: CGMutablePath
        func BodyContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 20,y: 30))
            path.addLine(to: CGPoint(x: 20, y: -40))
            path.addLine(to: CGPoint(x: -10, y: -40))
            path.addLine(to: CGPoint(x: -10, y: 30))
            path.closeSubpath()
            return path
        }
        /// 跑步接触点
        ///
        /// - returns: CGMutablePath
        func RunContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 15,y:0))
            path.addLine(to: CGPoint(x: 15, y: -30))
            path.addLine(to: CGPoint(x: -15, y: -30))
            path.addLine(to: CGPoint(x: -15, y: 0))
            path.closeSubpath()
            return path
        }
        /// 移动范围
        ///
        /// - returns: SKShapeNode
        func Range() -> SKShapeNode{
            let RangePath = UIBezierPath()
            let x = 410
            let y = 240
            RangePath.move(to: CGPoint(x: 0, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: 0))
            let Range = SKShapeNode(path: RangePath.cgPath)
            Range.lineWidth = 1.0
            Range.fillColor = SKColor.clear
            Range.strokeColor = SKColor.blue
            Range.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x - 400, y: GameObject().Baseballfield().anchorPoint.y + 310)
            return Range
        }
        
    }
    
    //MARK: 三枝 葉留佳
    class Saigusa_Haruka: NSObject {
        class Main: NSObject {
            var Unit = GamePeople.Unit(attribute: Saigusa_Haruka().Attribute, image: Natsume_Kyousuke().Array())
            var View = SKSpriteNode(texture: SKTexture(image: Natsume_Kyousuke().Array()[0]))
            var Range = Saigusa_Haruka().Range()
        }
        var Attribute = GamePeople.Attribute(image: UIImage(named: "NatsumeKyousuke")!,
                                             point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x + 180, y: GameObject().Baseballfield().anchorPoint.y + 450),
                                             status: 0,
                                             imageNumber: 0,
                                             Shadow_x: 0,
                                             Shadow_y: -30,
                                             Shadow_w: 35,
                                             Shadow_h: 15,
                                             Unit: SKShapeNode(),
                                             Shadow: SKShapeNode()
        )
        
        /// 棒球接触点
        ///
        /// - returns: CGMutablePath
        func BodyContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -10,y: 30))
            path.addLine(to: CGPoint(x: -10, y: -40))
            path.addLine(to: CGPoint(x: 20, y: -40))
            path.addLine(to: CGPoint(x: 20, y: 30))
            path.closeSubpath()
            return path
        }
        /// 跑步接触点
        ///
        /// - returns: CGMutablePath
        func RunContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 15,y:0))
            path.addLine(to: CGPoint(x: 15, y: -30))
            path.addLine(to: CGPoint(x: -15, y: -30))
            path.addLine(to: CGPoint(x: -15, y: 0))
            path.closeSubpath()
            return path
        }
        /// 移动范围
        ///
        /// - returns: SKShapeNode
        func Range() -> SKShapeNode{
            let RangePath = UIBezierPath()
            let x = -410
            let y = 240
            RangePath.move(to: CGPoint(x: 0, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: 0))
            let Range = SKShapeNode(path: RangePath.cgPath)
            Range.lineWidth = 1.0
            Range.fillColor = SKColor.clear
            Range.strokeColor = SKColor.blue
            Range.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x + 400, y: GameObject().Baseballfield().anchorPoint.y + 310)
            return Range
        }
        
    }
    
    //MARK: 井ノ原 真人
    class Inohara_Masato: NSObject {
        class Main: NSObject {
            var Unit = GamePeople.Unit(attribute: Inohara_Masato().Attribute, image: Natsume_Kyousuke().Array())
            var View = SKSpriteNode(texture: SKTexture(image: Natsume_Kyousuke().Array()[0]))
            var Range = Inohara_Masato().Range()
        }
        var Attribute = GamePeople.Attribute(image: UIImage(named: "NatsumeKyousuke")!,
                                             point: CGPoint(x:  GameObject().Baseballfield().anchorPoint.x + 630, y: GameObject().Baseballfield().anchorPoint.y + 220),
                                             status: 0,
                                             imageNumber: 0,
                                             Shadow_x: 0,
                                             Shadow_y: -30,
                                             Shadow_w: 35,
                                             Shadow_h: 15,
                                             Unit: SKShapeNode(),
                                             Shadow: SKShapeNode()
        )
        
        /// 棒球接触点
        ///
        /// - returns: CGMutablePath
        func BodyContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -10,y: 30))
            path.addLine(to: CGPoint(x: -10, y: -40))
            path.addLine(to: CGPoint(x: 20, y: -40))
            path.addLine(to: CGPoint(x: 20, y: 30))
            path.closeSubpath()
            return path
        }
        /// 跑步接触点
        ///
        /// - returns: CGMutablePath
        func RunContact() -> CGMutablePath{
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 15,y:0))
            path.addLine(to: CGPoint(x: 15, y: -30))
            path.addLine(to: CGPoint(x: -15, y: -30))
            path.addLine(to: CGPoint(x: -15, y: 0))
            path.closeSubpath()
            return path
        }
        /// 移动范围
        ///
        /// - returns: SKShapeNode
        func Range() -> SKShapeNode{
            let RangePath = UIBezierPath()
            let x = -410
            let y = 240
            RangePath.move(to: CGPoint(x: 0, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: y))
            RangePath.addLine(to: CGPoint(x: x, y: 0))
            RangePath.addLine(to: CGPoint(x: 0, y: 0))
            let Range = SKShapeNode(path: RangePath.cgPath)
            Range.lineWidth = 1.0
            Range.fillColor = SKColor.clear
            Range.strokeColor = SKColor.blue
            Range.position = CGPoint(x: GameObject().Baseballfield().anchorPoint.x + 810, y: GameObject().Baseballfield().anchorPoint.y + 70)
            return Range
        }
        
    }
}

