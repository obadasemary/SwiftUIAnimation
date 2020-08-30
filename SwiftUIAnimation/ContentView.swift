//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by Abdelrahman Mohamed on 30.08.2020.
//  Copyright © 2020 Abdelrahman Mohamed. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
//                .animation(.default)
            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 50))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
//                .animation(.default)
        }
//        .animation(.default)\
            .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
        .onTapGesture {
            self.circleColorChanged.toggle()
            self.heartColorChanged.toggle()
            self.heartSizeChanged.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
