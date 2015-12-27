$(document).ready(function(){
	$("#registrationFormSubmit").click(function()
	{
		var name = document.getElementById("name").value;
		var email = document.getElementById("email").value;
		var mobileNo = document.getElementById("mobileNo").value;
		var gender = document.getElementById("gender").value;
		var address = document.getElementById("address").value;
		var password = document.getElementById("password").value;
		var confirmPassword = document.getElementById("confirmPassword").value;
		
	});
	$("#searchFriendBtn").click(function(){
		var searchText = document.getElementById("searchFriendText").value;
		var userId = document.getElementById("user_id").value;
		$.post("/users/search_friend",
			{
				user_id : userId,
				search_text: searchText
			},
			function(data, status)
			{
				var list="";
				if(data["success"])
				{
					$(".friendListContainer").html("");
					for(i = 0; i < data["data"].length; i++)
					{
						$(".friendListContainer").append("<li class= 'friendListContain'>"+
    					"<img src='/uploads/post/photo/5/sk.jpg' class='friendListProfileImg'>"+
    					"<div class ='friendListDetailDiv'>"+
	    					"<div class ='friendListName'>"+data["data"][i].name+"</div>"+
	    					"<div class ='friendListFrdBtn'><button>Add Friend</button></div>"+
    					"</div>"+
    				"</li>");
					}
					
					
				}	
				else
				{
					alert(data["message"]);		
				}
			}
		);
	});
});
