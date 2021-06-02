//
//  RoemischeZahlApp.swift
//  Shared
//
//  Created by Miho on 2021/04/29.
//

import SwiftUI

@main
struct RoemischeZahlApp: App {
    
    @State private var presentingCamera = false
        
    
    var cameraView:some View{
        
        let c=CameraView()
            .toolbar {
                ToolbarItem(placement: .cancellationAction, content: {
                    Button(action: {
                        presentingCamera=false
                    }, label: {
                        Text("Dismiss")
                        
                    })
                })
            }
        #if os(macOS)
        return c
        #else
        return NavigationView(content: {
            c.navigationBarTitleDisplayMode(.inline)
        })
        #endif
    }
    
    var textInputView:some View{
        ContentView()
            .toolbar(content: {
                ToolbarItem(placement: .automatic, content: {
                    Button(action: {
                        presentingCamera=true
                    }, label: {
                        Image(systemName: "camera")
                    })
                })
            })
    }
    
    @ViewBuilder func makeTextInputView()-> some View{
        let t=textInputView
        #if os(macOS)
        t.sheet(isPresented: $presentingCamera, onDismiss: {
            
        }, content: {
            cameraView
        })
        #else
        NavigationView(content: {
            t.fullScreenCover(isPresented: $presentingCamera, onDismiss: {
                
            }, content: {
                cameraView
            })
            .navigationBarTitleDisplayMode(.inline).navigationTitle("Numerals")
        })
        #endif
    }
    
    var windowScene:some Scene{
        let w=WindowGroup{
            makeTextInputView()
        }
        #if os(macOS)
        return w
            .windowToolbarStyle(UnifiedWindowToolbarStyle())
            .windowStyle(HiddenTitleBarWindowStyle())
        #else
        return w
        #endif
    }
        
    
    var body: some Scene {
       windowScene
       

    }
}
