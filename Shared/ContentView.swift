//
//  ContentView.swift
//  Shared
//
//  Created by Miho on 2021/04/29.
//

import SwiftUI

enum Output: String, CaseIterable, Identifiable{
    case römisch
    case japanisch
    case arabisch
    
    var id: String { self.rawValue }
}


struct ContentView: View {
    
    @State var input:String = ""
    @State var output:String = ""
    
    @State var outputMode:Output = Output.römisch
    
    let formatter=RömischeZahl()
    
    var textField:some View{
        let t=TextField(LocalizedStringKey("Number"), text: $input, onEditingChanged: {_ in}, onCommit: {
            
            if let zahl = Int(input){
                switch outputMode {
                case .römisch:
                    output = formatter.macheRömischeZahl(aus: zahl) ?? ""
                case .japanisch:
                    output = formatter.macheJapanischeZahl(aus: zahl) ?? ""
                case .arabisch:
                    output = input
                }
                
            }
            else if let arabisch = formatter.macheZahl(aus: input){
                output = String(arabisch)
            }
            else{
                output = ""
            }
            
        }).frame(minWidth: nil, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: 100, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: nil, maxHeight: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        
        #if os(macOS)
            return t
        #else
        return t.keyboardType(.numberPad)
        #endif
    }
    
    
    var body: some View {
        ZStack(content: {
            
            VStack(alignment: .center, spacing: 5, content: {
                Picker("Output", selection: $outputMode, content: {
                    Text("Römisch").tag(Output.römisch)
                    Text("Japanisch").tag(Output.japanisch)
                }).pickerStyle(InlinePickerStyle())
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    textField
                }).padding()
                HStack(content: {
                    Text(output).multilineTextAlignment(.center)
                    .lineLimit(1)
                        .fixedSize()
                        .frame(minWidth: 100, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: nil, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .center)
                        .padding()
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                #if os(macOS)
                                    NSPasteboard.general.declareTypes([.string], owner: nil)
                                    NSPasteboard.general.setString(output, forType: .string)
                                #else
                                    UIPasteboard.general.string=output
                                #endif
                            }, label: {
                                Text("Copy")
                            })
                            .help(Text("Speak"))
                            
                        }))
                    Button(action: {
                        if Int(output) != nil{
                            formatter.speak(input: input, output: output, format: .arabisch)
                        }
                        else{
                            formatter.speak(input: input, output: output, format: outputMode)
                        }
                        
                    }, label: {
                        Image(systemName: "play.rectangle.fill")
                    }).keyboardShortcut(KeyEquivalent("s"), modifiers: [.command,.option])
                })
                .padding(.horizontal)
                
                
            })
            .padding(.top)
            
            
        })
        Spacer()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
