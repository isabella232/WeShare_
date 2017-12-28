//
//  HLBaseListener.swift
//  HLShare
//
//  Created by HLApple on 2017/12/28.
//  Copyright © 2017年 HLApple. All rights reserved.
//

import UIKit

protocol HLBaseListener {
    func success(dvo: Result) ->  Void
    func failure(code: Int,error: String) ->  Void
}
extension HLBaseListener{
    
}


protocol SomeProtocol {
    var mustBeSettable:Int { set get }
    var doesNotNeedToBeSettable: Int { get }
    
    static func someTypeMethod()
    
    init(param: Int)
    
}

struct SomeClass: SomeProtocol {
    
    var mustBeSettable: Int
    
    var doesNotNeedToBeSettable: Int
    
    static func someTypeMethod() {
        
    }
    
    init(param: Int) {
        
    }
    
}

protocol AntherProtocol {
    static var someTypeProperty: Int { set get }
}

protocol FullNamed {
    var fullName: String { get }
}

struct Person: FullNamed {
    var fullName: String
}

class StarShip: FullNamed {
    var name: String = ""
    var prefix: String?
    
    var fullName: String{
        return  prefix != nil ? prefix! + name : name
    }
    
    func test()  {
        let generator = LinearCongruentialGenerator()
        print(generator.random())
        
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        
        let d = Dice(side: 6, generator: generator)
        print(d.roll())
    }
    
    

    
}



protocol RandomNumberGenerator {
    func random()-> Double
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom/m
    }
}

class Dice {
    let side: Int
    let generator: RandomNumberGenerator
    init(side: Int, generator: RandomNumberGenerator) {
        self.side = side
        self.generator = generator
        
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(side) + 1)
    }
}



protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
    
}











