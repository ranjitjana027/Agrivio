import java.io.IOException;
import java.nio.ByteBuffer;
import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
@ServerEndpoint("/echo")
public class Echo {
 @OnMessage
 public void echoTextMessage(Session session, String msg) {
try {
 if (session.isOpen()) {
System.out.println("Received from client: "+msg);
session.getBasicRemote().sendText(msg);
 }
} catch (IOException e) {
try {
 session.close();
} catch (IOException e1) {}
}
 }
 }