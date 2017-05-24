//
//  PokemonTests.swift
//  iOSUnitTestsIntro
//
//  Created by Mac OS on 24.05.17.
//  Copyright © 2017 Djimgou Patrick. All rights reserved.
//
import XCTest
@testable import iOSUnitTestsIntro

class PokemonTests: XCTestCase {

    var squirtle:Pokemon!
    var charmander:Pokemon!
    var psyduck:Pokemon!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        squirtle = Pokemon(type: .water, attackType: .water)
        charmander = Pokemon(type: .fire, attackType: .fire)
        psyduck = Pokemon(type: .water, attackType: .water)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        squirtle = nil
        charmander = nil
        psyduck = nil
    }

    func testThatAWaterPokemonDoesMoreDamageToAFirePokemon(){
        
        //1. Have Squirtle Attack Charmander
        squirtle.attack(charmander)
        
        //Ouch!
        
        //2. Now Have Squirtle Attack Psyduck
        squirtle.attack(psyduck)
        
        //Oooh. That had to hurt.
        
        //Who took more damage? Charmander or Psyduck?
        
        //If a Water Pokemon Does More Damage To A Fire Pokemon,
        //We would expect Charmander to have less health than Psyduck.
        
        //3. Test it
        XCTAssertTrue(charmander.health < psyduck.health)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
