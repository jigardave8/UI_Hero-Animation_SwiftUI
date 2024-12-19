//
//  ContentView.swift
//  UI_Hero-Animation_SwiftUI
//
//  Created by BitDegree on 19/12/24.
//

import SwiftUI

struct HeroAnimationView: View {
    @State private var showDetail = false
    @Namespace private var namespace // Add the namespace here

    var body: some View {
        ZStack {
            if showDetail {
                DetailView(showDetail: $showDetail, namespace: namespace)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            } else {
                ListView(showDetail: $showDetail, namespace: namespace)
                    .transition(.slide)
            }
        }
        .animation(.easeInOut(duration: 0.8), value: showDetail)
    }
}

struct ListView: View {
    @Binding var showDetail: Bool
    var namespace: Namespace.ID // Pass namespace as a parameter

    var body: some View {
        VStack {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        showDetail = true
                    }
                    .matchedGeometryEffect(id: "star\(index)", in: namespace) // Use the namespace
            }
        }
    }
}

struct DetailView: View {
    @Binding var showDetail: Bool
    var namespace: Namespace.ID // Pass namespace as a parameter

    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .matchedGeometryEffect(id: "star", in: namespace) // Use the namespace
            Text("Hero Animation Detail")
                .font(.title)
            Button("Close") {
                showDetail = false
            }
        }
    }
}
