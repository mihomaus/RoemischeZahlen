//
//  Einer.swift
//  RoemischeZahl
//
//  Created by Morten Bertz on 2021/09/14.
//

import Foundation

struct Einer: AlsRoemischeZahl, AlsArabischeZahl, AlsJapanischeZahl, AlsJapanischeBankZahl, AlsBabylonischeZahl, AlsAegaeischeZahl, AlsSangiZahl, AlsHieroglyphenZahl {
    let anzahl:Int
    let multiplikator:Int = 1
    
    let arabischRömischDict=[0:"",
                             1:"I",
                             2:"II",
                             3:"III",
                             4:"IV",
                             5:"V",
                             6:"VI",
                             7:"VII",
                             8:"VIII",
                             9:"IX"
    ]
    
    let arabischJapanischDict = [0:"",
                                 1:"一",
                                 2:"二",
                                 3:"三",
                                 4:"四",
                                 5:"五",
                                 6:"六",
                                 7:"七",
                                 8:"八",
                                 9:"九",
    ]
    
    let arabischJapanischBankDict: [Int : String] = [0:"",
                                                     1:"壱",
                                                     2:"弐",
                                                     3:"参",
                                                     4:"肆",
                                                     5:"伍",
                                                     6:"陸",
                                                     7:"漆",
                                                     8:"捌",
                                                     9:"玖",
    ]
    
    let arabischJapanischBankDict_einfach: [Int : String] = [0:"",
                                                             1:"壱",
                                                             2:"弐",
                                                             3:"参",
                                                             4:"四",
                                                             5:"五",
                                                             6:"六",
                                                             7:"七",
                                                             8:"八",
                                                             9:"九",
    ]
    
    let arabischBabylonischDict: [Int : String] = [0:" ",
                                                   1:"𒐕",
                                                   2:"𒐖",
                                                   3:"𒐗",
                                                   4:"𒐘",
                                                   5:"𒐙",
                                                   6:"𒐚",
                                                   7:"𒐛",
                                                   8:"𒐜",
                                                   9:"𒐝"
                                                   
    ]
    
    let arabischAegeanDict: [Int : String] = [0:"",
                                              1:"𐄇",
                                              2:"𐄈",
                                              3:"𐄉",
                                              4:"𐄊",
                                              5:"𐄋",
                                              6:"𐄌",
                                              7:"𐄍",
                                              8:"𐄎",
                                              9:"𐄏"
    ]
    
    let arabischSangiDict: [Int : String] = [0:"",
                                             1:"𝍠",
                                             2:"𝍡",
                                             3:"𝍢",
                                             4:"𝍣",
                                             5:"𝍤",
                                             6:"𝍥",
                                             7:"𝍦",
                                             8:"𝍧",
                                             9:"𝍨"
    ]
    
    let arabischHieroglyphenDict: [Int : String] = [0:"",
                                                    1:"𓏺",
                                                    2:"𓏻",
                                                    3:"𓏼",
                                                    4:"𓏽",
                                                    5:"𓏾",
                                                    6:"𓏿",
                                                    7:"𓐀",
                                                    8:"𓐁",
                                                    9:"𓐂"
    ]
    
    
    
    init(Zahl:Int){
        let zehner = Zahl / 10
        let übrigeEinser = Zahl - 10 * zehner
        anzahl = übrigeEinser / multiplikator
    }
    
    init(römischeZahl:String) {
        switch römischeZahl {
        case _ where römischeZahl.range(of: "VIII", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil :
            self.anzahl=8
        case _ where römischeZahl.range(of: "VII", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil :
            self.anzahl=7
        case _ where römischeZahl.range(of: "VI", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil:
            self.anzahl=6
        case _ where römischeZahl.range(of: "IX", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil:
            self.anzahl=9
        case _ where römischeZahl.range(of: "IV", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil:
            self.anzahl=4
        case _ where römischeZahl.range(of: "III", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil:
            self.anzahl=3
        case _ where römischeZahl.range(of: "II", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil:
            self.anzahl=2
        case _ where römischeZahl.range(of: "I", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil:
            self.anzahl=1
        case _ where römischeZahl.range(of: "V", options: [.caseInsensitive, .anchored, .backwards], range: nil, locale: nil) != nil:
            self.anzahl=5
        default:
            self.anzahl=0
        }
    }
    
    init(japanischeZahl:String) {
        let a=[self.arabischJapanischDict,
               self.arabischJapanischBankDict]
            .compactMap {
                $0.sorted(by: {$0.0 > $1.0})
                    .first(where: {_,n in
                        if japanischeZahl.range(of: n, options: [.caseInsensitive, .anchored, .backwards, .widthInsensitive], range: nil, locale: nil) != nil{
                            return true
                        }
                        return false
                    })
            }
        
        self.anzahl=a.first?.key ?? 0
    }
    
    init?(hieroglyph:String){
        if let a=self.arabischHieroglyphenDict
            .first(where: {_,n in
                return n == hieroglyph
            }){
            self.anzahl=a.key * multiplikator
        }
        else{
            return nil
        }
        
    }
    
    init?(aegeanNumber:String){
        if let a=self.arabischAegeanDict
            .first(where: {_,n in
                return n == aegeanNumber
            }){
            self.anzahl=a.key * multiplikator
        }
        else{
            return nil
        }
        
    }
    
    
}
