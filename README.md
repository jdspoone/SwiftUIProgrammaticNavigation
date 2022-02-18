#  README

This Xcode project demonstrates programmatic navigation within a simple SwiftUI iOS app.

---

For those of us coming from a background in AppKit and UIKit, programmatic navigation in SwiftUI is not always immediately obvious, however it can still be done.

The specific SwiftUI app I will be showcasing here implements programmatic navigation in the context of a List of NavigationLinks, with each NavigationLink transitioning to a View detailing the variables of a given model struct (which will be referred to as Items from here on in). While this will not be directly applicable to all use cases, the heart of the solution should be easily generalizable.

Each NavigationLink requires a unique tag (the id of the corresponding Item is a natural choice here), and must be passed a binding to a State variable representing the selected NavigationLink (in this case, an optional UUID).

Programmatic navigation can now be achieved by modifying that selection State variable according to your needs. For instance, after creating a new Item trough some action, you can programmatically navigate to the corresponding view by also setting the selection State variable accordingly.

This works because the list of Items we maintain is a Binding (or State) variable, and we modify the selectedItemUUID State variable at the same as we add a new Item. Modifications to State and Binding variables will cause the View to be re-rendered, meaning that not only will there be a new NavigationLink in our List, but we will automatically navigate to it's destination View.

Unlike in AppKit and UIKit, we can't just access and call methods on our parent's view controller in SwiftUI. However we can still achieve programmatic navigation backwards from a destination View through the use of completion callbacks. In this case, the destination View maintains a completion callback variable set on initialization, which will set the selectedItemUUID State variable of the parent View to nil, triggering re-rendering and backwards navigation.

This completion callback can then be executed at the appropriate time from the destination View.
