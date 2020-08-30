//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by Abdelrahman Mohamed on 30.08.2020.
//  Copyright © 2020 Abdelrahman Mohamed. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var progress: CGFloat = 0.0
    
    @State private var isDotIndicatorLoading = false
    @State private var isRoundedRectanglesLoading = false
    
    @State private var isOverlayLoading = false
    @State private var isLoading = false
    
    @State private var pinkCircleColorChanged = false
    @State private var pinkHeartColorChanged = false
    @State private var pinkHeartSizeChanged = false
    
    @State private var yellowCircleColorChanged = false
    @State private var yellowHeartColorChanged = false
    @State private var yellowHeartSizeChanged = false
    
    @State private var redCircleColorChanged = false
    @State private var redHeartColorChanged = false
    @State private var redHeartSizeChanged = false
    
    var body: some View {
        
        VStack(spacing: 50) {
            
            Group {
                
                ZStack {
                    
                    Text("\(Int(progress * 100))%")
                        .font(.system(Font.TextStyle.title, design: Font.Design.rounded))
                        .bold()
                    
                    Circle()
                        .stroke(Color(.systemGray5), lineWidth: 10)
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.green, lineWidth: 10)
                        .frame(width: 200, height: 200)
                        .rotationEffect(Angle(degrees: -90))
                }
                .onAppear() {
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        self.progress += 0.01
                        print(self.progress)
                        if self.progress >= 1.0 {
//                            timer.invalidate()
                            self.progress = 0
                        }
                    }
                }
            }
            
            VStack(spacing: 50) {
                
                HStack(spacing: 50) {
                    
                    HStack {
                            
                        ForEach(0...4, id: \.self) { index in
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.pink)
                                .scaleEffect(self.isDotIndicatorLoading ? 1 : 0)
                                .animation(Animation.linear(duration: 1.0).repeatForever())
                        }
                    }
                    .onAppear() {
                        
                        self.isDotIndicatorLoading = true
                    }
                    
                    HStack {
                            
                        ForEach(0...4, id: \.self) { index in
                            
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.green)
                                .scaleEffect(self.isDotIndicatorLoading ? 1 : 0)
                                .animation(Animation.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)))
                        }
                    }
                    .onAppear() {
                        
                        self.isDotIndicatorLoading = true
                    }
                }
                
                ZStack {
                    
                    Text("Loading")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .offset(x: 0, y: -25)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(.systemGray5), lineWidth: 3)
                        .frame(width: 250, height: 3)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.green, lineWidth: 3)
                        .frame(width: 50, height: 3)
                        .offset(x: isRoundedRectanglesLoading ? 110 : -110, y: 0)
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .onAppear() {
                            self.isRoundedRectanglesLoading = true
                        }
                }
            }
            
            HStack(spacing: 20) {
                
                ZStack {
                    
                    Circle()
                        .stroke(Color(.systemGray5), lineWidth: 14)
                        .frame(width: 100, height: 100)
                    
                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color.orange, lineWidth: 7)
                        .frame(width: 100, height: 100)
                        .rotationEffect(Angle(degrees: isOverlayLoading ? 360: 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .onAppear() {
                            self.isOverlayLoading = true
                        }
                }
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.orange, lineWidth: 5)
                    .frame(width: 100, height: 100)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
//                    .animation(Animation.default.repeatForever(autoreverses: false))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.isLoading = true
                    }
            }
            
            HStack {
                
                ZStack {
                    
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(pinkCircleColorChanged ? Color(.systemGray5) : .pink)
                        .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(pinkHeartColorChanged ? .pink : .white)
                        .font(.system(size: 50))
                        .animation(nil) // Cancel the animation from here
                        .scaleEffect(pinkHeartSizeChanged ? 1.0 : 0.5)
                        .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                }
                .onTapGesture {
                    self.pinkCircleColorChanged.toggle()
                    self.pinkHeartColorChanged.toggle()
                    self.pinkHeartSizeChanged.toggle()
                }
                
                ZStack {
                    
                    // Explicit Animations
                    
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(yellowCircleColorChanged ? Color(.systemGray5) : .yellow)
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(yellowHeartColorChanged ? .yellow : .white)
                        .font(.system(size: 50))
                        .scaleEffect(yellowHeartSizeChanged ? 1.0 : 0.5)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)) {
                        self.yellowCircleColorChanged.toggle()
                        self.yellowHeartColorChanged.toggle()
                    }
                    self.yellowHeartSizeChanged.toggle()
                    //                withAnimation(.default) {
                    //                    self.yellowCircleColorChanged.toggle()
                    //                    self.yellowHeartColorChanged.toggle()
                    //                    self.yellowHeartSizeChanged.toggle()
                    //                }
                }
                
                ZStack {
                    
                    // Implicit Animations
                    
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(redCircleColorChanged ? Color(.systemGray5) : .red)
                    
                    Image(systemName: "heart.fill")
                        .foregroundColor(redHeartColorChanged ? .red : .white)
                        .font(.system(size: 50))
                        .scaleEffect(redHeartSizeChanged ? 1.0 : 0.5)
                }
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
                .onTapGesture {
                    self.redCircleColorChanged.toggle()
                    self.redHeartColorChanged.toggle()
                    self.redHeartSizeChanged.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
