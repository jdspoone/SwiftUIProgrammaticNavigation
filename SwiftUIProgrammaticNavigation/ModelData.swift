/*
    ModelData.swift
    SwiftUIProgrammaticNavigation

    Created by Jeff Spooner on 2022-02-16.
*/

import Foundation

final class ModelData: ObservableObject
  {
    static let defaultItems: [Item] = [
      .init(name: "Item 1"),
      .init(name: "Item 2"),
      .init(name: "Item 3")
    ]
  }
