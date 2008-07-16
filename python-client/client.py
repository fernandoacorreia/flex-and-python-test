from pyamf.remoting.client import RemotingService

gw = RemotingService('http://localhost:8080/')

print "Testing EchoService:"
service = gw.getService('EchoService')
print service.echo('test')
print service.echo_upper('test')
print service.echo_upper(1)

print "Testing ProjectService:"
service = gw.getService('ProjectService')
print service.get(1)
print service.get_all()
