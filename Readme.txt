The web application contains two pages: 
	- Traffic map - the map with the filters
	- Data preparation - two buttons (Generate customers and Generate traffic)for initial data preparation
	
To generate the database run \SmartCities\DB_script\GenerateDB.sql. 
After this you can use the buttons for generation of records from the "Data preparation" page.

NB:Please have in mind the connectionString for the database should be changed so the application is able to connect to the new db server.
The connectionString is located in SmartCities.DAOs.BaseDao