//
//  ViewController4.swift
//  SwiftLearning
//
//  Created by 王晓鹏 on 15/7/26.
//  Copyright (c) 2015年 xiaopeng. All rights reserved.
//

import UIKit

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //struct 和基本类型一样 是值类型， 枚举也是值类型
        let hd = Resolution(width:1920, height:1080)
        var four_k = hd
        four_k.width = 3840
        
        println("cinema width:  \(hd.width)")
        println("cinema_copy width:  \(four_k.width)")
        
        
        // 类是 引用类型
        let hd_vm = VideoMode();
        hd_vm.frameRate = 25
        
        let hd_vm_copy = hd_vm
        hd_vm_copy.frameRate = 30
        
        println("hd_vm frameRate:  \(hd_vm.frameRate)")
        println("hd_vm_copy frameRate:  \(hd_vm_copy.frameRate)")
        
        // === 是否引用同一个实例
        if hd_vm === hd_vm_copy {
            println("hd_vm === hd_vm_copy")
        }
        
        
        // 字典的值拷贝
        var dict = ["Peter": 23, "Ketty": 18]
        var dict_copy = dict
        dict_copy["Peter"] = 55
        
        println(dict["Peter"]!)
        println(dict_copy["Peter"])
        
        //数组只有长度发生变化的时候才和字典一样 进行值copy
        //否则是引用
        var a=[1,2,3]
        var b = a
        var c = a
        
        println(a[0])
        println(b[0])
        println(c[0])
        println("---------")
        
        a[0] = 25
        
        println(a[0])
        println(b[0])
        println(c[0])
        println("---------")
        
    }
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
