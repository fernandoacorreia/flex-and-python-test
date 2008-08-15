Flex and Python Test

Copyright (C) 2008 by Fernando de Alcantara Correia. All rights reserved.
Licensed under the MIT License (http://www.opensource.org/licenses/mit-license.php).

Project website: http://fernandoacorreia.wordpress.com

The goal of this experiment is to create a Web application with a rich user interface 
and a fast response time in a high-performance server environment without worrying too 
much about server administration.

PREREQUISITES

* Google App Engine
* Flex Builder 3 or Flex SDK
* Python 2.5

INSTRUCTIONS FOR WORKING LOCALLY

1. Start the server:
On a Windows environment, run start-server.cmd. Or do this:
dev_appserver.py --debug --address=localhost --port=8080 server

2. Execute the Python client to see its help message and insert some example records:
cd python-client
python client.py
python client.py initialize

3. Open the Flex client in the Web browser:
cd flex-client
cd bin-debug
main.html

INSTRUCTIONS FOR DEPLOYING ON GOOGLE APP ENGINE

1. Create an empty application on Google App Engine. Lets call it "yourapp".
2. Edit the file server/app.yaml and change pyamftest to your app's name:
   application: yourapp
3. In the file flex-client/src/flexclient/model/ServiceGateway.as change
   http://localhost:8080/services/ to http://yourapp.appspot.com/services/
4. Optionally, in the file python-client/client.py make the same change.
5. Build the Flex app in release mode and save it to the server/client
   directory. In Flex Builder this can be done with the
   Project > Export Release Build command.
6. On a Windows environment run the update_gae.cmd script or type this:
   appcfg.py update server/
7. If you changed client.py you can use it to create some sample data:
   cd python-client
   client.py initialize
8. Browse to http://yourapp.appspot.com and click on Edit projects.
