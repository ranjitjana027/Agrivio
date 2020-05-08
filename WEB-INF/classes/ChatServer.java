/*
run this file with-
javac -cp ../../../../lib/websocket-api.jar;../lib/postgresql-42.2.12.jre6.jar;../lib/json-simple-1.1.1.jar; ChatServer.java
*/
import java.io.IOException;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.server.PathParam;
import java.util.*;
import java.util.Date;
import java.sql.*;
import java.io.PrintWriter;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;

@ServerEndpoint(value = "/chat/{room}/{user_id}")
public class ChatServer {
    static final List<ChatServer> handlers = new ArrayList<ChatServer>();
    private int user_id;
    private String user_name;
    private int room;
    private Session session;

    void save(String msg)
    {
        try{
          new org.postgresql.Driver();
          java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

          String username = dbUri.getUserInfo().split(":")[0];
          String password = dbUri.getUserInfo().split(":")[1];
          String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

          Connection con=DriverManager.getConnection(dbUrl, username, password);


          PreparedStatement ps=con.prepareStatement("INSERT INTO chats (content,sender,room) VALUES( ?, ?, ?)");
          ps.setString(1,msg);
          ps.setInt(2,this.user_id);
          ps.setInt(3,this.room);
          ps.executeUpdate();
          ps.close();
          con.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    void setUser(int user_id)
    {
        try {
          new org.postgresql.Driver();
          java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

          String username = dbUri.getUserInfo().split(":")[0];
          String password = dbUri.getUserInfo().split(":")[1];
          String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

          Connection con=DriverManager.getConnection(dbUrl, username, password);

            // Statement stmt = con.createStatement();
            PreparedStatement st = con.prepareStatement("SELECT * FROM users where id= ?");
            st.setInt(1, user_id);
            // st.setString(1, session.getAttribute("userid"));
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                this.user_name= rs.getString("firstname") + " " + rs.getString("lastname");

            }
        } catch (Exception e) {
            System.out.print("No user record found.");
            e.printStackTrace();
        }
    }




    @OnOpen
    public void start(@PathParam("user_id") int user_id, @PathParam("room") int room, Session session) {
        System.out.println("Web socket Connection request");

        this.session = session;
        this.user_id=user_id;
        this.room=room;
        this.setUser(user_id);
        if(handlers.contains(this)){
          System.out.println("Alredy exists.");
        }
        else{
          handlers.add(this);
          broadcast("{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+ this.user_name+"\", \"content\": \"joined\",\"status\":true}");
          System.out.println("user: "+this.user_name+" connected");
        }
    }

    @OnClose
    public void end() {
        handlers.remove(this);
        broadcast("{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+ this.user_name+"\", \"content\": \"has left\",\"status\":true}");
        System.out.println(user_name + " has left");
    }

    @OnMessage
    public void onMessage(String msg) {
        Date d=new Date();
        /*JSONParser parser=new JSONParser();
        String content="";
        try{
          Object obj=parser.parse(msg);
          JSONObject obj1=(JSONObject)obj;
          this.room=obj1.get("room");
          content=ovj1.get("content");
        }*/
        String message="{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+this.user_name+"\", \"content\": \""+msg+"\", \"date\":\""+d+"\",\"status\":false}";
        this.save(msg);
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
                broadcast(handler.user_name + " has discontinued.");
            }
        }
    }
}
