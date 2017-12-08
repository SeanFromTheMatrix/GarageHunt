# GarageHunt

Garage Hunt is an iOS application written in Swift. It gives users the ability to search for garage sales in their immediate
area, as well as host their very own for other users to view and attend. Users can add pictures of items that will be avaiable,
set descriptive keywords to help hunters narrow down their search.

Project structure
<img width="402" alt="screen shot 2017-12-08 at 12 24 02 am" src="https://user-images.githubusercontent.com/29612080/33757354-a28ee76e-dbae-11e7-8d64-649eb44fe43b.png">
<img width="55" alt="screen shot 2017-12-08 at 12 27 32 am" src="https://user-images.githubusercontent.com/29612080/33757360-a5ff6e14-dbae-11e7-958d-8f13567581b4.png">
<img width="375" alt="screen shot 2017-12-08 at 12 16 58 am" src="https://user-images.githubusercontent.com/29612080/33757364-aaadaf20-dbae-11e7-9d1f-7934b94f6eb9.png">
<img width="55" alt="screen shot 2017-12-08 at 12 27 32 am" src="https://user-images.githubusercontent.com/29612080/33757366-ac6422e0-dbae-11e7-9333-8a5619ef9466.png">
<img width="376" alt="screen shot 2017-12-08 at 12 16 35 am" src="https://user-images.githubusercontent.com/29612080/33757371-b311df4c-dbae-11e7-90ea-af414681e3bf.png">
<img width="55" alt="screen shot 2017-12-08 at 12 27 32 am" src="https://user-images.githubusercontent.com/29612080/33757377-b56fe28e-dbae-11e7-8ade-77e3139059c3.png">
<img width="486" alt="screen shot 2017-12-08 at 12 32 01 am" src="https://user-images.githubusercontent.com/29612080/33757515-5ea831e4-dbaf-11e7-9afc-0f0c65c3e3f9.png">
<img width="55" alt="screen shot 2017-12-08 at 12 27 32 am" src="https://user-images.githubusercontent.com/29612080/33757366-ac6422e0-dbae-11e7-9333-8a5619ef9466.png">
<img width="376" alt="screen shot 2017-12-08 at 12 16 13 am" src="https://user-images.githubusercontent.com/29612080/33757395-c67a1360-dbae-11e7-90c9-d98f3066adce.png">
<img width="55" alt="screen shot 2017-12-08 at 12 27 32 am" src="https://user-images.githubusercontent.com/29612080/33757402-cda98d1e-dbae-11e7-9617-882b4e64984a.png">
<img width="376" alt="screen shot 2017-12-08 at 12 15 49 am" src="https://user-images.githubusercontent.com/29612080/33757405-d23daa90-dbae-11e7-8312-c95c0c325aa5.png">
<img width="55" alt="screen shot 2017-12-08 at 12 27 32 am" src="https://user-images.githubusercontent.com/29612080/33757410-d54c0038-dbae-11e7-9883-753c80def04e.png">
<img width="377" alt="screen shot 2017-12-08 at 12 17 16 am" src="https://user-images.githubusercontent.com/29612080/33757415-d9a9d510-dbae-11e7-9673-2ecb3c46d94a.png">




Project flow

1) The first view controller is a sing in page that requires a user to regsister or login with email/password.

2) The second view (*browse*) is the home view. The app loads previously listed garage sale from Firebase. 

3) Users can tap on a listing to open a detail view of the garage sale. This view features a garage sale image, details about 
the garage sale, and a map with the location of the current user and garage sale. Users can use the map to get directions.

4) The third view is the view controller that allows users to add a listing to the database. Addresses saved on this view are
converted to coordinates, and sent to the map on the detail view.

5) The fifth view is the user account page. Sadly, there is only a log out button for now. Wait for 2.0!
