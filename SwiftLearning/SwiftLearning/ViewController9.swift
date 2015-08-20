//
//  ViewController9.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/20.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

extension Double{
    
    var km: Double { return self * 1_000.0}
    var m: Double { return self}
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}


//有默认构造器
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect{
    init(center: Point, size: Size){
        var x1 = center.x - size.width/2
        var y1 = center.y - size.height/2
        self.init(origin: Point(x:x1, y:y1), size:size)
    }
}

extension Int{
    func repitition(task: () -> ()){
        for i in 1...self{
            task()
        }
    }
}

//int 是结构体 值类型 不能改变成员
// 可以使用 变异 函数去修改成员
// 变异函数要加 mutating 关键字
extension Int{
    mutating func square(){
        self = self * self
    }
}

extension Int{
    subscript(index: Int) -> Int{
        var decimalBase = 1
        if(index > 0){
            for _ in 1...index {
                decimalBase *= 10
            }
        }

        return (self / decimalBase) % 10
    }
}

extension Character {
    enum Kind {
        case Vowel, Consonant, Other
    }
    var kind: Kind {
        switch String(self).lowercaseString {
        case "a", "e", "i", "o", "u":
            return .Vowel
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            return .Consonant
        default:
            return .Other
        }
    }
}


class ViewController9: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test1()

        test2()
        
        test3()
        
        test4()
        
        test5()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 扩展 计算型属性(Computed Properties)
    func test1(){
        var cmTest = 1.0.cm
        println("cm value \(cmTest)")
    }
    
    // 扩展 构造器(Initializers)
    func test2(){
    
        //默认构造器演示
        var rect = Rect()
        println("orgin: \(rect.origin.x), \(rect.origin.x)    size: \(rect.size.width), \(rect.size.width) ")
        
        //扩展构造器
        var rect1 = Rect(center: Point(x:1.0, y:1.0), size: Size(width:2.0, height:2.0))
        println("orgin: \(rect1.origin.x), \(rect1.origin.x)    size: \(rect1.size.width), \(rect1.size.width) ")
    }
    
    // 扩展 方法(Methods)
    func test3(){
        var i: Int = 3
        i.repitition { () -> () in
            println("extension method !!!")
        }
        
        var j: Int = 4;
        j.square()
        println("square: \(j)")
    }
    
    // 扩展 下标(Subscripts)
    func test4(){
        var i: Int = 12345
        println("the last number: \(i[0])")
        
        println("the last but one number: \(i[1])")
    }

    //嵌套类型(Nested Types)
    func test5(){
       
        for character in "word" {
            switch character.kind {
            case .Vowel:
                print("vowel ")
            case .Consonant:
                print("consonant ")
            case .Other:
                print("other ")
            }
        }
        print("\n")
    }

}
