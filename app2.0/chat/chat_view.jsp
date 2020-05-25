<%@ page import="java.sql.*" %>
<%
	Connection con=null;
	PreparedStatement st=null;
	ResultSet rs=null;
%>

<div class="chat-content">

  <div class="row">
      <div class="col-8 col-sm-8 col-xs-12">
        <div class="chat-header">
          Ask Your Queries
        </div>
        <div class="chat">
            <div class="chat-room">
            <%
                try {

                  // Initialize the database
                  new org.postgresql.Driver();
                  java.net.URI dbUri = new java.net.URI(System.getenv("DATABASE_URL"));

                  String username = dbUri.getUserInfo().split(":")[0];
                  String password = dbUri.getUserInfo().split(":")[1];
                  String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath() + "?sslmode=require";
                  con=DriverManager.getConnection(dbUrl, username, password);

                  st = con.prepareStatement("SELECT * FROM chat_messages where room= ?");//+session.getAttribute("userid"));
                  st.setInt(1, Integer.parseInt(request.getParameter("room")));
                  rs=st.executeQuery();
                    while(rs.next())
                    {
                %>
            <div class="<%= ((String)session.getAttribute("userid")).equals(rs.getString("sender"))?"you":"they" %>">
              <div class="chat-message">
                <p class="content"><%= rs.getString("content") %></p>
                <small>
                    <span class="time"><%= rs.getTimestamp("c_time") %></span>
                    <span
                        class="sender"><%= ((String)session.getAttribute("userid")).equals(rs.getString("sender"))?"You":rs.getString("sender_name")  %></span>
                </small>
              </div>

            </div>
            <%
                    }
                }
        		catch (Exception e) {
        			e.printStackTrace();
        		}
						finally {

              if (rs != null) {
                try { rs.close(); } catch (SQLException e) { ; }
                rs = null;
              }
              if (st != null) {
                try { st.close(); } catch (SQLException e) { ; }
                st = null;
              }
              if (con != null) {
                try { con.close(); } catch (SQLException e) { ; }
                con = null;
              }
            }

            %>
                <!--<div class="you">
                  <div class="chat-message">
                      <p class="content">Hi I Want to ask you some question?</p>
                      <small>
                          <span class="time">7:01pm</span>
                          <span class="sender">You</span>
                      </small>
                  </div>
                </div>

                <div class="they">
                  <div class="chat-message">

                      <p class="content">This is a message content</p>
                      <small>
                          <span class="time">7:06pm</span>
                          <span class="sender">Expert</span>
                      </small>

                  </div>
                </div>
                <div class="you">
                  <div class="chat-message">
                      <p class="content">Hi I Want to ask you some question?</p>
                      <small>
                          <span class="time">7:01pm</span>
                          <span class="sender">You</span>
                      </small>
                  </div>
                </div>
                <div class="they">
                  <div class="chat-message">

                      <p class="content">This is a message content</p>
                      <small>
                          <span class="time">7:06pm</span>
                          <span class="sender">Expert</span>
                      </small>

                  </div>
                </div>
                <div class="you">
                  <div class="chat-message">
                      <p class="content">Hi I Want to ask you some question?</p>
                      <small>
                          <span class="time">7:01pm</span>
                          <span class="sender">You</span>
                      </small>
                  </div>
                </div>

                <div class="they">
                  <div class="chat-message">

                      <p class="content">This is a message content</p>
                      <small>
                          <span class="time">7:06pm</span>
                          <span class="sender">Expert</span>
                      </small>

                  </div>
                </div>
                <div class="you">
                  <div class="chat-message">
                      <p class="content">Hi I Want to ask you some question?</p>
                      <small>
                          <span class="time">7:01pm</span>
                          <span class="sender">You</span>
                      </small>
                  </div>
                </div>

                <div class="they">
                  <div class="chat-message">

                      <p class="content">This is a message content</p>
                      <small>
                          <span class="time">7:06pm</span>
                          <span class="sender">Expert</span>
                      </small>

                  </div>
                </div>-->

            </div>
            <div class="input-message">
                <div class="row">
                  <div class="col-1 col-sm-1 col-xs-1">
                    .
                  </div>
                  <div class="col-9 col-sm-8 col-xs-7" style="padding:5px;">
                    <input type="number" id="userid" value="<%= ((String)session.getAttribute("userid")) %>" readonly hidden />
                    <input type="number" id="room" value="<%= request.getParameter("room") %>"  readonly hidden />
                    <input type="text" class="chat-input" placeholder="Type here .." />
                  </div>
                  <div class="col-2 col-sm-3 col-xs-4">
                    <input type="submit" value="Send" class="submit" />
                  </div>
                </div>
            </div>
        </div>
      </div>
      <div class="col-4 col-sm-4 col-xs-12">
        <div class="chat-header">
          <hr class="desktop-hidden tablet-hidden">
          Frequenty Asked
        </div>
        <div class="faq">

            <div class="article">

                    <header>This is a question?</header>

                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the
                    industry's standard dummy text ever since the 1500s.</p>
            </div>
            <div class="article">

                    <header>This is an another question?</header>

                <p>Lorem Ipsum is simply dummy text of the printing. It has survived not only five centuries, but also the leap
                    into electronic typesetting, remaining essentially unchanged.</p>
            </div>


        </div>
      </div>
  </div>

</div>
<script src="${pageContext.request.contextPath}/assets/js/chat/chat.js" charset="utf-8"></script>
