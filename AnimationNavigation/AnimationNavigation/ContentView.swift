//
//  ContentView.swift
//  AnimationNavigation
//
//  Created by 詹昆宬 on 2021/5/5.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("DrStone")
                
                NavigationLink(
                    destination: ProductionGroupView(),
                    label: {
                        Text("製作組")
                    })
                
                NavigationLink(
                    destination: DescriptionView(),
                    label: {
                        Text("作品簡介")
                    })
            }.navigationTitle("新石紀")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
