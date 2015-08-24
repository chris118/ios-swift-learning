//
//  ViewController10.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/23.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit


protocol DemoProtocal {
    
    //属性
    var fullName: String { get }
    
    // 类成员函数， 相当于静态函数
    class func pet() -> String
    
    //方法
    func say() -> NSString
    
    //突变函数， 可以修改结构体里边的成员
    // 如果没有muating 结构体是值类型， 不能改变成员
    mutating func act()
}

struct DemoStruct: DemoProtocal {
    
    //类的成员变量不用初始化
    var fullName: String
    
    func say() -> NSString{
        return "My name is \(fullName)"
    }
    
    // 相当于静态函数 结构 枚举里边用static, 类里边用class
    static func pet() -> String {
        return "kitty"
    }
    
    mutating func act() {
        fullName = "Mike"
    }
}

class People1: DemoProtocal{
    
    var fullName: String
    
    init() {
        fullName = ""
    }
    
    func say() -> NSString{
        return "My name is \(fullName)"
    }
    
    // 类成员函数， 相当于静态函数
    class func pet() -> String {
        return "kitty"
    }
    
    // 类不用加 muating关键字
    func act(){
        fullName = "Mike"
    }
}

//协议可以做参数
class Student{
    
    var name: String
    init(p: DemoProtocal){
        name = p.fullName
    }
}

//委托
protocol taskProtocal{
    func doWork()
}

class Boss{

    var delegate: taskProtocal?
    
    func recievedTask(){
        self.delegate?.doWork()
    }
}

class Worker: taskProtocal {
    func doWork(){
        println("worker is working hard")
    }
}

protocol playProtocal{
    func haveFun()
}

extension Boss: playProtocal{
    func haveFun() {
        println("Boss is playing")
    }
}


//合成协议
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person3: Named, Aged {
    var name: String
    var age: Int
}


//可选协议要求
@objc protocol SexyProtocal{
    optional var sex: String { get }
    optional func getSex() -> String
}

class Boy: SexyProtocal {
    // 不用实现 sex 属性也可以的
}


class ViewController10: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test1()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
        println("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
    }
    
    func test1(){
        var p1: People1 = People1()
        p1.fullName = "John"
        println(p1.say())
        
        //协议可以做参数
        var w: Student = Student(p: p1)
        println(w.name)
        
        //委托
        var aBoss: Boss = Boss()
        var aWorker: Worker = Worker()
        aBoss.delegate = aWorker
        aBoss.recievedTask()
        
        //扩展
        aBoss.haveFun()
        
        //合成协议做为参数
        //协议组合不定义一个新的，永久的协议类型。相反，他们定义了一个临时的本地协议，统一了组合中所有协议的需求
        wishHappyBirthday(Person3(name: "jack", age: 20))
        
        
        ////可选协议要求
        var b: SexyProtocal = Boy()
        println(b.sex)  // nil Boy没实现
        println(b.getSex?()) // nil Boy没实现
        
    }
    
}
