//
//  ViewController.swift
//  FaceIt
//
//  Created by Martin Vacas on 21/8/17.
//  Copyright © 2017 Martin Vacas. All rights reserved.
//

import UIKit

//CONTROLLER
class FaceViewController: UIViewController {

    //VIEW
    @IBOutlet weak var faceView: FaceView! {
        //Property observer
        didSet {
            
            //Handler para el tamaño en la UIView
            let sizeHandler = #selector(FaceView.changeScale(byReactingTo:))
            //Se crea el Gesture Recognizer para captar los gestos y llamar al handler
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: sizeHandler)
            //Se agrega el Recognizer a la vista
            faceView.addGestureRecognizer(pinchRecognizer)
            
            //Ojos
            let eyesHandler = #selector(self.toogleEyes(byReactingTo:))
            let tapRecognizer = UITapGestureRecognizer(target: self, action: eyesHandler)
            faceView.addGestureRecognizer(tapRecognizer)
            
            //Boca - Sonrriendo
            let increaseHappinessHandler = #selector(self.increaseHappiness)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: increaseHappinessHandler)
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            //Boca - Enojado
            let decreaseHappinessHandler = #selector(self.decreaseHappiness)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: decreaseHappinessHandler)
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            updateUI()
        }
    }

    //MODEL
    var expression = FacialExpression(eyes: .closed, mouth: .frown) {
        //Property observer
        didSet {
            updateUI()
        }
    }
    
    //Handler para manejar la apertura y cierre de los ojos con el gesto TAP
    func toogleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    //Handler para manejar la sonrisa
    func increaseHappiness() {
        expression = expression.happier
    }
    
    //Handler para manejar la sonrisa
    func decreaseHappiness() {
        expression = expression.sadder
    }
    
    
    //Actualiza la UI
    private func updateUI() {
       
        //Se hace uso de Optionals Chaining para chequear si faceView no es NIL
        
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        if faceView != nil {
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        }
        
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5,
                                   .frown: -1.0,
                                   .smile: 1.0,
                                   .neutral: 0.0,
                                   .smirk: -0.5]
    
    
}

