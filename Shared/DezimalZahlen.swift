//
//  DezimalZahlen.swift
//  RoemischeZahl
//
//  Created by Morten Bertz on 2021/05/02.
//

import Foundation

protocol AlsRoemischeZahl {
    var anzahl: Int {get}
    var arabischRömischDict: [Int:String] {get}
    var römisch: String {get}
}

extension AlsRoemischeZahl{
    var römisch : String{
        return self.arabischRömischDict[self.anzahl] ?? ""
    }
}

protocol AlsArabischeZahl{
    var arabisch:Int {get}
    var multiplikator: Int {get}
    var anzahl: Int {get}
}

extension AlsArabischeZahl{
    var arabisch:Int{
        return self.anzahl * multiplikator
    }
}

protocol AlsJapanischeZahl {
    var anzahl: Int {get}
    var arabischJapanischDict: [Int:String] {get}
    var japanisch: String {get}
}

extension AlsJapanischeZahl{
    var japanisch:String{
        return self.arabischJapanischDict[self.anzahl] ?? ""
    }
}

protocol AlsJapanischeBankZahl: AlsJapanischeZahl {
    var arabischJapanischBankDict: [Int:String] {get}
    var arabischJapanischBankDict_einfach: [Int:String] {get}
    var japanisch_Bank:String {get}
    var japanisch_Bank_einfach:String {get}
}

extension AlsJapanischeBankZahl{
    var japanisch_Bank:String{
        return self.arabischJapanischBankDict[self.anzahl] ?? ""
    }
    
    var japanisch_Bank_einfach:String{
        return self.arabischJapanischBankDict_einfach[self.anzahl] ?? ""
    }
}
