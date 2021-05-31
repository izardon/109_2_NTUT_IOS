//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by 詹昆宬 on 2021/5/30.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
