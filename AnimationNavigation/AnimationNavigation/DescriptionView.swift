//
//  DescriptionView.swift
//  AnimationNavigation
//
//  Created by 詹昆宬 on 2021/5/5.
//

import SwiftUI

struct DescriptionView: View {
    var body: some View {
        VStack {
            Text("　就在高中生大樹決定跟暗戀多年的同學杠告白的那天，一道奇怪的光線照過，瞬間全世界的人類都變成了石頭！一心只想著未完成的心願，讓大樹的心保持著清醒，就這麼度過了數千年。終於石化解除，令他驚訝的是眼前竟然是一排文字，叫他循線過來……大樹找到目的地，看到的竟是早他半年醒來的同學千空，於是大樹決定跟千空聯手，從無到有再度打造出人類的文明。 ")
        }.navigationTitle("作品簡介")
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
    }
}
