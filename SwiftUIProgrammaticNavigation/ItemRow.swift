/*
    ItemRow.swift
    SwiftUIProgrammaticNavigation

    Created by Jeff Spooner on 2022-02-16.
*/

import SwiftUI


struct ItemRow: View
  {
    let item: Item


    var body: some View
      {
        Text(item.name)
      }
  }


struct ItemRow_Previews: PreviewProvider
  {
    static var previews: some View
      {
        ItemRow(item: ModelData.defaultItems.first!)
      }
  }
