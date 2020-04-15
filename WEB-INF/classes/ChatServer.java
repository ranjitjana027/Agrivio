import java.io.IOException;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.PathParam;
import java.util.*;
import java.util.Date;
import java.sql.*;
import java.io.PrintWriter;


@ServerEndpoint(value = "/chat/{name}")
public class ChatServer {
    static final List<ChatServer> handlers = new ArrayList<ChatServer>();
    private String name;
    private String user;
    private Session session;

    void fun(String msg)
    {
        try{
            String dbURL =  "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE";
            Connection con = DriverManager.getConnection(dbURL );
            Statement stmt = con.createStatement();
            String insert=("insert into chats(id,content,sender) values( seq_chat.nextval, '"+msg+"', "+Integer.parseInt(name)+ ")");
            stmt.executeUpdate(insert);

            stmt.close();
            con.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    void setUser(String s)
    {
        try {
            String dbURL = "jdbc:oracle:thin:dummy/passsword@localhost:1521:XE";
            Connection con = DriverManager.getConnection(dbURL);
            // Statement stmt = con.createStatement();
            PreparedStatement st = con.prepareStatement("SELECT * FROM farmers where id=" + s);
            // st.setString(1, session.getAttribute("userid"));
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                this.user= rs.getString("firstname") + " " + rs.getString("lastname");

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }




    @OnOpen
    public void start(@PathParam("name") String name, Session session) {
        System.out.println("running");
        this.session = session;
        this.name = name;
        setUser(name);
        handlers.add(this);
        broadcast("{\"sender\":\""+this.name+"\", \"content\": \"joined\",\"status\":true}");
        System.out.println(name);
    }

    @OnClose
    public void end() {
        handlers.remove(this);
        broadcast(name + " has left");
    }

    @OnMessage
    public void onMessage(String msg) {
        Date d=new Date();
        String message="{\"sender\":\""+this.name+"\", \"content\": \""+msg+"\", \"date\":\""+d+"\",\"status\":false}";
        fun(msg);
        broadcast(message);
    }

    private static void broadcast(String msg) {
        for (ChatServer handler : handlers) {
            try {
                synchronized (handler) {
                    handler.session.getBasicRemote().sendText(msg);
                }
            } catch (IOException e) {
                handlers.remove(handler);
                try {
                    handler.session.close();
                } catch (IOException e1) {
                }
                broadcast(handler.name + " has discontinued.");
            }
        }
    }
}
