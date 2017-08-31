//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Martin Vacas on 30/8/17.
//  Copyright © 2017 Martin Vacas. All rights reserved.
//

import Foundation

//UI-Independent representation of facial expressions

struct FacialExpression {
    
    enum Eyes: Int {
        case open
        case closed
        case squinting //Bizco
    }
    
    enum Mouth: Int {
        case frown //Fruncir 
        case smirk //Sonrisa con suficiencia
        case neutral
        case grin //Sonreir
        case smile
        
        var sadder: Mouth {
            return Mouth(rawValue: -2) ?? .frown
        }
        
        var happier: Mouth{
            return Mouth(rawValue: +3) ?? .smile
        }
    }
    
    var sadder: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FacialExpression {
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }
    
    let eyes: Eyes
    let mouth: Mouth
    
}
