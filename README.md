# p2p_exchange

A new Flutter project.

Database design
users
└── {userId}
├── username: "john_doe"
├── email: "johndoe@example.com"
├── profileImage: "https://example.com/image.jpg"
├── bio: "Tech enthusiast"
├── createdAt: <timestamp>
├── lastLogin: <timestamp>
├── userSettings
│ ├── notificationPreferences: true
│ ├── theme: "dark"
│ └── language: "en"
├── favorites: [productId1, productId2]
├── isAdmin: false
├── location
│ ├── latitude: 37.7749
│ └── longitude: -122.4194
├── address
│ ├── street: "123 Elm Street"
│ ├── city: "San Francisco"
│ ├── state: "CA"
│ └── zipCode: "94102"
└── idNumber: "A1234567890"

categories
└── {categoryId}
├── title: "Electronics"
├── description: "Latest gadgets and devices"
└── image: "https://example.com/electronics.jpg"

products
└── {productId}
├── name: "Smartphone X"
├── description: "A cutting-edge smartphone"
├── price: 999.99
├── categoryId: "categoryId"
├── image: "https://example.com/product-main.jpg" // main image
├── imageSlides: [
"https://example.com/product-image1.jpg",//thư viện firebase async firebase
"https://example.com/product-image2.jpg",
"https://example.com/product-image3.jpg"
]
├── createdAt: <timestamp>
├── userId: "userId"
├── comments: [commentId1, commentId2]
└── tradeList: [productId2, productId3]

comments
└── {commentId}
├── userId: "userId"
├── productId: "productId"
├── content: "Great product!"
├── createdAt: <timestamp>
└── likes: 12
