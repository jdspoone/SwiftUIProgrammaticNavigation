/*
  SwiftUIProgrammaticNavigationApp.swift
  SwiftUIProgrammaticNavigation

  Created by Jeff Spooner on 2022-02-16.

  The App struct maintains a list of Items as a State variable,
  which is passed down the view hierarchy.
*/

import SwiftUI


@main
struct SwiftUIProgrammaticNavigationApp: App
  {
    @State private var items = ModelData.defaultItems

    var body: some Scene
      {
        WindowGroup
          {
            ContentView(items: $items)
          }
      }
  }
