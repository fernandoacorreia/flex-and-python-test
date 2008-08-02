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

INSTRUCTIONS

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
