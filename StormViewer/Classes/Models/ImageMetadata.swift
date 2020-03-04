//
//  ImageMetadata.swift
//  StormViewer
//
//  Created by Roman Rybachenko on 06.02.2020.
//  Copyright © 2020 Roman Rybachenko. All rights reserved.
//

import Foundation
import Cocoa

struct ImageMetadata {
    let name: String
    let date: Date
    let size: Int64
    let icon: NSImage?
    let url: URL
    
    init?(fileUrl: URL) {
        let url = fileUrl as NSURL
        
        let requiredAttributes = [
            URLResourceKey.localizedNameKey,
            URLResourceKey.effectiveIconKey,
            URLResourceKey.typeIdentifierKey,
            URLResourceKey.contentModificationDateKey,
            URLResourceKey.fileSizeKey,
            URLResourceKey.isDirectoryKey,
            URLResourceKey.isPackageKey
        ]
        
        do {
            let properties = try url.resourceValues(forKeys: requiredAttributes)
            self.name = properties[URLResourceKey.localizedNameKey] as? String ?? ""
            self.date = properties[URLResourceKey.contentModificationDateKey] as? Date ?? Date.distantPast
            self.size = (properties[URLResourceKey.fileSizeKey] as? NSNumber)?.int64Value ?? 0
            self.icon = properties[URLResourceKey.effectiveIconKey] as? NSImage
            self.url = fileUrl
        } catch let error {
            pl("error reading file attributes is: \n\(error)")
            return nil
        }
    }
    
}
