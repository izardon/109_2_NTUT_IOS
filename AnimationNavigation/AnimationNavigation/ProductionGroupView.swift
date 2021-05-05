//
//  ProductionGroupView.swift
//  AnimationNavigation
//
//  Created by 詹昆宬 on 2021/5/5.
//

import SwiftUI

struct ProductionGroupView: View {
    var body: some View {
        let staff = [ "STAFF 原作：稲垣理一郎、Boichi", "監督：飯野慎也 系列構成", "脚本：木戸雄一郎", "角色設計：岩佐裕子", "美術設定：青木智由紀", "美術監督：吉原俊一郎", "色彩設計：中尾総子", "撮影監督：葛山剛士", "編集：坂本久美子", "音響監督：明田"]
        VStack {
            ForEach(0..<staff.count) { index in
                Text(staff[index])
            }
        }.navigationTitle("製作組")
    }
}

struct ProductionGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ProductionGroupView()
    }
}
