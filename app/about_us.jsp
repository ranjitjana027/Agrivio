<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<t:wrapper>
  <jsp:attribute name="header">
    <title>About Us</title>
    <style media="screen">

      .about-us .intro{
        text-align: center;

      }
      .about-us h2{
        text-align: center;
      }
      .profiles{
        display: flex;
        align-items: center;
        justify-content:center;
        flex-wrap: wrap;
      }
      .card{
        box-shadow: 0 0 8px -3px;
        width: 220px;
        margin: 10px;
      }
      .card > img{
        width: 100%;
        display: block;
        object-fit: cover;
        height: 120px;
        object-position: center;
      }
      .card h2, .card h3{
        /*background-color: rgba(0, 0, 0, 0.99);
        color: white;*/
        padding:0 10px;
        text-align: center;
        letter-spacing: 0.05rem;
        font-weight: normal;
      }
      .card h2{
        font-family: 'arizonia', cursive;
      }
      .card p{
        padding:0 10px;
        word-wrap: break-word;
      }
      .card .contact-me{
        display: flex;
        align-items: center;
        justify-content: space-around;

      }
      /*.card > p >a{
        display: block;
        text-decoration: none;
        text-align: center;
        padding: 7px;
        background-color: rgba(0, 0, 0, 0.99);
        color: white;
      }*/
    </style>
  </jsp:attribute>
  <jsp:body>
    <div class="about-us">
      <div class="intro">
        <h1>About Us</h1>
        <p>We are all very different. We were born in different cities, we love different music, food, movies. But we have something that unites us all. It is our project. We are not just a team, we are a family.</p>
      </div>
      <div class="">
        <h2>Our Team</h2>
        <div class="profiles">
          <div class="card">
            <img src="${pageContext.request.contextPath}/assets/img/download.jpg" alt="Ranjit">
            <h2>Ranjit Jana</h2>
            <h3>Full Stack Developer</h3>
            <p>Undergraduate Student at Jadavpur University </p>
            <p class="contact-me">
              <a href="https://www.linkedin.com/in/ranjitjana027/" target="_blank"><img src="../assets/icons/work/linkedin.png" alt=""></a>
              <a href="#"><img src="../assets/icons/work/twitter.png" alt=""></a>
              <a href="https://github.com/ranjitjana027" target="_blank"><img src="../assets/icons/work/github.png" alt=""></a> <a href="mailto:ranjitjana027@gmail.com"><img src="../assets/icons/work/gmail.png" alt=""> </a>
            </p>
          </div>
          <div class="card">
            <img src="${pageContext.request.contextPath}/assets/img/images.jpg" alt="Manoj">
            <h2>Manoj K Sarkar</h2>
            <h3>Full Stack Developer</h3>
            <p>Undergraduate Student at Jadavpur University </p>
            <p class="contact-me">
              <a href="#" target="_blank"><img src="../assets/icons/work/linkedin.png" alt=""></a>
              <a href="#"><img src="../assets/icons/work/facebook.png" alt=""></a>
              <a href="https://github.com/Manoj-K-Sarkar" target="_blank"><img src="../assets/icons/work/github.png" alt=""></a> <a href="mailto:wakeupmanoj123@gmail.com"><img src="../assets/icons/work/gmail.png" alt=""> </a>
            </p>
          </div>
          <div class="card">
            <img src="${pageContext.request.contextPath}/assets/img/download (1).jpg" alt="Saikat">
            <h2>Saikat Biswas</h2>
            <h3>Full Stack Developer</h3>
            <p>Undergraduate Student at Jadavpur University </p>
            <p class="contact-me">
              <a href="#" target="_blank"><img src="../assets/icons/work/linkedin.png" alt=""></a>
              <a href="#"><img src="../assets/icons/work/facebook.png" alt=""></a>
              <a href="https://github.com/mr-b-98" target="_blank"><img src="../assets/icons/work/github.png" alt=""></a> <a href="mailto:jusaikat2021@gmail.com"><img src="../assets/icons/work/gmail.png" alt=""> </a>
            </p>
          </div>
          <div class="card">
            <img src="${pageContext.request.contextPath}/assets/img/images (1).jpg" alt="Indranil">
            <h2>Indranil Mandal</h2>
            <h3>Full Stack Developer</h3>
            <p>Undergraduate Student at Jadavpur University  </p>
            <p class="contact-me">
              <a href="#" target="_blank"><img src="../assets/icons/work/linkedin.png" alt=""></a>
              <a href="#"><img src="../assets/icons/work/facebook.png" alt=""></a>
              <a href="https://github.com/indranil1999" target="_blank"><img src="../assets/icons/work/github.png" alt=""></a> <a href="mailto:indranilmondal1999@gmail.com"><img src="../assets/icons/work/gmail.png" alt=""> </a>
            </p>
          </div>
        </div>
      </div>
    </div>
  </jsp:body>
</t:wrapper>
