//
//  Constants.swift
//  PitchPerfect
//
//  Created by Ammar AlTahhan on 29/12/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setThemeStyle(_ value: ThemeStyle) {
        UserDefaults.standard.set(value.rawValue, forKey: Constants.UserDefaults.ThemeStyleIdentifier)
    }
    
    func themeStyle() -> ThemeStyle {
        if let savedStyle = UserDefaults.standard.string(forKey: Constants.UserDefaults.ThemeStyleIdentifier),
            let themeStyle = ThemeStyle(rawValue: savedStyle) {
            return themeStyle
        }
        
        // Default theme
        return .light
    }
    
}

struct Constants {
    struct Files {
        /// Recommended extension first
        static let Extenstions = ["wav"]
        static let Directories = [
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        ]
    }
    
    struct UserDefaults {
        /// UserDefaults Ids
        static let ThemeStyleIdentifier = "ThemeStyle"
    }
}
