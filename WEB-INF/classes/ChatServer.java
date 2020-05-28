/*
run this file with: javac -cp ../../../../lib/websocket-api.jar;../lib/postgresql-42.2.12.jre6.jar;../lib/json-simple-1.1.1.jar; ChatServer.java
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
    static final Map<Integer,List<ChatServer>> handlerMap = new HashMap<Integer,List<ChatServer>>();
    private int user_id;
    private String user_name;
    private int room;
    private Session session;
    private String role;

    void save(String msg)
    {
      Connection con=null;
      PreparedStatement ps=null;
        try{
          new org.postgresql.Driver();
          java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

          String username = dbUri.getUserInfo().split(":")[0];
          String password = dbUri.getUserInfo().split(":")[1];
          String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";

          con=DriverManager.getConnection(dbUrl, username, password);


          ps=con.prepareStatement("INSERT INTO chats (content,sender,room) VALUES( ?, ?, ?)");
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
        finally {
          if (ps != null) {
            try { ps.close(); } catch (SQLException e) { ; }
            ps = null;
          }
          if (con != null) {
            try { con.close(); } catch (SQLException e) { ; }
            con = null;
          }
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
                this.role=rs.getString("role");
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
        if(this.role.equals("EXPERT") || this.role.equals("ADMIN") || ( this.role.equals("FARMER")) && user_id==room){
          if(handlerMap.containsKey(room)){
            handlerMap.get(room).add(this);
          }
          else {
            List<ChatServer> newList=new ArrayList<ChatServer>();
            newList.add(this);
            handlerMap.put(room, newList);
          }
          broadcast("{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+ this.user_name+"\", \"content\": \"joined\",\"status\":true}",this.room);
          System.out.println("user: "+this.user_name+" connected to "+ this.room);
        }
        else {
          try {
            session.getBasicRemote().sendText("{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+ this.user_name+"\", \"content\": \"were denied access.\",\"status\":true}");
          } catch(Exception e) {
            System.out.println("Access Denied for "+this.user_name);
          }
          finally{
            try {
                session.close();
            } catch (IOException e1) {
            }
          }
        }
        /*if(handlers.contains(this)){
          System.out.println("Alredy exists.");
        }
        else{
          handlers.add(this);
          broadcast("{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+ this.user_name+"\", \"content\": \"joined\",\"status\":true}");
          System.out.println("user: "+this.user_name+" connected");
        }*/
    }

    @OnClose
    public void end() {
        //handlers.remove(this);
        for(Map.Entry<Integer,List<ChatServer>> entry: handlerMap.entrySet()){
          if (entry.getValue().contains(this)) {
            entry.getValue().remove(this);
          }
        }
        if ( handlerMap.containsKey(room) && handlerMap.get(room).contains(this)) {
          broadcast("{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+ this.user_name+"\", \"content\": \"has left\",\"status\":true}",this.room);
        }

        System.out.println(user_name + " has left");
    }

    @OnMessage
    public void onMessage(String content) {
        Date d=new Date();
        try{
          JSONParser parser=new JSONParser();
          JSONObject json=(JSONObject)parser.parse(content);
          String msg=json.get("content").toString();
          String tstamp=json.get("timestamp").toString();
          if (!msg.trim().equals("")) {
            String message="{\"sender\":\""+this.user_id+"\", \"sender_name\":\""+this.user_name+"\", \"content\": \""+msg+"\", \"date\":\""+d+"\",\"status\":false, \"timestamp\":\""+tstamp+"\"}";
            this.save(msg);
            broadcast(message,this.room);
          }
        }
        catch(Exception e){
          e.printStackTrace();
        }
    }

    private static void broadcast(String msg,int room) {
      if (handlerMap.containsKey(room)) {
        for (ChatServer handler : handlerMap.get(room)) {
            try {
                synchronized (handler) {
                    handler.session.getBasicRemote().sendText(msg);
                }
            } catch (IOException e) {
                handlerMap.get(room).remove(handler);
                try {
                    handler.session.close();
                } catch (IOException e1) {
                }
                broadcast(handler.user_name + " has discontinued.",room);
            }
        }
      }

    }
}
