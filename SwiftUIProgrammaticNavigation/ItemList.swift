/*
    ItemList.swift
    SwiftUIProgrammaticNavigation

    Created by Jeff Spooner on 2022-02-16.

    The ItemList is initialized with a list of Items as a Binding, as
    well as an isEditing flag as a Binding representing the editing state
    of the application.

    The ItemList maintains a selectedItemUUID variable as State, which represents
    the selected NavigationLink. When nil, no NavigationLink is selected.

    Each Item is rendered as a NavigationLink within a List, where the tag of the
    NavigationItem is set to the UUID of the corresponding Item, and the selection
    is bound to the selectedItemUUID.

    Programmatic navigation is achieved through updating the selectedItemUUID to
    the UUID of the desired Item, in the case of this sample project, the UUID of
    a newly created Item. We also store the same UUID in another state variable,
    which allows us to determine if we are navigating to a View for a newly created
    Item.

    Backwards programmatic navigation is achieved by passing the destination View
    for each NavigationLink a completion callback which sets the selectedItemUUID
    and newItemUUID to nil.
*/

import SwiftUI


struct ItemList: View
  {
    @Binding var items: [Item]

    var isEditing: Bool

    @State var selectedItemUUID: UUID?
    @State var newItemUUID: UUID?

    var body: some View
      {
        List {
          Section {
            ForEach($items) { $item in
              NavigationLink(tag: item.id, selection: $selectedItemUUID, destination: {
                 ItemView(item: $item,
                          isNew: item.id == newItemUUID,
                          isEditing: selectedItemUUID != nil,
                          cancelCompletion: { item in
                            items.removeAll(where: { $0.id == item.id })
                          },
                          navigateBackCompletion: {
                            selectedItemUUID = nil
                            newItemUUID = nil
                          })
              }, label: {
                ItemRow(item: item)
              })
            }
          } header: {
            HStack {
              Text("Items")
                .font(.title)
                .textCase(.none)
                .foregroundColor(.primary)

              Spacer()

              Button(action: {
                // Create a new item and add it to the array of items
                let newItem = Item(name: "New Item")
                items.append(newItem)

                // Set the selected id state variable to trigger navigation,
                // and store the UUID in another variable
                selectedItemUUID = newItem.id
                newItemUUID = newItem.id
              }, label: {
                Image(systemName: "plus.circle")
                  .resizable()
                  .aspectRatio(1, contentMode: .fit)
                  .frame(height: 25)
              })
                .disabled(isEditing == false)
                .opacity(isEditing ? 1.0 : 0.0)
            }
          }

        }
          .navigationTitle("Items")
          .navigationBarTitleDisplayMode(.inline)
      }
  }


struct ItemList_Previews: PreviewProvider
  {
    static var previews: some View
      {
        ItemList(items: .constant(ModelData.defaultItems), isEditing: false)
      }
  }
