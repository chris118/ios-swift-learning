//
//  ViewController12.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/25.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

class ViewController12: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let initBits: UInt8 = 0b00001111
        
         println("initBits = \(initBits)")
        
        let invertBits: UInt8 = ~initBits
        
        println("invertBits = \(invertBits)")
        
        //溢出操作符
        var willOverflow = UInt8.max
        // willOverflow 等于UInt8的最大整数 255
        willOverflow = willOverflow &+ 1
        // 这时候 willOverflow 等于 0
        println("willOverflow = \(willOverflow)")
        
        
        //运算符重载
        let vector = Vector2D(x: 3.0, y: 1.0)
        let anotherVector = Vector2D(x: 2.0, y: 4.0)
        let combinedVector = vector + anotherVector
        
        println("x =  \(combinedVector.x)  y = \(combinedVector.y)")
        
        
        //自定义运算符
        var vector1 = Vector2D(x: 3.0, y: 1.0)
        vector1 = +++vector1
        
        println("x =  \(vector1.x)  y = \(vector1.y)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//运算符重载
struct Vector2D {
    var x = 0.0, y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

//自定义运算符
prefix operator +++ {}
prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector.x += vector.x
    vector.y += vector.y
    return vector
}

