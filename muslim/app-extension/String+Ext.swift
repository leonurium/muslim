//
//  String+Ext.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import UIKit

extension String {
    func hexToUIColor(alpha: Double = 1.0) -> UIColor {
        var cString = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#"){
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat ((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    func addEndOfAyah(number: Int?) -> String {
        var endOfAyah = ""
        if let num = number,
           let numStr = getArabicDigitFor(value: num) {
            endOfAyah.append(" ")
            endOfAyah.append(CCQuran.end_of_ayah_1st.rawValue)
            endOfAyah.append(numStr)
            endOfAyah.append(CCQuran.end_of_ayah_2nd.rawValue)
            endOfAyah.append(" ")
            return self + endOfAyah
        
        } else {
            endOfAyah.append(CCQuran.end_of_ayah.rawValue)
            return self + endOfAyah
        }
    }
    
    func getArabicDigitFor(value:Int) -> String? {
        let numberToConvert = NSNumber(value: value)
        let formatter = NumberFormatter()
        let arLocale = Locale(identifier: "ar")
        formatter.locale = arLocale
        return formatter.string(from: numberToConvert)
    }
}
