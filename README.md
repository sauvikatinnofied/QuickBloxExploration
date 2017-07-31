#### RESTRICTION

Dialog must of type `.group` ( not `.private`) otherwise the same instance will be returned
instead of creating a whole new dialog each time.

```swift
let chatDialog = QBChatDialog(dialogID: nil, type: .group) ✅
```

```swift
let chatDialog = QBChatDialog(dialogID: nil, type: .private) ❌
```

