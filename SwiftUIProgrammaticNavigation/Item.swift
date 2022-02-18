/*
    Item.swift
    SwiftUIProgrammaticNavigation

    Created by Jeff Spooner on 2022-02-16.

    Item is a simple model struct, containing a UUID and a name String.
*/

import Foundation
import SwiftUI


struct Item: Identifiable
  {
    let id: UUID
    var name: String


    init(name: String)
      {
        self.id = UUID()
        self.name = name
      }
  }

