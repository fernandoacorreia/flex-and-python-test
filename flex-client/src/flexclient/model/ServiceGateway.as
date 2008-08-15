package flexclient.model
{
    import flash.net.NetConnection;

    public class ServiceGateway
    {
        protected static var connection:NetConnection;

        public static function GetConnection():NetConnection
        {
            if (connection == null)
            {
                connection = new NetConnection();
                connection.connect("http://localhost:8080/services/");
            }
            return connection;
        }
    }
}
