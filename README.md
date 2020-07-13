# BlackJack
iOS Application that simulates single player version of the game Blackjack

# Design Pattens
This Application use the MVC-ICE Software Design pattern (Model View Controller Inheritance Components Extension). Based on the project scope the use Inheritance and Extension is used at a very minimal level.

# Project Structure

[Constants](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/Constants)
Contains all the constant values used through out the app. Keeping in mind further expansion of multiple language Accomodation (evolving to Localization) and also minimizing the errors in refrencing  

[DataModel](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/DataModel)
Houses all Barebone data model inherited from Codable making it easier for network adaptation

[Helper](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/Helper)
 Contains the Helpers for the Game saving and state maintanance 


[ViewComponents](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/ViewComponents)
Similar view components and the Brain view components built in reusable fashion, making it easy to follow


[Home](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/Home)
The home screen with all functional and logical elements (Model,View,Controller) Model is left empty on purpose

[Game](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/Game)
The Game screen with all functional and logical elements (Model,View,Controller) Model is left empty on purpose


[Settings](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/Settings)
The Settings screen with all functional and logical elements (Model,View,Controller)



[extension](https://github.com/vaghul/BlackJack/tree/master/BlackJack/BlackJack/extension)
contains resuable font and color configuration



# Tech Stack
The Application is built on **Swift 5.0** with **Coded Design** implementation. The application does not consume any third-party library

# Contribution
All the supporting files and architecture was hand designed , tested and improvised soley by [Vaghula Krishnan](https://github.com/vaghul)
