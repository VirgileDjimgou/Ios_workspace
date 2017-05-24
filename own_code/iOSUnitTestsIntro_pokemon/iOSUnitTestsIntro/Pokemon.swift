//
//  Pokemon.swift
//  iOSUnitTestsIntro
//
//  Created by Mac OS on 24.05.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//
import Foundation

class Pokemon{
    
    var type:PokemonType
    var attackType:PokemonAttackType
    var health:Int = 100
    
    init(type:PokemonType, attackType:PokemonAttackType){
        self.type = type
        self.attackType = attackType
    }
    
    func attack(_ enemy:Pokemon){
    
        var damage = 30
        
        if enemy.type == .fire && attackType == .water{
            damage = 60
        }
        
        if enemy.type == .water && attackType == .fire{
            damage = 10
        }
        
        enemy.health = enemy.health - damage
    
    }
    
    
}

enum PokemonType{
    case neutral
    case fire
    case water
}

enum PokemonAttackType{
    case normal
    case fire
    case water
}
