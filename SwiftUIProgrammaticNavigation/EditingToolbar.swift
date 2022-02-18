/*
  EditingToolbar.swift
  SwiftUIProgrammaticNavigation

  Created by Jeff Spooner on 2022-02-16.

  EditingToolbar is a ViewModifier which configures a toolbar
  with Edit, Save, and Cancel buttons, with custom actions for
  each button.
*/

import SwiftUI


struct EditingToolbar: ViewModifier
  {
    @Binding var isEditing: Bool

    var cancelAction: (() -> Void)?
    var editAction: () -> Void
    var saveAction: () -> Void


    init(isEditing: Binding<Bool>, cancelAction: (() -> Void)? = nil, editAction: @escaping () -> Void, saveAction: @escaping () -> Void)
      {
        _isEditing = isEditing
        self.cancelAction = cancelAction
        self.editAction = editAction
        self.saveAction = saveAction
      }


    func body(content: Content) -> some View
      {
        content
          .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
              if isEditing {
                Button(role: .cancel, action: {
                  if let cancelAction = cancelAction {
                    cancelAction()
                  }
                  isEditing.toggle()
                }, label: {
                  Text("Cancel")
                })
              }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
              Button (action: {
                isEditing ? saveAction() : editAction()
                isEditing.toggle()
              }, label: {
                Text(isEditing ? "Done" : "Edit")
              })
            }
          }
          .navigationBarBackButtonHidden(isEditing)
      }
  }


extension View
  {
    func editingToolbar(isEditing: Binding<Bool>, cancelAction: (() -> Void)? = nil, editAction: @escaping () -> Void, saveAction: @escaping () -> Void) -> some View
      {
        modifier(EditingToolbar(isEditing: isEditing, cancelAction: cancelAction, editAction: editAction, saveAction: saveAction))
      }
  }

