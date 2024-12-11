//
//  NYTimes_DemoApp.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//

import SwiftUI

@main
struct NYTimes_DemoApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                ContentView()
            }
        }
    }
    
    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
