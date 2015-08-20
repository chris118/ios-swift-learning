//
//  ViewController6.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/8/2.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

//strong reference
class Person{
    var name:String
    
    init(name: String){
        self.name = name;
        println("Person init is invoked")
    }
    
    deinit{
        println("Person deInit is invoked")
    }
}

class People {
    var name:String
    
    init(name: String){
        self.name = name;
        println("People init is invoked")
    }
    
    deinit{
        println("People deInit is invoked")
    }
    
    var dept: Department?
}

class Department {
    var number:Int
    
    init(number: Int){
        self.number = number;
        println("Department init is invoked")
    }
    
    deinit{
        println("Department deInit is invoked")
    }
    
    var roomer: People?
}

class PeopleEx {
    var name:String
    
    init(name: String){
        self.name = name;
        println("PeopleEx init is invoked")
    }
    
    deinit{
        println("PeopleEx deInit is invoked")
    }
    
    var dept: DepartmentEx? //默认是强引用
}

class DepartmentEx {
    var number:Int
    
    init(number: Int){
        self.number = number;
        println("DepartmentEx init is invoked")
    }
    
    deinit{
        println("DepartmentEx deInit is invoked")
    }
    
    weak var roomer: PeopleEx? // 弱引用 打破引用环 弱引用要定义给可选类型 实例被销毁的时候,ARC 将引用赋值为 nil。
}

class Customer {
    
    var name: String
    var card: CreditCard? //强引用 可选
    
    init(name: String){
        self.name = name
        println("Customer init is invoked")
    }
    
    deinit{
        println("Customer deinit is invoked")
    }
}

class CreditCard {
    var number: Int
    var customer: Customer //强引用
    
    init(number: Int, customer: Customer){
        self.number = number
        self.customer = customer
        println("CreditCard init is invoked")
    }
    
    deinit{
        println("CreditCard deinit is invoked")
    }
}

class CustomerEx {
    
    var name: String
    var card: CreditCardEx? //强引用 可选
    
    init(name: String){
        self.name = name
        println("CustomerEx init is invoked")
    }
    
    deinit{
        println("CustomerEx deinit is invoked")
    }
}

class CreditCardEx {
    var number: Int
    unowned var customer: CustomerEx //强引用
    
    init(number: Int, customer: CustomerEx){
        self.number = number
        self.customer = customer
        println("CreditCardEx init is invoked")
    }
    
    deinit{
        println("CreditCardEx deinit is invoked")
    }
}

//闭包产生的强引用环
class HTMLElement{
    let name: String
    var text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text{
            return "<\(self.name)> \(self.text) </\(self.name)>"
        }
        else{
            return "<\(self.name) />"
        }
        
    }
    
    init(name: String, text:String? = nil){
        self.name = name
        self.text = text
    }
    
    deinit{
        println("\(name) is being deinitialized")
    }
}

class HTMLElementEx{
    let name: String
    var text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in  //****  设置self为无主引用 打破引用环
        if let text = self.text{
            return "<\(self.name)> \(self.text) </\(self.name)>"
        }
        else{
            return "<\(self.name) />"
        }
        
    }
    
    init(name: String, text:String? = nil){
        self.name = name
        self.text = text
    }
    
    deinit{
        println("\(name) is being deinitialized")
    }
}

class ViewController6: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StrongFunc()
        
        StrongReferenceLoop()
        
        WeakReference()
        
        NO_UnownedReference()
        
        UnownedReference()
        
        ClosureStrongLoopFunc()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func StrongFunc(){
        // 构造函数不会被调用 只是声明 没有实例华
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        //构造函数被调用
        reference1 = Person(name: "Mike") //Person init is invoked
        reference2 = reference1
        reference3 = reference1
        
        //析构函数不会调用 person实例还有被引用
        reference1 = nil
        reference2 = nil
        
        //引用计数为0 析构函数被调用
        reference3 = nil //Person deInit is invoked
        
    }
    
    //类实例间的强引用环
    func StrongReferenceLoop(){
        
        var dept: Department?
        var people: People?
        
        dept = Department(number: 80)
        people = People(name: "John")
        
        dept?.roomer = people
        people?.dept = dept
        
        people = nil
        dept = nil
        
        //这里产生循环引用， 有内存泄漏
    
    }
    
    //类实例间的弱引用环 解决强引用环问题
    func WeakReference(){
        
        var dept: DepartmentEx?
        var people: PeopleEx?
        
        dept = DepartmentEx(number: 80)
        people = PeopleEx(name: "John")
        
        dept?.roomer = people
        people?.dept = dept
        
        people = nil
        dept = nil
        
        //这里没有内存泄漏 2个实例都被析构
    }
    
    //没有添加 unowned 无主引用
    func NO_UnownedReference(){
        
        var customer: Customer?
        
        customer = Customer(name: "Leo")
        
        var card: CreditCard = CreditCard(number: 123, customer: customer!)
        
        customer?.card = card // 产生强引用环
        
        customer = nil //这里如果不是强引用， 成员card也应该被释放
    }
    
    //没有添加 unowned 无主引用
    func UnownedReference(){
        
        var customer: CustomerEx?
        
        customer = CustomerEx(name: "jack")
        
        var card: CreditCardEx = CreditCardEx(number: 123, customer: customer!)
        
        customer?.card = card // 无主引用 不会产生强引用环
        
        customer = nil //customer 和 card都会被析构
    }
    
    //闭包产生的强引用环
    func ClosureStrongLoopFunc(){
        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
        println(paragraph?.asHTML())
        
        paragraph = nil
        
        //产生循环饮用  析构函数没有被调用
        
        
        var paragraphEx: HTMLElementEx? = HTMLElementEx(name: "p", text: "hello, world")
        println(paragraphEx?.asHTML())
        
        paragraphEx = nil
        
        //不会产生循环饮用  析构函数被调用
    }
    



}
