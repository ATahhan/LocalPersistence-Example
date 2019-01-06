//
//  Constants.swift
//  PitchPerfect
//
//  Created by Ammar AlTahhan on 29/12/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // TODO: - Create `setThemeStyle(_:)` function that takes a `ThemeStyle` as a parameter and saves it to UserDefaults
    func setThemeStyle(_ value: ThemeStyle) {
        UserDefaults.standard.set(value.rawValue, forKey: Constants.UserDefaults.ThemeStyleIdentifier)
    }
    
    // TODO: - Create `themeStyle()` function that returns the currently saved style in UserDefaults, or a default style if non is saved
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
        static let ThemeStyleIdentifier = "ThemeStyle"
    }
}
