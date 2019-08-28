var global_volume = 0;
var menu_show     = true;
var current_page  = "loading";
var mySwiper;
var myRadioSwiper;
var play_radio = false;
var progress_bar = 0;
var progress_bar_duet = null;
var default_timer     = 9;
var babu_rao          = false;

$(document).ready(function(){

  var videos = ["4.mp4","5.mp4","6.mp4","7.mp4","8.mp4",
  "9.mp4","cartoon1.mp4","cartoon2.mp4","vlog1.mp4","update.mp4","program.mp4"];

  var titles = ["Ramzan is Love","Oyeee Kon hai Wohh! :D","Hahaha love is like :D","Football is love","125 :D Alaad","Awesome!",
  "MaShaAllah :)","Top and Jerry :D","Vlog","Program","New Update !"];

  var profiles = ["Waqas","Bilal","Asma","Haroon","Jalal",
  "Zuhair","Sharukh","Uzair","Julie","My Program","My News"];

  var desc  = ["<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#yahooo</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#hahahaha</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#YarYeDekhh!</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>",
"<b>#guys</b> thankyou so much for 40K fans and 11K heart <b>#foryoupage</b>"];



  var heart   = ["12k","34k","45k","100k","123k","44k","54k","105k","98k","105k","98k"];
  var comment = ["2.6m","5.4m","10m","11m","53m","58m","24m","32m","7.4m","105m","98m"];
  var share   = ["4.1k","6k","10k","14k","5.2k","8.6k","9.2k","10k","14k","105k","98k"];

  var media_time = ["","5 hrs <i class='fa fa-clock'></i>","6 hrs <i class='fa fa-clock'></i>","18 hrs <i class='fa fa-clock'></i>","8 hrs <i class='fa fa-clock'></i>",
  "6 mins <i class='fa fa-clock'></i>","8 mins <i class='fa fa-clock'></i>","18 mins <i class='fa fa-clock'></i>","<span class='live'>Live <i class='fa fa-circle'></i> &bull; <i class='fa fa-eye'></i> 1.6m</span>","<span class='live'>Live <i class='fa fa-circle'></i> &bull; <i class='fa fa-eye'></i> 3.7k</span>","<span class='live'>Live <i class='fa fa-circle'></i> &bull; <i class='fa fa-eye'></i> 10k</span>"];




  $(videos).each(function(i, value){
    if(i <= 3){
      $(".swiper-wrapper").append('<div class = "swiper-slide">'+
        '<video loop class="video_frame">'+ //poster="img/loader.gif"
         '<source src="videos/'+videos[i]+'" type="video/mp4">'+
        '</video>'+
        '<div class="my_captain">'+
          '<p class="name">'+titles[i]+'</p>'+
          '<p class="tag btn_profile" data-menu="menu-profile" data-menu-type="menu-box-top"><i class="fa fa-user-circle"></i> '+profiles[i]+' <span class="media_time">'+media_time[i]+'</span></p>'+
          '<p class="desc">'+desc[i]+'</p>'+
          '<div class="video_opt_container">'+
            '<div class="video_opt like"><i class="fa fa-heart"></i><span>'+heart[i]+'</span></div>'+
            '<div class="video_opt btn_comment"><i class="fa fa-comment"></i><span>'+comment[i]+'</span></div>'+
            '<div class="video_opt btn_share"><i class="fa fa-share-alt"></i><span>'+share[i]+'</span></div>'+
            '<div class="video_opt btn_duet"><img src="img/duet.png" /><span></span></div>'+
         '</div>'+
         '<marquee scrollamount="4" class="song_marquee" attribute_name="">'+
            '<img src="img/camera_opt/music.png" alt="" /> Micheal Jackson Song'+
         '</marquee>'+
         '<div class="marquee-disk">'+
          '<img src="img/music-disk.png" alt="" />'+
         '</div>'+
        '</div>'+
      '</div>');
    }
  });

  $(document).delegate(".btn_share","click",function(){
    navigator.share("A Video from live app","Share","plain/text");
  });

  $(document).delegate(".btn_duet","click",function(){
    $("#canvas").css("width","50%");
    $("#duet_video").fadeIn();
    $("#duet_video").children("source").attr("src","videos/"+videos[mySwiper.activeIndex]);
    $("#duet_video")[0].load();
    $("#duet_video")[0].play();
    setTimeout(function(){
      $("#duet_video")[0].pause();
    },500);

    progress_bar = 0; //to start progess from 0
    $(".progress_bar").css("width","1px");

    navigate("plus");
    try{
      var options = {
          cameraFacing: 'front',
          fps: 10,
      };
      window.plugin.CanvasCamera.start(options);
    }catch(e){}
    $(".bottom_nav").animate({bottom: "-50px"},750);

    //navigate("duet");

  });



  $(document).delegate(".btn_comment","click",function(){
    $(".video_comment").fadeIn();

    setTimeout(function(){
      $(".comment_input").focus();
    },150);
  });

  $(document).delegate(".video_frame","click",function(){
    $(".video_comment").fadeOut();
  });

  $(".comment_form").submit(function(e){
    e.preventDefault();
    var comment = $(".comment_input").val();
    if(comment.length > 0){
      $(".comments_here").append("<p comment_id='"+comment_id+"'><strong>@abbassified</strong> "+comment+"</p>");
      $(".comment_input").val("");
      $(".comments_here").scrollTop($(".comments_here")[0].scrollHeight);

      setTimeout(function(){
        //$(".comment_input").focus();
      },150);
    }
  });

  var comment_id = 0;
  $(".love_send_btn").click(function(e){

    var comment = "💗";
    if(comment.length > 0){
        comment_id++;

        $(".comments_here").append("<p comment_id='"+comment_id+"'><strong>@abbassified: </strong>"+comment+"</p>");
        $(".comment_input").val("");
        $(".comments_here").scrollTop($(".comments_here")[0].scrollHeight);

        setTimeout(function(){
          //$(".comment_input").focus();
        },150);
    }
  });

  $(".nav_lock").click(function(){
    swal({
        title: "This category is locked!",
        text: "Share app with 10 friends to unlock",
        icon: "warning",
        buttons: false,
    });
  });






  //pre load for better UI UX
  setTimeout(function(){
    $(".video_frame").each(function(index, elem){
      //$(".video_frame")[index].play();
      setTimeout(function(){
        if(index != 0){
          //$(".video_frame")[index].pause();
        }
      },100);
    });
  },500);




  var camera_mode = "back";
  $(".camera_toggle").click(function(){
    if(camera_mode == "back"){
      camera_mode = "front";
    }else{
      camera_mode = "back";
    }
    window.plugin.CanvasCamera.cameraPosition(camera_mode);
  });

  var camera_flash = false;
  $(".flash_toggle").click(function(){
    if(camera_flash == false){
      camera_flash = true;
    }else{
      camera_flash = false;
    }
    window.plugin.CanvasCamera.flashMode(camera_flash);
  });

  //$(".live_app_page").hide();

  //App started
  setTimeout(function(){
    $(".pre-loader").fadeOut(function(){
      //$(".category_active").children("span").slideDown();

      //little fun
      $(".menu_expand").animate({top: "4px"},750);
      //$(".video_category").animate({top: "0px"},750);
      $(".bottom_nav").animate({bottom: "0px"},750);
    });
    navigate("home");
  },1000);

  function go_back(){
    if(current_page == "loading"){

    }else if(current_page == "home"){

    }else if(current_page == "updates"){

    }else if(current_page == "programs"){

    }else if(current_page == "flims"){

    }else if(current_page == "documentry"){

    }else if(current_page == "vlogs"){

    }else if(current_page == "memes"){

    }else if(current_page == "cartoon"){

    }else if(current_page == "radio"){

    }else if(current_page == "blogs"){

    }else if(current_page == "article"){

    }else if(current_page == "review"){

    }else{

    }
  }
  function show_page(page){
    $(".live_app_page").hide();
      $(".pre-loader").show();
      setTimeout(function(){
        $(".pre-loader").hide();
        $("."+page).show();
        $(".pre-loader").fadeOut();
      },200);
  }
  function navigate(page){
    current_page = page;
    pause_all();
    $("#radio")[0].pause();
    $("#control_icons").hide();
    $(".bottom_nav").animate({bottom: "0px"},750);

    if( page == "home" || page == "updates" ||   page == "flims" ||
        page == "documentry" || page == "vlogs" || page == "memes" ||
        page == "cartoon"){
          var random_i = 1;
      if(page == "home"){
        random_i = 1;
      }else if(page == "updates"){
        random_i = 10;
      }else if(page == "flims"){
        random_i = 2;
      }else if(page == "documentry"){
        random_i = 4;
      }else if(page == "vlogs"){
        random_i = 8;
      }else if(page == "memes"){
        random_i = 2;
      }else if(page == "cartoon"){
        random_i = 6;
      }

      mySwiper.slideTo(random_i, 0, false);
      $(".video_frame")[random_i].play();
      //$(".video_frame")[mySwiper.activeIndex].play();

      show_page("page_home_videos");

      play_effect();

    }else if(page == "programs"){
      show_page("page_programs");
    }else if(page == "radio"){
      show_page("page_radio");

      /*
      myRadioSwiper = new Swiper('.swiper2', {
         paginationClickable: true,
         pagination:'.radio-pagination',
         effect: 'cube', //flip
         //mousewheel: true,
         grabCursor: true,
         cubeEffect: {
           shadow: true,
           slideShadows: true,
           shadowOffset: 20,
           shadowScale: 0.94,
         },
         direction:"vertical",
         watchActiveIndex: true,
         loop: false,
         onSlideChangeStart: function (swiper) {
         },onSlideChangeEnd: function (swiper) {

         }
      });*/

      $("#radio")[0].play();
      play_radio = true;
      $(".btn_radio_toggle").removeClass("fa-play").addClass("fa-pause");


      $(".radio_ui .listeners").hide();
      $(".radio_ui .listeners").html("<i class='fa fa-headphones'></i> Use headphones for better experience");
      $(".radio_ui .listeners").slideDown(function(){

        setTimeout(function(){
          $(".radio_ui .listeners").slideUp(function(){
            $(".radio_ui .listeners").html("<i class='fa fa-headphones'></i> 1.5k Listeners");
            $(".radio_ui .listeners").slideDown();
          });
        },2000);



      });




    }else if(page == "article"){
      show_page("page_article");
    }else if(page == "review"){
      show_page("page_review");
    }else if(page == "blogs"){
      show_page("page_blogs");
    }else if(page == "profile"){
      show_page("page_profile");
    }else if(page == "noti"){
      show_page("page_noti");
    }else if(page == "plus"){
      show_page("page_plus");
    }else if(page == "mic"){
      show_page("page_mic");

      setTimeout(function(){
        $(".radio_demo").slideUp(function(){
          $(".radio_demo").html('<i class="fa fa fa-check"></i>'+
          '<span>Radio Started!</span><br />'+
          '<span><i style="display:inline; font-size:12px;" class="fa fa-headphones"></i> 3 Listeners</span>');

          $(".radio_demo").append('<img src="img/record.gif" style="width: 100%" />');

          $(".radio_demo").slideDown();
        });
      },3000);
    }else if(page == "write"){
      show_page("page_write");
    }else if(page == "search"){
      show_page("search");

      var map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -34.397, lng: 150.644},
        zoom: 8
      });

    }else if(page == "pictures"){
      show_page("pictures");
    }else if(page == "mugic"){
      show_page("mugic");
    }else if(page == "duet"){
      show_page("duet");
    }else if(page == "video_step_2"){
      show_page("video_step_2");
    }





    console.log({current_page});
  }
  function pause_all(){
    $(".video_frame").each(function(index, elem){
      if($(".video_frame")[index].paused == false){
        $(".video_frame")[index].pause();
        $(".video_frame").css("opacity",0);
      }
    });
    //pause_effect();
  }
  var paused_video = null;

  function play_effect(){
    $("#control_icons").show();
    $("#control_icons").children("img").css("width","70px");
    $("#control_icons").children("img").css("opacity","1");
    $("#control_icons").children("img").attr("src","img/play.png");
    $("#control_icons").children("img").animate({width: "96px", opacity: 0},500);
    setTimeout(function(){
      $("#control_icons").hide();
    },500);
  }
  function pause_effect(){
    $("#control_icons").show();
    $("#control_icons").children("img").css("width","96px");
    $("#control_icons").children("img").css("opacity","0");
    $("#control_icons").children("img").attr("src","img/pause.png");
    $("#control_icons").children("img").animate({width: "70px", opacity: 0.9},250);
  }
  var toggle_like = true; //global
  function like_effect(toggle_like){

    if(toggle_like == true){
      $("#control_icons").children("img").attr("src","img/like-done.png");
      $(".like").children("i").addClass("heart-fill");
      toggle_like = false;
    }else{
      $("#control_icons").children("img").attr("src","img/like.png");
      $(".like").children("i").removeClass("heart-fill");
      toggle_like = true;
    }

    $("#control_icons").show();
    $("#control_icons").children("img").css("width","70px");
    $("#control_icons").children("img").css("opacity","1");
    $("#control_icons").children("img").animate({width: "96px", opacity: 0},1000);
    setTimeout(function(){
      $("#control_icons").hide();
    },1000);

    return toggle_like;
  }
  var myApp = new Framework7();

  function restart_swiper(direction){
    mySwiper = myApp.swiper('.swiper1', {
       //paginationClickable: true,
       //pagination:'.swiper-pagination',
       //effect: 'cube', //flip
       //mousewheel: true,
       /*grabCursor: true,
       cubeEffect: {
         shadow: true,
         slideShadows: true,
         shadowOffset: 20,
         shadowScale: 0.94,
       },*/
       direction:direction,
       watchActiveIndex: true,
       loop: false,
       onSlideChangeStart: function (swiper) {
          pause_all();
       },onSlideChangeEnd: function (swiper) {
          console.log("Playing: "+swiper.activeIndex);
          $("#control_icons").hide();
          menu_show = true;
          $(".video_frame").animate({opacity:1},250);
          setTimeout(function(){
            $(".video_frame")[swiper.activeIndex].play();
          },250);
       }
    });
  }
  restart_swiper("vertical");
  //restart_swiper("horizontal");



  $(".btn_volume").click(function(){
    if(global_volume != 0){
      $(".btn_volume").children("i").removeClass("fa-bell").addClass("fa-bell-slash");
      global_volume = 0;

      swal({
          title: "Muted",
          text: " ",
          icon: "warning",
          buttons: false,
          timer:2000,
      });
    }else{
      $(".btn_volume").children("i").removeClass("fa-bell-slash").addClass("fa-bell");
      global_volume = 80;

      swal({
          title: "Unmuted",
          text: " ",
          icon: "success",
          buttons: false,
          timer:2000,
      });
    }

    $(".bottom_nav_volume").css("width",global_volume+"%");
    try{
      window.androidVolume.setMusic(global_volume, false, function(success){
        //alert(global_volume);
      }, function(error){
        //alert("ERROR UP");
      });
    }catch(e){}

  });

  $(".btn_replay").click(function(){
    $(".video_frame")[mySwiper.activeIndex].load();
    $(".video_frame")[mySwiper.activeIndex].play();
  });


  $(".btn_radio_toggle").click(function(){
    if(play_radio == true){
      $("#radio")[0].pause();
      play_radio = false;
      $(".btn_radio_toggle").removeClass("fa-pause").addClass("fa-play");
      pause_effect();
      $(".second_half").css("background","url(../img/record.gif)");
    }else{
      $("#radio")[0].play();
      play_radio = true;
      $(".btn_radio_toggle").removeClass("fa-play").addClass("fa-pause");
      play_effect();
      $(".second_half").css("background","");

    }
  });

  $(".btn_radio_prev, .btn_radio_next").click(function(){
    $(".radio_ui").fadeOut("fast",function(){
      $(".radio_ui").fadeIn();
    });
  });




  setTimeout(function(){
    //mySwiper.slideTo(2, 0, false);
  },5000);


  $("#control_icons").click(function(){
    $(paused_video)[0].play();
    play_effect();
  });

  var check_dbl_click = false;

  var click_watch = null;
  var click_count = 0;
  $('.video_frame').click(function() {
    var this_ = this;
    click_count++;
    try{clearTimeout(click_watch);}catch(e){}
    click_watch = setTimeout(function(){
      if(click_count == 1){
        $("#control_icons").fadeIn();
        if(this_.paused){

          pause_all();
          this_.play();
          play_effect();
        }else{
          this_.pause();
          pause_effect();
          paused_video = $(this_);
        }
      }else{
        toggle_like = like_effect(toggle_like);
      }
      click_count = 0; //reset
    },300);
  });


  $(".menu_expand").click(function(){
    if(menu_show == true){
      $(".menu_list").slideDown("fast");
      //$(".menu_list").css("top","-50px");
      //$(".menu_list").css("opacity","0");
      //$(".menu_list").animate({top: "-43px", opacity: "1"},250);
      menu_show = false;
      //pause_all();
    }else{
      $(".menu_list").slideUp("fast");
      menu_show = true;
    }
  });

  $(".set_category").click(function(){
    var this_ = $(this);
    pause_all();

    $(".bottom_nav").animate({bottom: "-60px"},250);

    $(".pre-loader").fadeIn(function(){
      setTimeout(function(){
        $(".category").removeClass("category_active");
        $(this_).addClass("category_active");

        var count = $(".swiper-slide").length-1;
        var random_i = Math.floor((Math.random() * count) + 1);
        mySwiper.slideTo(random_i, 0, false);
        $(".video_frame")[random_i].play();
        $("#control_icons").hide();

        $(".bottom_nav").animate({bottom: "0"},500);

        $(".pre-loader").fadeOut();

        /*
        swal({ //yahan
          //title: $(".category_active").children("span").text(),
          text: "Getting the '"+$(".category_active").children("span").text()+"' category..",
          icon: "img/load.gif",
          button:false,
          timer:750,
        });
        */

        /*
        $(".category_active").children("span").slideDown();
        setTimeout(function(){
          $(".category").children("span").fadeOut();
        },1500);
        */

      },200);
    });
  });

  $(".menu_item").click(function(){
    var icon = $(this).children("i").attr("class");

    setTimeout(function(){
        $(".menu_expand").children("i").slideUp();
    },250);

    setTimeout(function(){
        $(".menu_expand").children("i").attr("class",icon);
        $(".menu_expand").children("i").slideDown();
    },500);

    $(".menu_item").removeClass("menu_item_active");
    $(this).addClass("menu_item_active");

    $(".menu_list").fadeOut("fast");
    menu_show = true;
  });




  //navigation
  $(".nav_home").click(function(){
      navigate("home");
  });
  $(".nav_updates").click(function(){
      navigate("updates");
  });
  $(".nav_programs").click(function(){
      navigate("programs");
  });
  $(".nav_short_flims").click(function(){
      navigate("flims");
  });
  $(".nav_documentry").click(function(){
      navigate("documentry");
  });
  $(".nav_vlogs").click(function(){
      navigate("vlogs");
  });
  $(".nav_memes").click(function(){
      navigate("memes");
  });
  $(".nav_cartoon").click(function(){
      navigate("cartoon");
  });
  $(".nav_radio").click(function(){
      navigate("radio");
  });
  $(".nav_blogs").click(function(){
      navigate("blogs");
  });
  $(".nav_article").click(function(){
      navigate("article");
  });
  $(".nav_review").click(function(){
      navigate("review");
  });

  $(".btn_profile").click(function(){
      navigate("profile");
  });
  $(".btn_noti").click(function(){
      navigate("noti");
  });
  $(".nav_search").click(function(){
      navigate("search");
  });
  $(".nav_pictures").click(function(){
      navigate("pictures");
  });
  $(".nav_mugic").click(function(){
      navigate("mugic");
  });



  $(".btn_plus").click(function(){
      if(current_page == "home" ||
      current_page == "updates" ||
      current_page == "programs" ||
      current_page == "flims" ||
      current_page == "documentry" ||
      current_page == "vlogs" ||
      current_page == "memes" ||
      current_page == "cartoon"){

        $("#canvas").css("width","100%");
        $("#duet_video").hide();
        $("#duet_video").children("source").attr("src","");


        navigate("plus");
        try{
          var options = {
              //cameraPosition: 'front',
              cameraFacing: 'front',
              fps: 10,
          };
          window.plugin.CanvasCamera.start(options);
        }catch(e){}
        $(".bottom_nav").animate({bottom: "-50px"},750);

      }else if(current_page == "radio"){
          navigate("mic");
      }else if(current_page == "blogs"){
          navigate("write");
      }else if(current_page == "article"){
          navigate("write");
      }else if(current_page == "review"){
          navigate("write");
      }else{

      }
  });

  $(".like").click(function(){


    if(toggle_like == true){
      //var likes = +$(this).children("span").text();
      //$(this).children("span").text(likes+1);
    }else{
      //var likes = +$(this).children("span").text();
      //$(this).children("span").text(likes-1);
    }

    toggle_like = like_effect(toggle_like);
  });




  $(".nav-3").click(function(){
    $(".nav-3").removeClass("nav-3-active");
    $(this).addClass("nav-3-active");
  });
});

function volumeupbutton(){
  if(global_volume >= 100){
    global_volume = 100;
  }else{
    global_volume += 10;
  }

  $(".bottom_nav_volume").css("width",global_volume+"%");
  window.androidVolume.setMusic(global_volume, false, function(success){
    //alert(global_volume);
  }, function(error){
    //alert("ERROR UP");
  });
}
function volumedownbutton(){
  if(global_volume <= 0){
    global_volume = 0;
  }else{
    global_volume -= 10;
  }

  $(".bottom_nav_volume").css("width",global_volume+"%");
  window.androidVolume.setMusic(global_volume, false, function(success){
    //alert(global_volume);
  }, function(error){
    //alert("ERROR DOWN");
  });
}

$(".show_effect_tab").click(function(){
  $(".effect_tab").slideDown();
});

var effect_tab = 1;
$(".effect_tab img").click(function(){
  if(effect_tab < 5){
    effect_tab++;
  }else{
    effect_tab = 1;
  }
  $(".effect_tab img").attr("src","img/camera_opt/effect_tab_"+effect_tab+".png");
});

$("#canvas").click(function(){
  $(".effect_tab").fadeOut();
  $(".settings_box").fadeOut();
});
$(".filter_opt").click(function(){
  $(".filter_opt").removeClass("filter_opt_selected");
  $(this).addClass("filter_opt_selected");
});


$(".timer_input").on("input",function(){
  default_timer = +$(this).val();
  $(".default_timer").text(default_timer+" secs");
});

$(".show_gallery_tab").click(function(){
  $(".gallery_attachment").click();
});

$(".gallery_attachment").change(function(){
  swal({
    title: "One monent..",
    text: "Getting your video ready",
    icon: "img/load.gif",
    button:false,
    timer:2000,
  });
});

$(".add_sound, .add_video").click(function(){
  $(".sound_tab").slideDown();
  $(".sound_tab img").attr("src","img/camera_opt/add_sound.png");
});

$(document).delegate(".marquee-disk, marquee","click",function(){
  //$(".btn_plus").click();
  $(".sound_tab").slideDown();
  $(".sound_tab img").attr("src","img/camera_opt/add_sound.png");
});

var sound_tab_clicks = 0;
$(".sound_tab").click(function(){
  if(sound_tab_clicks == 0){
    $(".sound_tab img").attr("src","img/camera_opt/add_sound_2.png");
    sound_tab_clicks++;
    $('.sound_player')[0].load();
    $('.sound_player')[0].play();
  }else{
    sound_tab_clicks = 0;
    $(".sound_tab").slideUp();
    $('.sound_player')[0].pause();
    $('.sound_player')[0].load();

    babu_rao = true;
    //babu rao
    default_timer = 6.5;
  }
});

$(".demo_loading").click(function(){
  swal({
    icon: "img/load.gif",
    button:false,
    timer:1000,
  });
});

var demo_beauty = false;
$(".demo_beauty").click(function(){
  var demo_beauty_text = "";
  if(demo_beauty == false){
    demo_beauty = true;
    swal({
      text: "Beauty mode is ON",
      icon: "success",
      button:false,
      timer:1000,
    });

    $(this).children("img").attr("src","img/camera_opt/beauty.png");
  }else{
    demo_beauty = false;
    swal({
      text: "Beauty mode is OFF",
      icon: "info",
      button:false,
      timer:1000,
    });
    $(this).children("img").attr("src","img/camera_opt/beauty-off.png");
  }

});



//var demo_speed = 0;
$(".demo_speed").click(function(){
  $(".settings_box").hide();

  //if($(".camera_speed").is(":visible")){
    //$(".camera_speed").fadeOut();
  //}else{
    $(".camera_speed").fadeIn();
  //}

});
$(".demo_filter").click(function(){
  $(".settings_box").hide();
  $(".filter_box").fadeIn();
});




$(".speed_opt").click(function(){
  $(".speed_opt").removeClass("speed_opt_seleted");
  $(this).addClass("speed_opt_seleted");
});

//var demo_timer = 3;
$(".demo_timer").click(function(){
  $(".settings_box").hide();
  $(".timer_box").fadeIn();

  $(".default_timer").text(default_timer+" secs");

  /*if(demo_timer < 12){
    demo_timer += 3;
  }else{
    demo_timer = 3;
  }
  $(this).children("p").children("small").html(demo_timer+"x");
  */
});

$(".demo_volume").click(function(){
  $(".settings_box").hide();
  $(".volume_box").fadeIn();
});

$(".demo_Aa").click(function(){
  $(".settings_box").hide();
  $(".Aa_box").fadeIn();
});






var make_opacity = ".camera_opt_top, .camera_opt_right, .show_effect_tab, .show_gallery_tab";

var btn_native_camera   = document.getElementById("btn_native_camera");
btn_native_camera.addEventListener('touchstart', function(){
  $(".settings_box").fadeOut();

  $(make_opacity).animate({
    opacity:0.05
  },500);

  if(babu_rao == true){
    $('.sound_player')[0].play();
  }

  $("#duet_video")[0].play();
  //$("#canvas").css("height",$("#duet_video").height()+"px");
  //console.log($("#duet_video").height());
  progress_bar_allow = true;
  progress_bar_duet = setInterval(function(){
      console.log("true");

      progress_bar+=0.1;
      if(progress_bar >= default_timer){
        swal({
          //title: "Top result:",
          text: "Please wait..",
          icon: "img/load.gif",
          button:false,
          timer:2000,
        }).then((value) => {
          progress_bar = 0;

          $(make_opacity).animate({
            opacity:1
          },500);

          clearInterval(progress_bar_duet);
          swal({
            title: "Publish Video ?",
            text: "Saved saved in gallery!",
            icon: "info",
            buttons: true,
            dangerMode: false,

            buttons: ["Reshoot", "Next"],
          }).then((value) => {
            swal.close();
            if(value != null){
              //navigate("video_step_2");
              var page = "video_step_2";
              $(".live_app_page").hide();
              $(".pre-loader").show();
              setTimeout(function(){
                $(".pre-loader").hide();
                $("."+page).show();
                $(".pre-loader").fadeOut();
              },200);
            }else{}
          });
        });
      }

      var percentage = (progress_bar*100)/default_timer;
      $(".progress_bar").width(percentage+"%");
  },100);
  $("#btn_native_camera").addClass("fa-spin");
},false);
btn_native_camera.addEventListener('touchend', function(){

  $(make_opacity).animate({
    opacity:1
  },500);

  if(babu_rao == true){
    $('.sound_player')[0].pause();
  }


  $("#duet_video")[0].pause();
  clearInterval(progress_bar_duet);
  $("#btn_native_camera").removeClass("fa-spin");
},false);



$(".btn_native_camera").click(function(){
  /*
  var options = {limit: 1,duration: 5};
  navigator.device.capture.captureVideo(function(mediaFiles) {

    videoPath = mediaFiles[0].fullPath;
    var options = new FileUploadOptions();
    options.fileKey = "file";
    options.fileName = videoPath.substr(videoPath.lastIndexOf('/') + 1);
    options.mimeType = "video/mp4/3gp";

    $(".new_video").attr("src",videoPath);

    */

    setTimeout(function(){
      /*
      mySwiper.appendSlide('<div class = "swiper-slide">'+
        '<video loop class="video_frame" poster="img/loader.gif">'+
         '<source src="'+videoPath+'" type="video/mp4">'+
        '</video>'+
        '<div class="my_captain">'+
          '<p class="name">My Video</p>'+
          '<p class="tag btn_profile" data-menu="menu-profile" data-menu-type="menu-box-top"><i class="fa fa-user-circle"></i> Ghulam Abbass <span class="media_time">Just now <i class="fa fa-clock"></i></span></p>'+
          '<p class="desc">Hey this is my first live video</p>'+
          '<div class="video_opt_container">'+
            '<div class="video_opt like"><i class="fa fa-heart"></i><span>1</span></div>'+
            '<div class="video_opt"><i class="fa fa-comment"></i><span>0</span></div>'+
            '<div class="video_opt"><i class="fa fa-share-alt"></i><span>0</span></div>'+
         '</div>'+
        '</div>'+
      '</div>');
      */

      //navigate("home");
    },3000);

    /*var params = new Object();
    params.profile_id  = global_id;
    params.edit_profile	= "true";
    params.profile_pic 	= "true";
    options.params = params;
    options.chunkedMode = false;
    var ft = new FileTransfer();
    $(".profile_btn_camera").html("<i class='fa fa-circle-o-notch fa-spin'></i>");
    $(".profile_photo, .global_photo").attr("src","images/face.gif");
    */

    /*
    $(".profile_photo").hide();
    $(".my_profile_canvas").show();
    $(".my_profile_canvas").css("display","block");
    video_to_image(videoPath,"my_profile_canvas");
    */

    /*
    ft.upload(videoPath, base_url+"get_profile.php", function(result){

      cordova.plugins.notification.local.schedule({
        title: 'Face ID Video Uploaded',
        progressBar: { value: 100 }
      });

      $(".profile_photo, .global_photo").attr("src","images/face.png");

      //$(".global_photo").attr("src","images/default_image.jpg");
      $(".profile_btn_camera").html("<i class='fa fa-camera'></i>");
    }, function(error){
      //alert(JSON.stringify(error));
     }, options);
     */



     /*
  }, function(error) {
  }, options);
  */

});


var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
        document.addEventListener("volumeupbutton", volumeupbutton, false);
        document.addEventListener("volumedownbutton", volumedownbutton, false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        this.receivedEvent('deviceready');

        var objCanvas = document.getElementById('canvas');
        window.plugin.CanvasCamera.initialize(objCanvas);

        window.androidVolume.getMusic(function(success){
          global_volume = success;
          $(".bottom_nav_volume").css("width",global_volume+"%");
        }, function(error){
          //alert(JSON.stringify(error));
        });


        setTimeout(function(){

          //Signup
          /*
          swal({
            //title: "Top result:",
            //text: "hello",
            icon: "img/load.gif",
            button:false,
            timer:2000,
          }).then((value) => {
          */

            /*
            swal({
                title: "Hey, Ghulam!",
                text: "Is 'ghulamabbass.1995@gmail.com' your email ?",
                icon: "info",
                buttons: true,
                dangerMode: false,
                buttons: ["No!", "Aww yess!"],
            }).then((value) => {
              swal.close();
              */

              //if(value != null){
                /*Fingerprint.isAvailable(isAvailableSuccess, isAvailableError);
                function isAvailableSuccess(result) {
                  Fingerprint.show({
                    clientId: "Fingerprint-Demo",
                    clientSecret: "password" //Only necessary for Android
                  }, successCallback, errorCallback);

                  function successCallback(){
                    swal({
                      title: "Welcome, Ghulam!",
                      text: "Welcome to Live App",
                      icon: "success",
                      buttons: false,
                    });
                  }
                  function errorCallback(err){
                    swal.close();
                    */
                    /*swal({
                      title: "Authentication invalid",
                      text: err,
                      icon: "warning",
                      buttons: false,
                    });*/
                  /*}
                }

                function isAvailableError(message) {
                  alert(message);
                }*/

              //}

            //});
          //});
        },2000);
  },
  // Update DOM on a Received Event
  receivedEvent: function(id) {
  }
};

app.initialize();
