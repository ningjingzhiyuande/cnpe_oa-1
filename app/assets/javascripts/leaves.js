$(function() {

 	 $(".leave_kind").click(function(){   
 	 	var ids = [];
       
   	    data_id=$(this).attr("data-id");
   	    if(!is_annual && data_id=="0"){
   	    	alert("按照规定：请事假累计14天(含),没有年休假，或者工作满1-10年，病假>=2个月的没有年休假，工作满10-20年，病假>=3个月的没有年休假，工作满20年以上，病假>=4个月的没有年休假")
   	       $(this).prop("checked",false)
   	    }
   	     if(data_id=="0" && total_nj_day==0){
   	    	alert("您已经没有年假了,如果有问题请联系管理员。")
   	       $(this).prop("checked",false)
   	    }
   	    if(total_hj_day!=10 && data_id=="4"){
   	    	alert("按照规定：必须晚婚晚育才能休含奖励的假期")
   	       $(this).prop("checked",false)
   	    }
   	     if(total_hj_day==0 && data_id=="6"){
   	    	alert("请找管理员设置您的出生日期")
   	       $(this).prop("checked",false)
   	    }
   	        

        if($(this).prop("checked")){
          $("li.kind_"+data_id).show();
        }else{
        	 $("li.kind_"+data_id).hide();
        	 $("#start_at_"+data_id).val("");
             $("#end_at_"+data_id).val("");
        }        
        
   });

 $(".half_day_radio").change(function() { 
 	var data_id = $(this).attr("data-id");
    select_for_speical_day(data_id);
}); 


//计算请假当天的日期处理是半天还是一天
  function cal_today_work_time(date_at){
  	
  	 date = date_at
  	 rest_day=cal_rest_on_work_day(date,1)
  	 if(rest_day==1){
  	 	return 0
  	 }
  	 real_hour = date.getHours();
     if(real_hour<8 || real_hour >19){
         return 0
     }    
  	  hour = Math.abs(18-date.getHours()); 	
  	  if(hour<1){
  	  	return 0
  	  }else if(hour<7){
  	  	return 0.5
  	  }else{
  	  	return 1
  	  }
  }
  function cal_today_work_time_radio(data_id,is_start){
  	 var day = 0;
     var s_hour = $(".start_at_half_day_"+data_id+":radio:checked").val();
     var e_hour = $(".end_at_half_day_"+data_id+":radio:checked").val();
     if(is_start){
     	if(s_hour=="1"){day=day+1}else{day=day+0.5}
     	return day
     }else{
     	if(e_hour=="1"){day=day+0.5}else{day=day+1}
        return day

     }
     
  	
  }
//计算公休假和请假的时间
   function cal_rest_on_work_day(start_at,diff_day){
   	  var i;
   	  var rest=0;
   	  var work=0;
   	  var weekends = 0;
     for(i=0;i<diff_day;i++){
       //  var day = new Date(start_at.getFullYear()+"/"+(start_at.getMonth()+1)+"/"+(start_at.getDate()+i)+" 00:00:00");     
       start_at.setDate(start_at.getDate()+1)  //
       day = start_at.getFullYear()+"/"+(start_at.getMonth()+1)+"/"+(start_at.getDate());  
       
       console.log(start_at)
       if(jQuery.inArray(day, rest_days)>=0){
         	rest=rest+1;
         }
        if(jQuery.inArray(day,work_days)>=0){
         	work +=1;
         }
     
         if(new Date(day).getDay()==0 || new Date(day).getDay()==6){
         	weekends+=1
         }
      }
      console.log(rest+weekends)
      console.log(work)
      return [rest+weekends,work]
   }

   function is_work_day(date){
   	    day = date.format("yyyy/mm/dd");
   	    if(new Date(day).getDay()==0 || new Date(day).getDay()==6){
         	if(jQuery.inArray(day,work_days)>=0){
         	    return true;
         	}  
         	return false;          
         }else{
   	       if(jQuery.inArray(day, rest_days)>=0){
         	return false
            }
            return true
        }

   }
 //计算请假的日期
   function cal_diff_time(data_id){
   	    var work=0;
   	    var s_at = $(".start_at_"+data_id).val();
        var e_at = $(".end_at_"+data_id).val();
        if(s_at!="" && e_at!=""){
        	var start_at = new Date(s_at);
            var end_at = new Date(e_at);
            var	diff = end_at - start_at
            var vdaysdiff = Math.floor(diff/1000/60/60/24);  // in days
            console.log("vdaydiff:"+vdaysdiff)
            for(var i=0;i<=vdaysdiff;i++){
                  console.log("work_flag:"+is_work_day(start_at))
                  console.log("start_at:"+start_at)
                 if(is_work_day(start_at)){
                 	if(i==0){
                 		work = work+cal_today_work_time_radio(data_id,true);
                 		start_at.setDate(start_at.getDate()+1)
                 		continue;
                 	}
                 	if(i==vdaysdiff){
                 	     work = work+cal_today_work_time_radio(data_id,false);
                 	     break;
                 	}
                 	work = work+1;
                 	
                 }
                start_at.setDate(start_at.getDate()+1)

            }
        }
        return work
       /* var start_at = new Date(s_at);
        var end_at = new Date(e_at);
        var s_e_hour = cal_today_work_time_radio(data_id);
        //var e_hour = cal_today_work_time_radio(data_id);
     
        //console.log("call_diff_time:"+start_at)
        var n_s_day = start_at//.setDate(start_at.getDate()+1) //new Date(start_at.getFullYear()+"/"+(start_at.getMonth()+1)+"/"+(start_at.getDate()+1)+" 00:00");
        var p_e_day = end_at//.setDate(start_at.getDate())  //new Date(end_at.getFullYear()+"/"+(end_at.getMonth()+1)+"/"+end_at.getDate()+" 00:00");
        
       
        
        console.log("ns_day"+n_s_day)
        var rest_work_day= cal_rest_on_work_day(n_s_day,vdaysdiff);
        var rest_day = rest_work_day[0]
        var work_day = rest_work_day[1]
        console.log(s_e_hour)
        return vdaysdiff+s_e_hour-rest_day+work_day-1  
        */     

   }
//设置请假的起始和结束最大最小日期
   function changeMaxMinDay(ct,$input){
   	 var data_id=$input.attr("data-id");
   	 var data_value=$($input).attr("data-value");
   	 var checked_max_date = max_date(data_id)
   	 //console.log(checked_max_date)
   	 if("start_at_"+data_id==data_value){
   	 	this.setOptions({
			allowTimes:['09:00','12:00','13:00'],
			defaultTime: "09:00",
			minDate: new Date(checked_max_date),
			maxDate:$('.end_at_'+data_id).val()? new Date($('.end_at_'+data_id).val()):false
		});

   	 }
   	  if("end_at_"+data_id==data_value){
   	 	this.setOptions({
			allowTimes:['12:00','13:00','18:00'],
			defaultTime: "18:00",
			minDate:$('.start_at_'+data_id).val()? new Date($('.start_at_'+data_id).val()): new Date(checked_max_date)
		});

   	 }


   }

  function test_for_minDate(input){
  	var data_id=$(input).attr("data-id");
  	var checked_max_date = find_max_date(input)
  	date = new Date(checked_max_date);

   	return [date.format("yyyy/mm/dd")];
   }

   function get_speical_date(){
   //	alert(rest_days.concat(work_days))
   	 array = rest_days.concat(work_days)
   	 jQuery.map(array,function(c,i){if(c!=''){return c}})
   }

  
//显示时间的函数

   $('.datetimepicker1').click(function(){
   //	var data = 
   	
   	WdatePicker({
       //$preLoad: true,
       firstDayOfWeek: 0,
       minDate: test_for_minDate(this),
       isShowClear: false,
       readOnly: true,
       autoPickDate: true,
      // startDate: '%y/%M/{%d-2}',
       dateFmt:'yyyy/MM/dd',
      // alwaysUseStartDate:true,

       //disabledDays:[0,6],

       
       //disabledDates: ["2014-11-17","2014-10-17"],
      // onpicking: can_choose_date,
       specialDates: get_speical_date(),
       onpicked: cal_days_for_chose

      


   	});

   })
/*
    $('.datetimepicker1').datetimepicker({
	        format: "Y/m/d  H:i",	        
	        firstDay: 0,   
	        lang: "ch", 
	        showAnim: '' ,  
	        duration: '' ,  
            closeOnDateSelect: true,  
            defaultTime: "09:00",    
            onShow: changeMaxMinDay,
            beforeShowDay: noWeekendsOrHolidays,
            onClose: function(dp,$input){
            	data_id = $input.attr("data-id");
            	start_at = $(".start_at_"+data_id).val()
            	end_at = $(".end_at_"+data_id).val()
            	if(start_at!="" && end_at!=""){
            		 days = cal_diff_time(start_at,end_at)
            		 if(data_id=="0" && parseFloat(days)>parseFloat(total_nj_day)){
            		 	//alert("您一共有"+total_nj_day+"天年假，请重新选择");

            		 }
            		$("#select_days_"+data_id).val(days)
            	}
            }
            
	});
 */

function select_for_speical_day(data_id) {
	 var start_at = $(".start_at_"+data_id).val();
     var end_at = $(".end_at_"+data_id).val();
	
	 if(start_at!="" && end_at!=""){
         var days = cal_diff_time(data_id);
        
         if(data_id=="0" && parseFloat(days)>parseFloat(total_nj_day)){
            alert("您一共有"+total_nj_day+"天年假，请重新选择");
           }
         if(data_id=="1" &&  parseFloat(days)>parseFloat(total_sj_day)){
           alert("一年之内只能请14天事假，您还能请"+total_sj_day+"天，请重新选择");

         }
         if(data_id=="7" &&  parseFloat(days)>parseFloat(total_sangj_day)){
           alert("一年之内只能请3天丧假，您还能请"+total_sangj_day+"天，请重新选择");

         }
         $("#select_days_"+data_id).val(days)
     }
	
}

//从某天开始计算len长得工作日期

function work_day_from(st_at,len) {
    
    work_an_rest_day = cal_rest_on_work_day(st_at,len)   
    rest_day = work_an_rest_day[0];
    //alert(st_at)
     //alert(parseInt(rest_day)>=1)
    //work_day = work_an_rest_day[1]
    if(parseInt(rest_day)>=1){
        work_day_from(st_at,rest_day)
    }
    return st_at
    
}
function select_for_cj_day (data_id,jl) {
	start_at = $(".start_at_"+data_id).val();

	if(start_at!=""){
		if(user_gender=="1"){
            date = new Date(start_at)
		    date.setDate(date.getDate()+29);
		    $(".end_at_"+data_id).val(date.format("yyyy/mm/dd"))
            $("#select_days_"+data_id).val(30)

		}else{
		  date = new Date(start_at)
		  date.setDate(date.getDate()+97);
		  end_at = work_day_from(date,30)
		  $(".end_at_"+data_id).val(end_at.format("yyyy/mm/dd"))
          $("#select_days_"+data_id).val(128)
     
		}
		
	}
	

}
function select_for_lianxu_day(data_id,len) {
	start_at = $(".start_at_"+data_id).val();
	if(start_at!=""){
		date = new Date(start_at)
		date.setDate(date.getDate()+len-1);
        $(".end_at_"+data_id).val(date.format("yyyy/mm/dd"))
        $("#select_days_"+data_id).val(len)
	}
    
}
function get_checkbox_checked_values(data_id){
	values = [];



}

function select_for_other_cj_day(d_id){
	var s_at =  $("#start_at_"+d_id).val();
	var e_at =  $("#end_at_"+d_id).val();
	if(s_at!="" && e_at!=""){
	var start_at = new Date(s_at);
    var end_at = new Date(e_at);
    var	diff = end_at - start_at
    var vdaysdiff = Math.floor(diff/1000/60/60/24); 
    $("#select_days_"+d_id).val(vdaysdiff+1);
   }

}

function collection_value_for_checked(d_id){
	var s_at =  $("#start_at_"+d_id).val();
	var e_at =  $("#end_at_"+d_id).val();
	var s_hour = $(".start_at_half_day_"+d_id+":radio:checked").val()=="1" ? " 12:00" : " 18:00"
    var e_hour =  $(".end_at_half_day_"+d_id+":radio:checked").val()=="1" ? " 12:00" : " 18:00"	
	var s_value = new Date(s_at+ s_hour);
	var e_value = new Date(e_at+ e_hour);
  if(s_value!="" && e_value!=""){
	$('.leave_kind:checkbox:checked').each(function () {
    	var data_id=$(this).attr("data-id");
    	if(d_id!=data_id){
            start_at =  $("#start_at_"+data_id).val();
	        end_at =  $("#end_at_"+data_id).val();
	        start_hour = $(".start_at_half_day_"+data_id+":radio:checked").val()=="1" ? " 12:00" : " 18:00"
            end_hour =  $(".end_at_half_day_"+data_id+":radio:checked").val()=="1" ? " 12:00" : " 18:00"
            start_value = new Date(start_at+ start_hour);
	        end_value = new Date(end_at+ end_hour);
   	        if(start_value<=s_value && end_value>=s_value){
               alert("您选择的日期和其他请假类型重复，请检查") 
               $("#start_at_"+d_id).val("");
                $("#end_at_"+d_id).val("");
            }


	       
    	}


     })
   }


    


}

function cal_days_for_chose(){  
	data_id = $(this).attr("data-id");
    
    switch (data_id)
    {
        case "0":
          select_for_speical_day(data_id);
          break;
        case "1":
          select_for_speical_day(data_id);
          break;
        case "2":
          select_for_speical_day(data_id);
          break;
        case "3":
          select_for_speical_day(data_id);
          break;
        case "4":
          select_for_cj_day(data_id,true);
         break;
        case "5":
         select_for_other_cj_day(data_id);
          break;
        case "6":
          select_for_lianxu_day(data_id,total_hj_day);
          break;
        case "7":
          select_for_speical_day(data_id);
          break;
        case "8":
          select_for_lianxu_day(data_id,20);
          break;
        case "9":
          select_for_lianxu_day(data_id,20);
          break;
        case "10":
          select_for_lianxu_day(data_id,30);
          break;
        case "11":
           select_for_speical_day(data_id);
          break;
        case "12":
          select_for_speical_day(data_id);
          break;

    }

    collection_value_for_checked(data_id);
   

}

function can_choose_date(){
    date = $dp.cal.getDateStr();
    a=["2014/10/12","2014/10/13","2014/10/14"]
    
   

}

//计算选择的时候大小值
var find_max_date=function find_checked_max_date(input){
    var array=[];
    var re = []
    value=$(input).attr("data-value");
    data_id=$(input).attr("data-id");
    $('.leave_kind:checkbox:checked').each(function () {
    	var d_value=$(this).attr("data-value");
    	var d_id=$(this).attr("data-id");
    	if(data_id!=d_id){
    	  if(d_value!=value && $("#start_at_"+d_id).val()!=""){array.push($("#start_at_"+d_id).val());}
     	   if(d_value!=value && $(".end_at_"+d_id).val()!=""){array.push($(".end_at_"+d_id).val())} 
     	 }
     })

    if(array.length==0){
    	return  new Date(new Date().setDate(new Date().getDate()-1));
    }
    console.log(array.sort())
    return new Date(array.sort()[array.length-1])
    
}


//计算选择的时候大小值
var max_date=function choosed_checked_max_date(ci){
    var array=[];
    var re = []
    console.log(ci)
    $('.leave_kind:checkbox:checked').each(function () {
    	var d_id=$(this).attr("data-id");
    	console.log($("#start_at_"+d_id).val()) 
    	if(d_id!=ci && $("#start_at_"+d_id).val()!=""){array.push($("#start_at_"+d_id).val());}
     	if(d_id!=ci && $(".end_at_"+d_id).val()!=""){array.push($(".end_at_"+d_id).val())} 
     	//   
     })
   
    //array = array.join(",").split(",")
    if(array.length==0){
    	return  new Date(new Date().setDate(new Date().getDate()-1));
    }
    console.log(array.sort())
    return new Date(array.sort()[array.length-1])
    
}
//计算设置的公休假和周末上班的方法
function noWeekendsOrHolidays(date) {
        var noWeekend = $.datepicker.noWeekends(date);
        if (noWeekend[0]) {
            return nationalDays(date);
        } else {
            flag =  nationalDays(date)[0];
        	for (i = 0; i < work_days.length; i++) {
        	  month= parseInt(work_days[i].split("/")[1])
    	      day = parseInt(work_days[i].split("/")[2])
              if (date.getMonth() == month - 1
                  && date.getDate() == day && flag) {
                 return [true, ''];
                }
             }
            return [false,''];
        }
    }

//周末上班和休息的设置
function nationalDays(date) {
    //rest_days=natDays.concat(cal_chosed_days())
    for (i = 0; i < rest_days.length; i++) {
    	month= parseInt(rest_days[i].split("/")[1])
    	day = parseInt(rest_days[i].split("/")[2])
      if (date.getMonth() == month - 1
          && date.getDate() == day) {
        return [false, ''];
      }
    }
  return [true, ''];
}

jQuery.validator.addMethod("cal_nj_days", function(value,element) {   
       return this.optional(element) || parseFloat(value)<=parseFloat(total_nj_day);   
   
 }, "您年假一共"+total_nj_day+"天,请重新选择"); 

 jQuery.validator.addMethod("cal_shij_days", function(value,element) {   
       return this.optional(element) || parseFloat(value)<=parseFloat(total_sj_day);   
   
 }, "一年之内只能请14天事假，您只能请"+total_sj_day+"天，请重新选择");   

jQuery.validator.addMethod("cal_sangj_days", function(value,element) {   
       return this.optional(element) || parseFloat(value)<=parseFloat(total_sangj_day);   
   
 }, "一年之内只能请3天丧假，您只能请"+total_sangj_day+"天，请重新选择");  



 jQuery.validator.addMethod("must_more_zero", function(value,element) {  
      
     return this.optional(element) || parseFloat(value)>parseFloat(0);   
   
 }, "数据有错误，请重新检查"); 


function add_rule_to_nj(data_id){
	if(data_id=="0"){
 	       $("#select_days_0").rules("add", {
                required: true,
                cal_nj_days: true,
                 messages: {
                  required: "一共可以请"+total_nj_day+"天"
				 }
            });
 	}
}

function add_rule_to_shij(data_id){
	$("#select_days_"+data_id).rules("add", {
        required: true,
        cal_shij_days: true,
        messages: {
            required: "一年之内只能请14天事假，您已经请了"+total_sj_day+"，请重新选择"
		}
    });
 	
}

function add_rule_to_sangj (data_id) {
	$("#select_days_"+data_id).rules("add", {
        required: true,
        cal_sangj_days: true,
        messages: {
            required: "一年之内只能请3天丧假，您已经请了"+total_sangj_day+"，请重新选择"
		}
    });
	// body...
}


function add_rule_to_sangj(data_id) {
	$("#select_days_"+data_id).rules("add", {
        required: true,
        cal_sangj_days: true,
        messages: {
            required: "一年之内只能请3天丧假，您已经请了"+total_sangj_day+"，请重新选择"
		}
    });
	// body...
}



$('.new_leave').on('submit', function(e) {
    $('.leave_kind:checkbox:checked').each(function () {
 	       var d_id=$(this).attr("data-id");         
 	       switch (d_id)
 	       {
 	       	case "0":
 	       	  add_rule_to_nj(d_id);
 	       	  break;
 	       	case "1":
 	       	  add_rule_to_shij(d_id);
 	       	  break;
 	       	case "7":
 	       	  add_rule_to_sangj(d_id);
 	       	  break;
 	       	
 	       };
           if(d_id=="4" || d_id=="5" || d_id=="6"){
           	  $("#leave_image").rules("add", {
                required: true,
               // date_not_in_checked: true,
                 messages: {
                  required: "请提供相关材料(如结婚证，独生子，晚婚晚育证)"
				 }
            });


           }
           $("#start_at_"+d_id).rules("add", {
                required: true,
               // date_not_in_checked: true,
                 messages: {
                  required: "请填写起始日期"
				 }
            });
            $("#end_at_"+d_id).rules("add", {
                required: true,
                 messages: {
                  required: "请填写结束日期"
				 }
            });

            $("#select_days_"+d_id).rules("add", {
                required: true,
                 must_more_zero: true,
                 messages: {
                  required: "日期"
				 }
            });
      
           // 

  })
});

  $(".new_leave").validate({ 
	  //errorElement: "b",
	//debug:true, 
    errorElement: "b",
  	  rules:{
  	  	"leave[title]": "required",
  	  	"leave[leave_details_attributes][kind][]": "required"
  	  },
  	  messages: {
  	  	"leave[title]": "不能为空",
  	  	"leave[leave_details_attributes][kind][]": "选择请假类型"
  	  	
  	  }
  });


})
