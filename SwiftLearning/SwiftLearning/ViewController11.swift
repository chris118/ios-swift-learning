//
//  ViewController11.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/24.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

class ViewController11: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         //类型参数
        var a = "aaa"
        var b = "bbb"
        swapToValues(&a, &b)
        
        println("after invoke swapToValues: a = \(a) b = \(b)")
        
        
        //泛型类型
        var stack = Stack<String>()
        stack.push("one")
        stack.push("two")
        stack.push("three")
        
        for s in stack.items{
            println(s)
        }
        
        println("after pop")
        stack.pop()
        
        for s in stack.items{
            println(s)
        }
        
        
        //类型约束行为
        var strArr = ["aaa", "bbb", "ccc"]
        var str = "bbb"
        var tmp = "fff"
        
        if var index = findIndex(strArr, str){
            
            println("index = \(index)")
        }
        
        if var index = findIndex(strArr, tmp){
            
             println("index = \(index)")
        }
        
        
        //关联类型行为
        var stackOfStrings = StackEx<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        
        var arrayOfStrings = ["uno", "dos", "tres"]
        
        if allItemsMatch(stackOfStrings, arrayOfStrings) {
            println("All items match.")
        } else {
            println("Not all items match.")
        }
        // prints "All items match."
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//类型参数
func swapToValues<T>(inout a: T, inout b: T){
    var temp = a
    a = b
    b = temp
}

//泛型类型
struct Stack<T> {
    var items = [T]()
    
    mutating func push(item: T){
        items.append(item)
    }
    
    mutating func pop(){
        items.removeLast()
    }
}

//类型约束行为, Equatable为约束
//Swift 标准库中定义了一个 Equatable 协议, 该协议要求任何遵循的类型实现等式符(==)和不等符(! =)对任何两个该类型进行比 较。

// 否则任意类型T可能不支持 == 编译错误
func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


//关联类型行为
protocol Container{
    typealias ItemType
    
    mutating func append(item: ItemType)
    
    var count: Int { get }
    
    subscript(i: Int) -> ItemType{ get }
}

struct StackEx<T>: Container {
    
    var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    //// conformance to the Container protocol
    mutating func append(item: T) {
        items.append(item)
    }
    
    subscript(i: Int) -> T{
        return items[i]
    }
    
    var count: Int{
    
        get{
            return items.count
        }
    }
}

//扩展一个存在的类型为一指定关联类型

/*
Swift 的 Array 已经􏰀供 append 方法,一个 count 属性和通过下标来查找一个自己的元 素。这三个功能都达到 Container 协议的要求。也就意味着你可以扩展 Array 去遵循
Container 协议,只要通过简单声明 Array 适用于该协议而已
*/
extension Array: Container {}


//Where 语句
func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
        
        // check that both containers contain the same number of items
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // check each pair of items to see if they are equivalent
        for i in 0...someContainer.count - 1 {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // all items match, so return true
        return true
        
}

