// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require tablefilter_all_min




function altRows(id){
    if(document.getElementsByTagName){
       var table = document.getElementById(id);
       var rows = table.getElementsByTagName("tr");

       for(var i = 0; i < rows.length; i++){
           if(i % 2 == 0 || rows.length <= 1){
               rows[i].className = "evenRow"
           }else{
               rows[i].className = "oddRow"
           }
       }
    }
}


window.onload = function(){
    altRows("altColors");
    setFilterGrid("filter");


    //The following functions are called for the reports screen
    altRows("altColors1");
    setFilterGrid("filter1");

    altRows("altColors2");
    setFilterGrid("filter2");

    altRows("altColors3");
    setFilterGrid("filter3");

    altRows("altColors4");
    setFilterGrid("filter4");
}
