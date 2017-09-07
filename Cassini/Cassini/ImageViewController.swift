//
//  ImageViewController.swift
//  Cassini
//
//  Created by Martin Vacas on 6/9/17.
//  Copyright © 2017 Martin Vacas. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    // MODEL
    var imageURL: URL? {
        didSet {
            image = nil
            // Si estamos en la pantalla recuperamos la Imagen
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    // Private Implementation
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                
                //Se convierte la respuesta en un Optional
                let urlContent = try? Data(contentsOf: url)
                if let imageData = urlContent {
                    DispatchQueue.main.async {
                        //Deberia ocurrir en el Main Queue
                        self?.image = UIImage(data: imageData)
                    }
                }
            
            }
        }
    }
    
    //Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    //Scroll View
    @IBOutlet weak var imageScrollView: UIScrollView! {
        didSet {
            imageScrollView.delegate = self
            imageScrollView.minimumZoomScale = 0.05
            imageScrollView.maximumZoomScale = 1.5
            imageScrollView.contentSize = imageView.frame.size
            imageScrollView.addSubview(imageView)
        }
    }
    
    //VIEW
    fileprivate var imageView = UIImageView()
    
    //Computed variable
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            imageScrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}

//Se hace una extension de ImageViewController para que implemente UIScrollViewDelegate Protocol
extension ImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
