<!-- The Right Tutors Online College Webpage-->
<!-- Written by Isiaka Kehinde Emmanuel, an Electrical electronics Engineering student of University of Ibadan, Oyo Nigeria-->
<!DOCTYPE html>
<html>
<head>
<style>
/* written by Isiaka Kehinde Emmanuel */
/* The Right Tutors Online College*/


body{
    margin:0;
    padding:0;
}

/*---------Navigation---------*/

#nav-bar{
    position:sticky;
    top:0;
    z-index:10;
}
.nav-bar brand img{
    width:350px;
    height:100px;
    padding-left:1px;
}
.navbar-nav li{
    padding:0 10px;
}
.navbar-nav li a{
    float:right;
    text-align:left;
}
#nav-bar ul li a:hover{
    color:#aff!important;
}
.navbar{
    background:#fff;
}
.navbar-toggler{
    border:none!important;
}
.nav-link{
    color:#555!important;
    font-weight:600;
    font-size:16px;
}

/*--------Slider--------*/

#slider{
    width:100%;
    height:300px;
}
 
.carousel-caption{
    top:50%;
    translate :translateY (-50%);
    bottom:inital!important;
}
.carousel-caption h5{
    font-size:20px;
    color:#fff;
}

/*--------------About----------*/

#about{
    padding-top:50px;
    padding-bottom:50px;
    color:#555;
}
.p {
    text-decoration:underline ;
}
.about-content{
    padding-top:20px;
}
.mission{
    padding-top:10px
    width:350px
    border:3px black;
    box-shadow:3px 3px 2px #000000;
    border-color:black;
    background-color:#999999;
    color:#ffffff;
}
.vision{
    padding-top:10px
    width:350px
    border:3px black;
    box-shadow:3px 3px 2px #000000;
    border-color:black;
    background-color:#999999;
    color:#ffffff;
}
/*---------Achievements-------*/

#achievemet {
    padding-top:40px;
    padding-bottom:30px;
    color:#555;
}

.progress-bar{
    border-radius:16px;
}
.progress{
    border-radius:16px!important;
    margin-bottom:20px;
}

/*------Register with us------*/

#form {
    width:100%;
    border:3px dashed ;
    height:700px;
    vertical-align:middle ;
    padding-right:10px;
    text-align:center ;
    background-color:skyblue;
}

/*------------news------------*/

.news1 {
    background-color:#00d7ff;
}
.news2 {
    background-color:#00d7ff;
}

/*-----------Services--------*/

#services{
    background-image:linear-gradient(rgba(0,0,0,0.8),rgba(0,0,0,0.8)), url("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQjpmdaJET6yRza6ECix7ZPnQND3XyR9F6Q6Tep5jZtvj5UbJB5&usqp=CAU");
    background-position:center;
    background-size:cover;
    background-attachment:fixed ;
    color:#efefef!important;
    padding-top:50px;
    padding-bottom:50px;
}
#services h1{
    color:#efefef!important;
    padding-bottom:10px;
    text-align:center;
}
#services h1::after{
    content:"";
    display:block;
    background:#efefef;
    width:170px;
    height:3px;
    margin:20px auto 5px;
}
.services{
    margin-top:20px;
}
.icons{
    margin:20px auto;
    height:80px;
    font-size:40px;
    padding:20px;
    width:80px;
    border-radius:50%;
    border:1px solid #fff;
}
#services p{
    font-size:14px;
    margin-top:20px;
    color:#ccc;
}
#services .col-md-3:hover{
background:#007bff;
cursor:pointer;
transition:0.7s;    
}

/*-----------Our Tutors------*/

#tutors{
    padding-top:50px;
    padding-bottom:50px;
    color:#555;
    }
h1{
    color:#555!important;
    padding-bottom:10px;
    text-align:center;
}
h1::after{
    content:"";
    background:#007bff;
    display:block;
     width:170px;
    height:3px;
    margin:20px auto 5px;
}
.profile-pic{
    padding-top:25px;
}
.profile-pic .img-box{
    opacity:1;
    position:relative ;
    display:block ;
}
.profile-pic .img-box img{
    filter:grayscale(1);
}
.profile-pic .img-box img:hover{
   filter:grayscale(0);
   cursor:pointer;
}
.profile-pic h2{
    color:#007bff!important;
    font-weight:bold;
    font-size:22px;
    margin-top:15px;
}
.profile-pic h3{
     font-weight:bold;
    font-size:15px;
    margin-top:15px;
}
#tutors .fa{
    border-radius:50%;
    color:#007bff!important;
    background:#fff;
    padding:4px;
    width:25px;
    height:25px;
}
.img-box ul li{
    padding:5px;
    display:inline-block ;
}
.img-box:hover ul{
    opacity:1;
}
.img-box ul, .img-box ul li{
    transition:0.5s;
}

/*-----------Testimonial--------*/
}
#testimonials{
    padding-top:50px;
    padding-bottom:50px;
}
#testimonials.row{
    margin-top:30px;
}
.col-md-4{
    margin:40px auto;
}
.profile{
    padding:70px 10px 10px;
    background-color:#efefef;
}
.user{
    width:120px;
    height:120px;
    border-radius:50%;
}
.profile h3{
    color:#007bff;
    font-size:20px;
    margin-top:15px;
}
#testimonials span
{
    font-size:12px;
    color:#333;
}
.profile1{
    padding-top:30px;
    background-color:#efefef;
    height:450px;
    text-align:center;
    width:300px;
    margin-left:30px;
    margin-right:30px;
}
.profile2{
    padding-top:30px;
    background-color:#efefef;
    height:380px;
    text-align:center;
    width:300px;
    margin-left:30px;
    margin-right:30px;
}
.profile3{
    padding-top:30px;
    background-color:#efefef;
    height:400px;
    text-align:center;
    width:300px;
    margin-left:30px;
    margin-right:30px;
}
.profile4{
    padding-top:30px;
    background-color:#efefef;
    height:550px;
    text-align:center;
    width:300px;
    margin-left:30px;
    margin-right:30px;
}
.profile5{
    padding-top:30px;
    background-color:#efefef;
    height:500px;
    text-align:center;
    width:300px;
    margin-left:30px;
    margin-right:30px;
}
h6 span {
    border:1px dashed #000000;
}

/*------------Get in touch--------*/

#contact{
    background:#efefef;
    padding-top:40px;
    padding-bottom:40px;
    color:#777;
}
.contact-form{
    padding:15px;
}
.form-control{
    border-radius:0!important;
    border:none!important;
}
::placeholder{
    color:#999!important;
}
.follow{
    background:#fff;
    padding:10px;
    margin:15px;
}
.contact-info .fa{
    margin:10px;
    color:#007bff;
    font-weight:bold;
}

/*--------footer-------*/

#footer{
    background:#333;
    color:#fff;
    padding:12px;
}
/*----Isiaka Kehinde Emmanuel-----*/
/*All right reserved*/
</style>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>The Right Tutors Online College</title>
<link rel="styelsheet" href="style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script> <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script> 
</head>
<body>

<!---------NavigationBar--------->

<section id="nav-bar"> 
<nav class="navbar navbar-expand-lg navbar-light">
<a class="navbar-brand" href="#"><img src="https://i.ibb.co/YT5zz1f/IMG-20200427-214916.jpg" width="350px" height="80px"/></a> 
<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button> 
<div class="collapse navbar-collapse" id="navbarNav">
<ul class="navbar-nav ml-auto"> 
<li class="nav-item"> 
<a class="nav-link" href="#top">HOME</a></li> 
<li class="nav-item"><a class="nav-link" href="#about">ABOUT US</a></li> 
<li class="nav-item"><a class="nav-link" href="#achievement">ACHIEVEMENT</a></li>
<li class="nav-item"><a class="nav-link" href="#news">NEWS</a></li>
<li class="nav-item"><a class="nav-link" href="#services">SERVICES</a></li>
<li class="nav-item"><a class="nav-link" href="#Registration">REGISTRATION</a></li>
<li class="nav-item"><a class="nav-link" href="#tutors">TUTORS</a></li>
<li class="nav-item"><a class="nav-link" href="#testimonials">TESTIMONIALS</a></li>
<li class="nav-item"><a class="nav-link" href="#contact">CONTACT</a></li>    
</ul> </div></nav>
</section>

<!------------Slider---------->

<div id="slider>
<div id="headerSlider" class="carousel slide" data-ride="carousel">
<ol class="carousel-indicators"> <li data-target="#headerSlider" data-slide-to="0" class="active"></li> <li data-target="#headerSlider" data-slide-to="1"></li> 
<li data-target="#headerSlider" data-slide-to="2"></li> 
<li data-target="#headerSlider" data-slide-to="3"></li> 
</ol><div class="carousel-inner"> <div class="carousel-item active"> <img class="d-block w-100" src="https://i.ibb.co/rbHz6My/FB-IMG-15875670367344332.jpg" width="100%" height="240px"/>
<div class="carousel-caption">
</div>
</div>
<div class="carousel-item"> <img class="d-block w-100" src="https://i.ibb.co/zV2SPJ6/FB-IMG-15875670462757815.jpg" width="100%" height="240px"/>
<div class="carousel-caption">
</div>
</div> 
<div class="carousel-item"><img class="d-block w-100" src="https://i.ibb.co/GT2sL6s/FB-IMG-15880210403612983.jpg" width="100%" height="240px"/>
<div class="carousel-caption">
</div>
</div>
<div class="carousel-item"> <img class="d-block w-100" src="https://i.ibb.co/2nr2SLJ/FB-IMG-15880210841869116.jpg" width="100%" height="240px"/>
<div class="carousel-caption">
</div>
</div> 
</div> <a class="carousel-control-prev" href="#headerSlider" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a> <a class="carousel-control-next" href="#headerSlider" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> 
<span class="sr-only">Next</span></a>
</div>
</div>
<!---------------About------------->

<section id="about">
<div class="container">
<div class="row">
<div class="col-md-6">
<div class="about-content">
<h2>About us</h2>
TRTOC is the first and best online college for university Aspirants popularly known as Jambites, incepted on the 17th of October 2019 with a total population of 20 students then. Social media  platforms (Whatsapp, Facebook and Telegram) are the media use for our lessons in TRTOC, <i>and that has proven to be very effective.</i> Our Motto:
   <p class="p" align="center">
    "you can be perfect" </p><br />
    <div class="mission">
      <center><h3>Our Mission</h3>
     <p> We are on the race to see all our Students(<b>TRTITES</b>) admitted into their various instituition of choice to study their choosen courses.</p></center>
    </div>
    <div class="vision">
         <center><h3>Our Vision</h3>
        <p>Our vision is to see all our Students(<b>TRTITES</b>), become sucessful professionals in their respectives field.</p></center>
    </div>
</div>
</div>
</div>
</div><br />

 <!------------Achievement------------->
 
 <div id="achievement"> 
 <div class="container">
 <div class="row>
 <div class="col-md-6">
    <h2>Achievement</h2>
       With a total population of 20 students, <b><i>TRTOC</b></i> was able to produce 10 (50% of her students) students with 300+(302-332) out of possible 400, <b><i>TRTOC</b></i> recorded 100% pass rate in her very first UTME result and about to unleash more in the upcoming PUTME exam.<br/><br />
       <img src="https://i.ibb.co/4J5JfDg/20200427-151035-0000.png" alt="20200427-151035-0000" width="100%" height="500px"/>
</div>
<button type="button" class="btn btn-primary">Read more>></button>
</div>
<h4>Results Analysis</h4>
<div class="col-md-6 skills-bar">
<p>Excellent (300-400)</p>
<div class="progress">
<div class="progress-bar" style="width:50%">50%</div></div>
<p>Very good (280-300)</p>
<div class="progress">
<div class="progress-bar" style="width:20%">20%</div></div>
<p>Good (250-280)</p>
<div class="progress">
<div class="progress-bar" style="width:20%">20%</div></div>
<p>Fair</p>
<div class="progress">
<div class="progress-bar" style="width:10%">10%</div>
</div>
</div>
</div>
</div>
</section><br /><br />

<!-------- Register with us-------->

<section>
<div id="Registration">
<h3 align="center"> Register with us.</h3><br />
    <div id="form">
<form method="post" action=url("https://api.whatsapp.com/send?phone=2349071051151") autocomplete="off">
<h2><i>TRTOC REGISTRATION FORM</i></h2>
<b>Name:</b>
<input name="name" type="text" placeholder="surname middlename firstname"/><br/>
<b>Gender:</b><br />
<input type="radio" name="gender" value="male" /> Male <br />
<input type="radio" name="gender" value="female" /> Female <br />
<b>Janm Score:</b>
<input name="score" type="number"
placeholder="your Jamb score"/><br/><br />
<b>Jamb Reg:</b>
<input name="reg" type="text" placeholder="9616577HE"/><br/><br />
<b>Email Add:</b>
<input name="email" type="text" placeholder="email@example.com"/><br/><br>
<b>Password:</b>
<input name="password" type="password" placeholder="your password"/><br/><br />
<b>subjects Combination:</b><br/><br>
<input name="name" type="text" placeholder="Use of English"/><br/><br>
<input id="name" type="text" list="subjects" />
<datalist id="subjects">
   <option value="Biology">
   <option value="Chemistry">
   <option value="Physics">
   <Option value="Mathematics">
   <option value="Government">
   <option value="CRK">
   <option value="IRK">
   <option value="Literature">
   <option value="Account">
   <option value="Economics">
   <option value="commerce">
</datalist><br/><br />
<input id="name" type="text" list="subjects" />
<datalist id="subjects">
   <option value="Biology">
   <option value="Chemistry">
   <option value="Physics">
   <Option value="Mathematics">
   <option value="Government">
   <option value="CRK">
   <option value="IRK">
   <option value="Literature">
   <option value="Account">
   <option value="Economics">
   <option value="commerce">
</datalist><br/><br />
<input id="name" type="text" list="subjects" />
<datalist id="subjects">
   <option value="Biology">
   <option value="Chemistry">
   <option value="Physics">
   <Option value="Mathematics">
   <option value="Government">
   <option value="CRK">
   <option value="IRK">
   <option value="Literature">
   <option value="Account">
   <option value="Economics">
   <option value="commerce">
</datalist><br/><br />
<input type="submit" value="send"/>
</form>
</div>
    </div>
</section><br /><br />

<!------------------News--------------->

<section id="news">
    <div class="container">
        <h3>News</h3>
        <div>
        <p class="news1">
            Coming up soon, a webiner tagged: Expo 2020; a scholarship exposition pragramme targetted to revealing the obscure part about scholarships and everything attached to it.....
            <button type="button" class="btn btn-primary">Read more</button>
        </p><br/>
          <img src="https://i.ibb.co/pzTsNdv/IMG-20200516-WA0143.jpg" alt="IMG-20200429-142005" width="100%" height="300px"/><br /><br />
            <center>
                <marquee id="d" width="100%" bgcolor="00d7FF" style="color:#FF0000"scrollamount="4">Coming up soon<b>Expo 2020. </b> Chat +2349071051151 to register.</marquee>
            </center><br />
        <p class="news1">
            Coming up every Sunday, a programme tagged: <b>skill Up:</b> featuring; Graphic designing, Photo and Video editing, Animation, 3d logo, web developement.......
            <button type="button" class="btn btn-primary">Read more</button>
        
            </p><br />
            <img src="https://i.ibb.co/Fkrr2FC/IMG-20200429-142005.jpg" alt="IMG-20200429-142005" width="100%" height="500px"/><br /><br />
                <center>
                <marquee id="d" width="100%" bgcolor="00d7FF" style="color:#FF0000"scrollamount="4">Coming up every Sunday: <b>Skill Up. </b>8pm-10pm. Chat +2349071051151 to register.</marquee>
            </center><br />
            <b>Certificate to be issued on completion of the course(s)</b><br />    
            <img src="https://i.ibb.co/qmSFTfz/IMG-20200428-WA0051.jpg" alt="IMG-20200428-WA0051" width="100%" height="270px" border="2px dashed #007bff"/><br /><br />
            <p class="news2">Ongoing now is <b>Second semester:</b> April - September.Tagged: "Final War."......... <button class="btn btn-primary">Read more</button></p><br />
                
            <img src="https://i.ibb.co/gwbpvcN/FB-IMG-15869535145282196.jpg" alt="FB-IMG-15869535145282196" width="100%" height="500px"></a><br /><br />
             <center>
                <marquee id="d" width="100%" bgcolor="00d7FF" style="color:#FF0000"scrollamount="4">Coming up today by 12pm: <b>Post Utme Mock Exam. </b>Duration: 80minutes.</marquee>
            </center>
               <p class="p" align="center">
    "you can be perfect" </p>
        </div>
    </div>
</section><br /><br />

<!-------------Services------------>

<section id="services">
<div class="container">
<h1>Our Services</h1>
<div class="row services">
<div class="col-md-3 text-center">
<div class="icons">
<i class="fa fa-mobile"></i>    
</div>
<h3>Online Tutoring</h3>
<p>We make use of Social media platforms as learning field. Currently we have 12 classrooms on Whatsapp, a classroom on Telegram 2 Facebook pages and a Facebook account. </p>
</div>
<div class="col-md-3 text-center">
<div class="icons">
<i class="fa fa-book"></i>    
</div>
<h3>Tutorship</h3>
<p>We prepare University aspirants of the following faculties Clinical sciences ||
 Basic Medical Sciences || Public Health ||
Environmental Health Sciences || Dentistry || Egineering || Environmental Technology || Education || Pharmacy || Agriculture || Vet Medicine || & Sciences for UTME and Post UTME 
</p>
</div>
<div class="col-md-3 text-center">
<div class="icons">
<i class="fa fa-certificate"></i>    
</div>
<h3>Enterprenuership</h3>
<p>We empower our Students with technical skills that are in high demand, and we make sure they are certified upon completing the course(s).
</p>
</div>
<div class="col-md-3 text-center">
<div class="icons">
<i class="fa fa-download"></i>    
</div>
<h3>Android Apps</h3>
<p>We inform our students of apps that are instrumental on easy learning, thereby making learning fun. We also engage our students in online quizzes.
</p>
</div>
</div>
</div>
</section><br /><br /><br /><br />

<!-----------Our Tutors---->

<section id="tutors">
<div class="container">
<h1>Our Tutors</h1>
<div class="row">
<div class="col-md-3 profile-pic text-center">
<div class="img-box">
<img src="https://i.ibb.co/4pGr9jc/IMG-20200506-132411.jpg" class="img responsive" width="250px" height="250px">
<ul>
<a href="https://m.facebook.com/public/Moses-Adewolex"><li><i class="fa fa-facebook"></i></li></a>
<a href="https://mobile.twitter.com/emekatrill"><li><i class="fa fa-twitter"></i></li></a>
<a href="https://api.whatsapp.com/send?phone=2349034531220"><li><i class="fa fa-whatsapp"></i></li></a>
</ul>
<div>
<h2>Adewole Moses</h2>
<h3>Government Tutor</h3>
<p>Mr. Moses, a Public Administration student of Lagos State University has been very active in the Politics of his Instituition and of the Nation, with a brain like his, Student are sure to pass every exams. </p>
</div>
<div class="col-md-3 profile-pic text-center">
<div class="img-box">
<img src="https://i.ibb.co/JpF8Qqx/IMG-20200511-WA0059.jpg" class="img responsive" width="250px" height="250px">
<ul>
<a href="https://m.facebook.com/public/Mubarak-Alimi"><li><i class="fa fa-facebook"></i></li></a>
<a href="https://mobile.twitter.com/drlee"><li><i class="fa fa-twitter"></i></li></a>
<a href="https://api.whatsapp.com/send?phone=2347039248876"><li><i class="fa fa-whatsapp"></i></li></a>
</ul>
<div>
<h2>Mubarak Alimi Gbolagbade</h2>
<h3>Biology Tutor</h3>
<p>Mr Mubarak, popularly known as Dr. Lee is a medical student of University of Ibadan, he is a Media influencer and a Motivator.  His personality can be described as Vivacious and Voracious.</p>
</div>
<div class="col-md-3 profile-pic text-center">
<div class="img-box">
<img src="https://i.ibb.co/VgMXxqZ/IMG-20200428-090616.jpg" class="img responsive" width="250px" height="250px">
<ul>
<a href="https://m.facebook.com/public/Taiwo-Isiaka"><li><i class="fa fa-facebook"></i></li></a>
<a href="https://mobile.twitter.com/ebukataiwo"><li><i class="fa fa-twitter"></i></li></a>
<a href="https://api.whatsapp.com/send?phone=2349071051151"><li><i class="fa fa-whatsapp"></i></li></a>
</ul>
<div>
<h2>Isiaka Taiwo Samuel</h2>
<h3>Registrar and Physics Tutor</h3>
<p>Mr Taiwo is an Electrical electronics engineering student of University of Ibadan, Oyo, Nigeria. He is a seasoned tutor with great teaching skills and he his popularly known as "The best online tutor". </p>
</div>
<div class="col-md-3 profile-pic text-center">
<div class="img-box">
<img src="https://i.ibb.co/vPF3jB8/IMG-20200428-084553.jpg" class="img responsive" width="250px" height="250px">
<ul>
<a href="https://m.facebook.com/public/Isiaka-Kehinde"><li><i class="fa fa-facebook"></i></li></a>
<a href="https://mobile.twitter.com/emekatrill"><li><i class="fa fa-twitter"></i></li></a>
<a href="https://api.whatsapp.com/send?phone=2347054234162"><li><i class="fa fa-whatsapp"></i></li></a>
</ul>
<div>
<h2>Isiaka Kehinde Emmanuel</h2>
<h3>CEO</h3>
<p>Mr. Kenny, Chairman and Chief Executive Officer of TRTOC boost years of industry expertise and an inspirational commitment to our mission. Whithout leadership like this, we would not be who we are today. </p>
</div>
</div>
</div>
</section>

<!-----------Testimonials-------->
<section id="testimonials">
<div>
<h1>Testimonials</h1>
<p class="text-center">Read more about TRTOC</p>
<div class="profile2">
<img src="https://i.ibb.co/H4KDw10/IMG-20200429-130359.jpg" class="user"><br />
<q>TRTOC is indeed the best online College for Aspirants, The Tutors are <b>Catalyst</b>, they help lower your stress and speed up your success rate. I scored 316 and it was my first time. Thank God I found TRTOC.</q>
<h3>Emeite Richard</h3><h6><span>UI MB;BS Aspirant</span></h6>
</div> <br />
<div class="profile3">
<img src="https://i.ibb.co/V3zbNcd/IMG-20200512-130609.jpg" class="user"><br />
<q>I can assure you that TRTOC is the best online college for any student, No snubbing and No delay, they work on time..... In just two months you are through with the syllabus...... Don't lose this opportunity again, try them and never regret. God bless TRTOC.</q>
<h3>Obafemi Victor</h3><h6><span>OAU MB;BS Aspirant</span></h6>
</div><br />
<div class="profile2">
<img src="https://i.ibb.co/fdJWc2f/IMG-20200516-212238.jpg" class="user"><br />
<q>My first three day in this Great College, I've got to know what I would have missed. 
At TRTOC you learn with egg heads, if you ain't at TRTOC you can't be anywhere else.</q>
<h3>Samuel Francis</h3><h6><span>OAU MB;BS Aspirant</span></h6>
</div><br />
<div class="profile2">
<img src="https://i.ibb.co/7vKwH7g/IMG-20200512-153546.jpg" class="user"><br />
<q>TRTOC has become a testimony in my life. Ever since I join this College, I have become more active in academics. My hardest topics have now become my easiest and favorite topics. God bless TRTOC.</q>
<h3>Ogbonyomi Precious</h3><h6><span>FUTO Public Health Tech Aspirant</span></h6>
</div><br />
<div class="profile2">
<img src="https://i.ibb.co/GC94kmy/IMG-20200512-130524.jpg" class="user"><br />
<q>Joining TRTOC  isn't a mistake, The way they teach and explain makes one understand easily. There are some topics I find difficult and through this college I realized they were actually easy... God bless TRTOC.</q>
<h3>Adelowo David</h3><h6><span>UI MLS Aspirant</span></h6>
</div><br />
<div class="profile2">
<img src="https://i.ibb.co/n17Hv3K/IMG-20200516-211034.jpg" class="user"><br />
<q> 
I joined TRTOC not too long ago and to be frank and candid, I wish I had joined earlier. TRTOC as the name implies is truly 'The Right Tutors Online College'..Join the Family and thank me later.</q>
<h3>Olarewaju Olalekan</h3><h6><span>UI MB;BS Aspirant</span></h6>
</div><br />
<div class="profile1">
<img src="https://i.ibb.co/Jcy0qTz/IMG-20200512-130633.jpg" class="user"><br />
 <q>TRTOC is the best online college I have ever seen. This college is full of men and women who are ready to achieve the greatest echelon in academics with the help of their brilliant , committed intellectually empowered tutors.I must confess, joining TRTOC is the best thing I witnessed in my academic life after sec school.</q>
<h3>Stan Aristotle</h3><h6><span>UI MB;BS Aspirant</span></h6>
</div><br />
<div class="profile5">
<img src="https://i.ibb.co/fNpSV1P/IMG-20200516-200605.jpg" class="user"><br />
 <q>TRTOC is the paradise of knowledge and the best place to be if you’re looking for good understanding about your most dreaded subject or you want to learn more. Who doesn’t want to learn more? Nobody. Exactly! That’s why I recommend TRTOC. And I’m proud to be part of the family, the family that pushes you beyond your limits to bring the best out of you. Take my word as it is, TRTOC is the best. Thank you.</q>
<h3>Banjoko Olatilewa </h3><h6><span>UI PHARMACY  Aspirant</span></h6>
</div><br />
<div class="profile4">
<img src="https://i.ibb.co/7VXYK0w/IMG-20200516-WA0132.jpg" class="user"><br />
<q>Life is a guitar that you must learn to play it well so to produce a particular harmony or lyrics and TRTOC had created hers in my life. How I wish I had been in this college before my JAMB, I could have broken a record, but still not yet late.Good is not enough when best is available. With TRTOC you are covered and sure of your success with our tutors brain boxes <i>The Trills</i> and <i>Dr. Lee</i>. I must confess, I am proud of TRTOC. 
'A College like a frictionless machine'.</q>
<h3>Agu Chidubem Nichodemus</h3><h6><span>UI MB;BS Aspirant</span></h6>
</div><br />
</div>
</section>
<br /><br /><br />

<!--------------Get In Touch------------>

<section id="contact">
<div class="container">
<h1>Get In Touch</h1>  
<div class="row" >
<div class="col-md-6">
<form class="contacform"></form> 
<div class="form-group" >
<input type="text" class="form-control" placeholder="Your Name">
</div> 
<div class="form-group" >
<input type="number" class="form-control" placeholder="Phone no">
</div> 
<div class="form-group" >
<input type="email" class="form-control" placeholder="Email id">
</div> 
<div class="form-group" >
<textarea rows="4" class="form-control" placeholder="Your Message" type="message"></textarea>
</div> 
<button type="submit" class="btn btn-primary">Send Message</button>
</div>
<div class="col-md-6">
<form class="contact-info">
<div class="follow"><b> Adress:</b><i class="fa fa-map-marker"></i> 28, Major Salawu Road, Agbowo UI Area, Ibadan, Oyo, Nigeria.</div>
<div class="follow"><b> Phone:</b><i class="fa fa-phone"></i>  +2347 054 234 162;  +2349 071 051 151;</div>
<div class="follow"><b> Email:</b><i class="fa fa-envelope-o"></i> trtonlinecollege@gmail.com</div>
<div class="follow"><label><b> Get Social:</b></label>
<a href="https://m.facebook.com/pages/category/College---University/THe-Right-Tutors-online-College-111891590293956"/><i class="fa fa-facebook"></i></a>
<a href="https://api.whatsapp.com/send?phone=2349071051151"><i class="fa fa-whatsapp"></i></a>
<a href="#"><i class="fa fa-twitter"></i></a>
<a href="#"><i class="fa fa-google-plus"></i></a>
</div>
</form>
</div>
</div>
</div>
</section>

<!-------------Footer--------->

<section id="footer">
<div class="container text-center">
   <p><i class="fa fa-copyright"></i>copy; 2020 TRTOC. All rights reserved.</p>
</div>
</section>
</body>
</html>
<!----Isiaka Kehinde Emmanuel---->


