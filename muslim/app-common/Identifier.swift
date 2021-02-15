//
//  Identifier.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation

enum Identifier {
    public enum InfoPlist: String {
        case NSLocationUsageDescription
        case NSLocationAlwaysUsageDescription
        case NSLocationWhenInUseUsageDescription
        case NSLocationAlwaysAndWhenInUseUsageDescription
    }
    
    public enum ImageName: String {
        // MARK: - Assets Image
        case image_background_1
        case image_background_2
        case image_compass_1
        case image_qibla_direction_1
        case image_paper_navy
        
        // MARK: - Assets Button
        case btn_info
    }
    
    public enum soundName: String {
        // MARK: - Adhan
        case adhan_fajr_1
        case adhan_mecca_1
    }
}

typealias IImageName = Identifier.ImageName
