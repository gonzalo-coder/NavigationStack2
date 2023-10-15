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

struct Settings: Hashable {
    var showNumbersSection: Bool
    var showMoviesSection: Bool
}

struct ContentView: View {
    @State private var path = NavigationPath()
    @State var settings = Settings(showNumbersSection: true, showMoviesSection: true)
    var body: some View {
        NavigationStack(path: $path) {
            List {
                if settings.showNumbersSection {
                    Section(header: Text("Numbers")) {
                        NavigationLink("One", value: 1)
                        NavigationLink("Two", value: 2)
                        NavigationLink("Three", value: 3)
                        NavigationLink("Four", value: 4)
                        NavigationLink("Five", value: 5)
                        NavigationLink("Six", value: 6)
                    }
                }
                if settings.showMoviesSection {
                    Section(header: Text("Movies")) {
                        ForEach(movies, id: \.self) { movie in
                            NavigationLink(movie.title, value: movie)
                        }
                    }
                }
                Button("Random Movie") {
                    if let r = movies.randomElement() {
                        path.append(r)
                    }
                }
            }
            .navigationTitle("Main")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(value: settings,
                                   label: { Image(systemName: "gearshape") })
                }
            }
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
                    .navigationTitle("Movie Detail")
                    .navigationBarTitleDisplayMode(.inline)
            })
            .navigationDestination(for: Settings.self, destination: { settings in
                SettingsDetail(settings: $settings)
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
            })
        }
    }
}

struct SettingsDetail: View {
    @Binding var settings: Settings
    
    var body: some View {
        VStack {
            Toggle(isOn: $settings.showNumbersSection) {
                Text("Show Numbers Section")
            }
            Toggle(isOn: $settings.showMoviesSection) {
                Text("Show Movies Section")
            }
        }
        .padding(.horizontal, 40)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
