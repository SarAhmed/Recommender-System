# Recommendation-System
A system that can be used to build user profiles and accordingly recommend items to buy/watch/read that matches their users’ interests<br/>
* Recommend an item to the user based on their previous purchases if the current cart is empty<br/>
* If there are items already added to the users cart, recommend an item to the user based on their previous purchases and the current items in the cart<br/>
* Recommend an item to the user based on the intersection between the items they previously purchased and other users’ purchases<br/>
## Running the tests
Given the below toy dataset where <b>users</b> is a list of the users, <b>items</b> is a list of the items that the users can buy and <b>purchases</b> is a list  mapping each user to a list of all his/her previous shopping carts.<br/>
users = ["A", "B", "C", "D", "E"]<br/><br/>
items["suit", "dress", "shoes", "T−shirt", "Jacket", "skirt", "shorts", "shirt", "trousers", "scarf", "mp3player", "TV", "LCDscreen", "headphone", "laptop", "keyboard", "mouse", "cellphone", "headphone", "earphone", "milk", "cheese", "bread", "chocolate", "meat", "flour", "sugar", "oil", "tomatoes", "chicken", "yogurt", "cereal", "beans", "fool", "eggs"]<br/><br/>
purchases = [("A", [["dress", "shoes"], ["milk", "cheese", "eggs"]]), 
("B", [["earphone", "mouse", "laptop"], ["mp3player"]]), 
("C", [["bread", "milk"], ["shoes"]]), 
("D", [["milk", "meat", "chicken", "yogurt"], ["beans", "cereal", "flour", "sugar"], ["tomatoes", "oil", "chicken"]]), 
("E", [])
]<br/>
