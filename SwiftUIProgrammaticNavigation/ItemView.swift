/*
    ItemView.swift
    SwiftUIProgrammaticNavigation

    Created by Jeff Spooner on 2022-02-16.

    ItemView is intended to showcase the variables of an Item, and
    is reached through a corresponding NavigationLink in ItemList.

    ItemView is initialized with a Binding to an Item, as well as completion
    callback for programmatically navigating backwards, and for cancelling
    editing.

    Similarly to ItemList, ItemView maintains a draft Item as a State variable
    to impement editing.

    Programmatic navigation backwards in this view is executed when editing on a
    newly created Item (i.e. we reached this ItemView programmatically) is cancelled,
    and when saving changes to a newly created Item. This is done by executing the
    previously described completion callbacks during the Cancel and Save actions.
*/

import SwiftUI


struct ItemView: View
  {
    @Binding var item: Item
    @State var draftItem: Item

    let isNew: Bool

    @State var isEditing: Bool

    let cancelCompletion: (Item) -> Void
    let navigateBackCompletion: () -> Void


    init(item: Binding<Item>, isNew: Bool = false, isEditing: Bool, cancelCompletion: @escaping (Item) -> Void = { _ in  }, navigateBackCompletion: @escaping () -> Void = {})
      {
        _item = item
        _draftItem = State(initialValue: item.wrappedValue)
        self.isNew = isNew
        _isEditing = State(initialValue: isEditing)
        self.cancelCompletion = cancelCompletion
        self.navigateBackCompletion = navigateBackCompletion
      }


    var body: some View
      {
        ScrollView {
          HStack {
            Text("Item Name:")
            TextField("Item Name", text: $item.name)
              .border(.gray, width: 0.75)
          }
            .padding()
        }
          .navigationTitle(item.name)
          .navigationBarTitleDisplayMode(.inline)
          .editingToolbar(isEditing: $isEditing,
                          cancelAction: {
                            // If we are looking at a newly created item, execute both
                            // the cancel and navigate back completion callbacks
                            if isNew {
                              cancelCompletion(item)
                              navigateBackCompletion()
                            }
                          },
                          editAction: {
                            // Ensure the draft item is a copy of the main item
                            draftItem = item
                          },
                          saveAction: {
                            // Update the main item to be the draft item
                            item = draftItem
                            // If we have just saved a newly created item, call the
                            // navigate back completion callback
                            if isNew {
                              navigateBackCompletion()
                            }
                          })
      }
  }


struct ItemView_Previews: PreviewProvider
  {
    static var previews: some View
      {
        ItemView(item: .constant(ModelData.defaultItems.first!), isEditing: false)
      }
  }
