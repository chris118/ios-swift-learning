//
//  ViewController2.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/7/25.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        AllFuncInvoke();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func AllFuncInvoke(){
        
        println(SayHello("world"))
        
        var (one, two, three) = MultiRetrunDemo("YOU")
        println("1, \(one)  2, \(two)  3, \(three)")
        
        println(ConnectWithoutName("H", s2: "W", j: "+"))
        
        println(Connect(first: "H", second: "W", joiner: "+"))
        
        println(ConnectEx(first: "H", second: "W", joiner: "-"))
        
        println(ConnectEx_Ex(first: "H", second: "W"))
        
        println("\(GetAverage(1,2,3,4))")
        
        println(FuncDemo("dd", str2:"ee"))
        
        var i1 = 9
        var i2 = 5
        SwapInt(&i1, two: &i2)
        println("i1 = \(i1)  i2 = \(i2)")
        
        //函数类型
        var funcObj: (Int, Int) -> Int = Add
        println("1+2 = \(funcObj(1, 2))")
        
        //函数类型简化写法
        var funcObjEx = Add
        println("1+2 = \(funcObjEx(1, n2:2))")
        
        //函数类型作为参数
        PrintAdd(funcObj, a: 1, b: 2);
        
        //函数类型作为返回类型
        let retFunc1 = OptionInt(true)
        println("8, 4: this option is : \(retFunc1(8, 4)) ")
        
        let retFunc2 = OptionInt(false)
        println("8, 4: this option is : \(retFunc2(8, 4)) ")
    }
    
    func SayHello(name: String) -> String{
        return "hello \(name)"
    }
    
    func MultiRetrunDemo(name: String) -> (oneC: Character, twoC:Character, threeC:Character){
        var one: Character = "?", two: Character  = "?", three: Character  = "?"
        
        let rangeOfone = Range(start: name.startIndex, end: advance(name.startIndex, 1))
        one = Character(name.substringWithRange(rangeOfone))
      
        let rangeOftow = Range(start: advance(name.startIndex, 1), end: advance(name.startIndex, 2))
        two = Character(name.substringWithRange(rangeOftow))
        
        let rangeOfthree = Range(start: advance(name.startIndex, 2), end: advance(name.startIndex, 3))
        three = Character(name.substringWithRange(rangeOfthree))

        
        return(one, two, three)
    }
    
    //没有外部行参
    func ConnectWithoutName(s1: String, s2: String, j: String) -> String{
        return s1 + j + s2;
    }
    
    //外部行参名
    func Connect(first s1: String, second s2: String, joiner j: String) -> String{
        return s1 + j + s2;
    }
    
    //外部行参简化写法
    func ConnectEx(#first: String, second: String, joiner: String) -> String{
        return first + joiner + second;
    }
    
    //默认行参
    func ConnectEx_Ex(#first: String, second: String, joiner: String = "*") -> String{
        return first + joiner + second;
    }
    
    //可变参数
    func GetAverage(numbers:Double...) -> Double {
        var sum = 0.0;
        for n in numbers {
            sum += n;
        }
        return sum / Double(numbers.count);
    }
    
    //变量行参
    func FuncDemo(var str: String, str2: String) -> String{
        str += str2;
        return str;
    }
    
    //in-out 参数
    func SwapInt(inout one: Int, inout two: Int){
        let temp = one
        one = two
        two = temp
    }
    
    
    
    //函数类型
    func Add(n1: Int, n2: Int) -> Int {
        return n1 + n2
    }
    
    func Subtract(n1: Int, n2: Int) -> Int {
        return n1 - n2
    }
    
    //函数类型作为参数
    func PrintAdd(addFunc: (Int, Int)->Int, a: Int, b: Int){
        println("result: \(addFunc(a, b))")
    }
    
    //函数类型作为返回类型
    func OptionInt(isAdd: Bool) -> (Int, Int)-> Int {
        return isAdd ? Add : Subtract
    }

}
