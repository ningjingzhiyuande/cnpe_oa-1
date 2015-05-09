$(function(){
	jQuery(".slideBox").slide({mainCell:".bd ul",autoPlay:true,trigger:"click",delayTime:600});

	$("#titleMenuId>li").click(function(){
		$(this).addClass("current").siblings().removeClass("current");
		var index = $(this).index();
		$("#mainNewsId>div").eq(index).removeClass("dn").siblings().addClass("dn");
	});
});

//收藏本页
function AddFavorite(sURL, sTitle){
	try{
		window.external.addFavorite(sURL, sTitle);
	}

	catch(e){
		try{
			window.sidebar.addPanel(sTitle, sURL, "");
		}
		catch(e){
			alert("加入收藏失败，请使用Ctrl+D进行添加");
		};
	};
};

//设为首页
function SetHome(obj){
	try{
		obj.style.behavior='url(#default#homepage)';
		obj.setHomePage(document.location.href);
	}catch(e){
		if(window.netscape){
			try{
				netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
			}catch(e){
				alert("抱歉，此操作被浏览器拒绝！\n\n请在浏览器地址栏输入“about:config”并回车然后将[signed.applets.codebase_principal_support]设置为'true'");
			};
		}else{
			alert("抱歉，您所使用的浏览器无法完成此操作。\n\n您需要手动设置为首页。");
		};
	};
};