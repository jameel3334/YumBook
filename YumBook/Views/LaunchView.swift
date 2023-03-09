//
//  LaunchView.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/4/23.
//

import SwiftUI

struct LaunchView: View {
    @State private var splashScreenIsShowing = true
    @State private var bounceLogo = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    private let timer = Timer.publish(every: 0.75, on: .main, in: .common).autoconnect()
    var body: some View {
        if splashScreenIsShowing {
            ZStack {
                LinearGradient(colors: [.cyan, Color(Constants.Color.accentColor).opacity(Constants.General.opacityBackground)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    HStack (spacing: -20) {
                        SpoonView(image: UIImage(named:Constants.Image.leftSpoonAppImage) ?? UIImage (), bounceLogo: bounceLogo, opacity: opacity)
                        Image(Constants.Image.mobileAppImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                            .opacity(opacity)
                    }
                    .scaleEffect(bounceLogo ? 0.8 : 1.0)
                    .onReceive(timer) { input in
                        withAnimation(.spring()) {
                            bounceLogo.toggle()
                        }
                    }
                    CustomHeaderText(text: "👨‍🍳YUM BOOK👩‍🍳")
                        .cornerRadius(12)
                        .scaleEffect(size)
                        .opacity(opacity)
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        self.size = 1.5
                        self.opacity = 1.0
                    }
                    Task {
                        try await Task.sleep(nanoseconds: UInt64(3.2e+9))
                        withAnimation {
                            self.splashScreenIsShowing = false
                        }
                    }
                }
            }
        } else {
            TabViews()
        }
    }
}

struct SpoonView: View {
    let image: UIImage
    let bounceLogo: Bool
    let opacity: Double
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
            .opacity(opacity)
            .scaleEffect(bounceLogo ? 0.8 : 1.0)
            .rotationEffect(.degrees(bounceLogo ? 360 : 0))
    }
}
