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
cd server
dev_appserver.py --debug --address=localhost --port=8080 .

2. Execute the Python client test:
cd python-client
python client.py

3. Open the Flex client in the Web browser:
cd flex-client
cd bin-debug
main.html
