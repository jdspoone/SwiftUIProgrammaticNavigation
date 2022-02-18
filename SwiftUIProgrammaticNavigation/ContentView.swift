/*
    ContentView.swift
    SwiftUIProgrammaticNavigation

    Created by Jeff Spooner on 2022-02-16.

    The ContentView is initialized with a list of Items as a Binding,
    and creates a list of draft Items from this as a State variable.

    The ContentView also maintains an isEditing flag as a State variable,
    between this and the list of items and draft items, a nice clean solution
    for editing can be achieved.

    The ContentView presents the ItemList View within a NavigationView, and
    configures a toolbar with buttons to modify the editing state of the
    application.
*/

import SwiftUI


struct ContentView: View
  {
    @Binding var items: [Item]
    @State var draftItems: [Item]

    @State var isEditing: Bool = false


    init(items: Binding<[Item]>)
      {
        _items = items
        _draftItems = State(initialValue: items.wrappedValue)
      }


    var body: some View
      {
        NavigationView {
          ItemList(items: isEditing ? $draftItems : $items, isEditing: isEditing)
            .editingToolbar(isEditing: $isEditing,
                            cancelAction: {},
                            editAction: { draftItems = items },
                            saveAction: { items = draftItems })
        }
      }
  }


struct ContentView_Previews: PreviewProvider
  {
    static var previews: some View
      {
        ContentView(items: .constant(ModelData.defaultItems))
      }
  }
