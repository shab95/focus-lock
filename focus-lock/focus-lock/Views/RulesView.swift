//
//  RulesView.swift
//  
//
//  Created by Suraj Modur on 1/11/26.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 100) {
            Text("Rules").font(.title)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment:.leading, spacing: 16) {
                    Text("Rule 1: Instagram").font(.title2).bold()
                    Text("Time Limit: 10 minutes")
                    Divider()
                    
                    Text("Rule 2: TikTok") .font(.title2).bold()
                    Text("Time Limit: 5 minutes")
                    
                }
            }
        }.padding(20)
    }
}

#Preview {
    RulesView()
}
