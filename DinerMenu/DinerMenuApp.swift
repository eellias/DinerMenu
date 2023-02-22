//
//  DinerMenuApp.swift
//  DinerMenu
//
//  Created by Ilya Tovstokory on 20.02.2023.
//

import SwiftUI

@main
struct DinerMenuApp: App {
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
