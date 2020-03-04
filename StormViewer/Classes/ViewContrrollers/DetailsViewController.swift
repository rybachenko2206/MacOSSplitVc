//
//  DetailsViewController.swift
//  StormViewer
//
//  Created by Roman Rybachenko on 03.02.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//


import Cocoa


class DetailsViewController: NSViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: NSImageView!
    
    
    
    // MARK: - Properties
    
    var selectedImage: ImageMetadata? {
        didSet {
            guard let imgMetadata = selectedImage else { return }
            imageView.image =  NSImage(byReferencing: imgMetadata.url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
