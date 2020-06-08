<div class="chat-content">

  <div class="row">
      <div class="col-8 col-sm-8 col-xs-12">
        <div class="chat-header">
          Ask Your Queries
        </div>
        <div class="chat">
            <div class="chat-room">

            </div>
            <div class="input-message">
                <div class="row">
                  <div class="col-1 col-sm-1 col-xs-1">
										<svg viewBox="0 0 40 40" class="pulse">
											<circle id="outerCircle" cx="20" cy="25" />
											<circle id="innerCircle" cx="20" cy="25" r="8" />
										</svg>
                  </div>
                  <div class="col-9 col-sm-8 col-xs-7" style="padding:5px;">
                    <input type="number" id="userid" value="${sessionScope.userid}" readonly hidden />
                    <input type="number" id="room" value="${sessionScope.userid}"  readonly hidden />
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
