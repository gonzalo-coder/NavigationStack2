//
//  ContentView.swift
//  NavigationStack2
//
//  Created by Gonzalo Castro on 9/19/23.
//

import SwiftUI

struct Movie: Hashable {
    let title: String
    let rating: Int
    let watched: Bool
}

let movies = [Movie(title: "Toy Story", rating: 5, watched: true),
              Movie(title: "Monsters Inc", rating: 4, watched: true),
              Movie(title: "The Incredibles", rating: 5, watched: true),
              Movie(title: "Cars", rating: 3, watched: true),
              Movie(title: "Ratatouille", rating: 3, watched: true),
              Movie(title: "Up", rating: 4, watched: true),
              Movie(title: "WALL-E", rating: 4, watched: true)]

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section(header: Text("Section A")) {
                    NavigationLink("One", value: 1)
                    NavigationLink("Two", value: 2)
                    NavigationLink("Three", value: 3)
                    NavigationLink("Four", value: 4)
                    NavigationLink("Five", value: 5)
                    NavigationLink("Six", value: 6)
                }
                Section(header: Text("Movies")) {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink(movie.title, value: movie)
                    }
                }
                Button("Random Movie") {
                    if let r = movies.randomElement() {
                        path.append(r)
                    }
                }
            }
            .navigationTitle("NavigationStack")
            .navigationDestination(for: Int.self, destination: { num in
                if num % 2 == 0 {
                    EvenDetail(path: $path, num: num)
                        .navigationTitle("Even Detail")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    OddDetail(path: $path, num: num)
                        .navigationTitle("Odd Detail")
                        .navigationBarTitleDisplayMode(.inline)
                }
            })
            .navigationDestination(for: Movie.self, destination: { model in
                MovieDetail(model: model)
            })
        }
    }
}

struct EvenDetail: View {
    @Binding var path: NavigationPath
    let num: Int
    
    var body: some View {
        Button("\(num) is even") {
            path.removeLast()
        }
    }
}

struct OddDetail: View {
    @Binding var path: NavigationPath
    let num: Int
    
    var body: some View {
        Button("\(num) is odd") {
            path.removeLast()
        }
    }
}

struct MovieDetail: View {
    let model: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title: \(model.title)")
            Text("Rating: \(model.rating)")
            Text("Watched: \(model.watched ? "Yes" : "No")")
        }
        .navigationTitle("Movie Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
