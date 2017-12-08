# GarageHunt

Garage Hunt is an iOS application written in Swift. It gives users the ability to search for garage sales in their immediate
area, as well as host their very own for other users to view and attend. Users can add pictures of items that will be avaiable,
set descriptive keywords to help hunters narrow down their search.

Project structure

The project has five view controllers, all embedded in a tab bar controller.
<img width="375" alt="screen shot 2017-12-08 at 12 16 58 am" src="https://user-images.githubusercontent.com/29612080/33757137-ab807e24-dbad-11e7-9225-90e4ac1d3197.png"> ->

Project flow

1) The first view controller is a sing in page that requires a user to regsister or login with email/password.

2) The second view (*browse*) is the home view. The app loads previously listed garage sale from Firebase. 

3) Users can tap on a listing to open a detail view of the garage sale. This view features a garage sale image, details about 
the garage sale, and a map with the location of the current user and garage sale. Users can use the map to get directions.

4) The third view is the view controller that allows users to add a listing to the database. Addresses saved on this view are
converted to coordinates, and sent to the map on the detail view.

5) The fifth view is the user account page. Sadly, there is only a log out button for now. Wait for 2.0!
