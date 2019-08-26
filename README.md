# Recommendation-System
A system that can be used to build user profiles and accordingly recommend items to buy/watch/read that matches their users’ interests<br/>
* Recommend an item to the user based on their previous purchases if the current cart is empty<br/>
* If there are items already added to the users cart, recommend an item to the user based on their previous purchases and the current items in the cart<br/>
* Recommend an item to the user based on the intersection between the items they previously purchased and other users’ purchases<br/>
## Running the tests
Given the below toy dataset where <b>users</b> is a list of the users, <b>items</b> is a list of the items that the users can buy and <b>purchases</b> is a list  mapping each user to a list of all his/her previous shopping carts.<br/>
<b>users</b> = ["A", "B", "C", "D", "E"]<br/><br/>
<b>items</b> = ["suit", "dress", "shoes", "T−shirt", "Jacket", "skirt", "shorts", "shirt", "trousers", "scarf", "mp3player", "TV", "LCDscreen", "headphone", "laptop", "keyboard", "mouse", "cellphone", "headphone", "earphone", "milk", "cheese", "bread", "chocolate", "meat", "flour", "sugar", "oil", "tomatoes", "chicken", "yogurt", "cereal", "beans", "fool", "eggs"]<br/><br/>
<b>purchases</b> = [("A", [["dress", "shoes"], ["milk", "cheese", "eggs"]]), 
("B", [["earphone", "mouse", "laptop"], ["mp3player"]]), 
("C", [["bread", "milk"], ["shoes"]]), 
("D", [["milk", "meat", "chicken", "yogurt"], ["beans", "cereal", "flour", "sugar"], ["tomatoes", "oil", "chicken"]]), 
("E", [])
]<br/>
### Functions:
#### recommend
recommend :: String -> [String] -> String
The function recommend takes a user and his/her cart and recommend to the user an item accordingly
```
> recommend "A" ["earphone"]
"laptop"
> recommend "E" ["dress"]
"cereal"
> recommend "A" ["earphone"]
"tomatoes"
```
#### recommendEmptyCart
recommendEmptyCart :: String -> String
When the users cart is empty, the function recommendEmptyCart could be used to recommend an item to the user by 50% based on previously purchased items and 50% based on the intersection between the items purchased by the current user and other users.
```
> recommendEmptyCart "E"
"laptop"
> recommendEmptyCart "E"
"chicken"
> recommendEmptyCart "A"
"tomatoes"
```
#### recommendBasedOnItemsInCart
recommendBasedOnItemsInCart :: String -> [String] -> String
The function recommendBasedOnItems is used to recommend an item to the user based on the items
currently in the user’s cart and the previously purchased items by 50% and the other 50% based on the
intersection between the items purchased by the current user and other users.
```
> recommendBasedOnItemsInCart "A" ["dress"]
"shoes"
recommendBasedOnItemsInCart "A" []
"sugar
```
#### recommendBasedOnUsers
recommendBasedOnUsers :: String -> String
The function recommendBasedOnUsers is used to recommend an item to the user based on the intersection
between the items purchased by the current user and other users.
```
> recommendBasedOnUsers "B"
"meat"
> recommendBasedOnUsers "A"
"meat"
> recommendBasedOnUsers "A"
"chicken"
> recommendBasedOnUsers "C"
"earphone"
```
## Acknowledgment
This project was designed by the MET department at the German University in Cairo.
