//
//  ContentView.swift
//  NavigationStack2
//
//  Created by Gonzalo Castro on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var path: [Int] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List {
                    Section(header: Text("Section A")) {
                        NavigationLink("One", value: 1)
                        NavigationLink("Two", value: 2)
                        NavigationLink("Three", value: 3)
                    }
                    Section(header: Text("Section B")) {
                        NavigationLink("Four", value: 4)
                        NavigationLink("Five", value: 5)
                        NavigationLink("Six", value: 6)
                    }
                    Button("Go to Five") {
                        path.append(5)
                    }
                }
                .navigationDestination(for: Int.self, destination: { num in
                    if num % 2 == 0 {
                        EvenDetail(path: $path, num: num)
                    } else {
                        OddDetail(path: $path, num: num)
                    }
                })
            }
        }
    }
}

struct EvenDetail: View {
    @Binding var path: [Int]
    let num: Int
    
    var body: some View {
        Button("\(num) is even") {
            path.removeLast()
        }
    }
}

struct OddDetail: View {
    @Binding var path: [Int]
    let num: Int
    
    var body: some View {
        Button("\(num) is odd") {
            path.removeLast()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
