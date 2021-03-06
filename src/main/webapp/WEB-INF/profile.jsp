<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="../CSS/styleprofile.css" rel="stylesheet" type="text/css">

	<title>Professional Profile</title>
    <!-- Required meta tags always come first -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
</head>
<body>
	<!-- This is the navbar -->	    
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	  <!-- Brand -->
	  <a class="navbar-brand" href="/users/1">Sam's Social Network App</a>
	
	  <!-- Links -->
	  <ul class="navbar-nav">
	 	
	    <li class="nav-item">
			<a class="nav-link" href="/users">Add Users</a>
	    </li>
		<form action="/search" method="POST" class="form-inline" role="search">
			<input placeholder="Search users" type="text" class="form-control" name="name">
			<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
			<button type="submit" class="btn btn-secondary">Search</button>
		</form>
	    <li class="nav-item">
			<a class="nav-link" href="https://github.com/SamLobodiak/Social-Network">Source Code</a>
	    </li>
	    <li class="nav-item">
			<a class="nav-link" href="https://docs.google.com/document/d/1CLViFzplvLkeQ-afJvMH7YJaGxqsTMq7wQI2UzRGahQ/edit">Sam's Resume</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="/"><img id="nav-profile-thumbnail" alt="image" src="${currentUser.image_address}" height="30" style="margin: 0px 5px 0px 5px"><c:out value="${currentUser.name}" /></a>
	    </li>
	    <li>
			<form id="logoutForm" method="POST" action="/logout">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <input class="btn btn-secondary" type="submit" value="Logout" />
		    </form>
	    </li>
	  </ul>
	</nav>
	<!-- END OF NAVABAR -->
	<!-- END OF NAVABAR -->	    
	<!-- END OF NAVABAR -->	    

	<!-- This HTML template is for both the Current Logged User as well as the Selected User to view -->
		    
	<!-- General container of Web APp-->	    
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<!-- Profile info box-->
	    
		   	<div id="profile-info">
		   	
				<c:choose>
					<c:when test = "${user_to_render.id == currentUser.id}">
						<h1>My Profile (<span id=""><c:out value="${user_to_render.name}" /></span>)</h1>
					</c:when>
					<c:otherwise>
						<h1><c:out value="${user_to_render.name}" />'s Wall</h1>
					</c:otherwise>
				</c:choose>
				 
				<div id="profile-picture">
					<img alt="Profile Picture" class="rounded" height="220" src="${user_to_render.image_address}">
				</div>
				<c:choose>
					<c:when test = "${user_to_render == currentUser}">
					</c:when>						
					<c:when test = "${user_to_render.getInvitedUserFriends().contains(currentUser)}">
						<p class="invited_text">Invited <a href="/profile/cancelinvite/${user_to_render.getId()}">Cancel Invite</a></p>
					</c:when>
					<c:when test = "${!user_to_render.getFriends().contains(currentUser)}">
						<a href="/profile/invite/${user_to_render.getId()}">Invite</a>
					</c:when>						         
					<c:otherwise>
					<p>Already Friends</p>
					</c:otherwise>
				</c:choose>
				<blockquote class="blockquote">
					<p><c:out value="${user_to_render.description}"/></p>
				</blockquote>
			   	<p>Location: <c:out value="${user_to_render.city}" /> <c:out value="${user_to_render.state}" /></p>
		   	
		   	</div>
		    
			<!-- People you accepted invites (Your Network)-->	    
		    <div id="network">
				<c:choose>
					<c:when test = "${user_to_render.id == currentUser.id}">
					    <h3>Your network: <c:out value="${them.size() }"/></h3>
					</c:when>
					<c:otherwise>
					    <h3><c:out value="${user_to_render.getName() }"/>'s Professional network: <c:out value="${them.size() }"/></h3>
					</c:otherwise>
				</c:choose>
			   	<div class="scrollmenu-network">
				<c:forEach items="${them}" var="user">
			  		<tr>
			  			<td><img class="rounded-circle" alt="image"  width="70" height="80" src="${user.image_address}"><a href="/users/${user.getId()}"><c:out value="${user.getName() }"/></a></td>
			  		</tr>
			   	</c:forEach>
				</div>
			</div>
			
			<!-- People who have invited you box-->	    
			<h3 style="none">You have <c:out value="${users.size() }"/> invitations</h3>
			<div id="invites">
				<c:choose>
					<c:when test = "${user_to_render.id == currentUser.id}">
					    <h3>You have <c:out value="${users.size() }"/> invitations</h3>
							   	<div style="height:150px;width:450px;padding: 5px;border:1px solid #B2B2B2;font:16px/26px Georgia, Garamond, Serif;overflow:auto;">
								<c:forEach items="${users}" var="user">
							  		<tr>
							  			<td><img class="rounded-circle" alt="image"  width="70" height="80" src="${user.image_address}"><a href="/users/${user.getId()}"><c:out value="${user.getName() }"/></a> | <a href="/connect/${user.getId()}">Accept Invitation</a><a href="/deleteinvite/${ user.getId() }"> Ignore</a></td>
							  			<hr>
							  		</tr>
				
							   	</c:forEach>
								</div>

					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>

			</div>
	
			<!-- The Wall-->	    
			<div id="the_wall">

				<!-- Status refers to any wall post from a user-->	    		    	
		    	<div id="status-box">
		    	
					<!-- This is where user's can make a post-->	    		    	    	
			    	<div id="whats-on-your-mind">
						<c:choose>
							<c:when test = "${user_to_render.id == currentUser.id}">
								<form:form action="/status/${user_to_render.id}" method="POST" modelAttribute="status">
									<fieldset class="form-group">
										<form:input placeholder="What's on your mind, ${user_to_render.name}?" type="text" class="form-control" id="status" name="status" path="status_body"/>
									</fieldset>
									<button type="submit" class="btn btn-primary">Submit Status</button>
								</form:form>
							</c:when>
							<c:otherwise>
								<form:form action="/status/${user_to_render.id}" method="POST" modelAttribute="status">
									<fieldset class="form-group">
										<form:input placeholder="Comment on ${user_to_render.name}'s wall..." type="text" class="form-control" id="status" name="status" path="status_body"/>
									</fieldset>
									<button type="submit" class="btn btn-primary">Submit</button>
								</form:form>
							</c:otherwise>
						</c:choose>
			    	</div>
			    	

					<!--This is the where the status text bodies append, as well as a form to comment on that status, and the replies of that status-->	    		    						
					<div id="status-list">
						<!--  (i can't write "if" comments inside the choose tag because it throws and error so i will write them out here  -->
			    		<c:forEach items="${TESTING123}" var="status">
			    		
							<!-- THIS CHOOSE IS SAYING IF YOU POSTED IT, OR IT'S YOUR WALL, OR YOU'RE AN ADMIN, YOU CAN DELETE IT. -->
							<c:choose>
								<c:when test = "${status.getPoster().id == currentUser.id}">
									<blockquote class="blockquote">
										<p>
											<img class="rounded-circle" alt="image" height="105" src="${status.getPoster().image_address}">
											<a href="/users/${status.getPoster().id}"><span id="poster-name"><c:out value="${status.getPoster().name}"/></span></a>
											<span id="post-text"><c:out value="${status.status_body}"/></span><span class="post-date"><fmt:formatDate type = "both" value = "${status.createdAt}" /></span>
											<span id="delete-status-button">
								    			<form method="post" action="/delete/status/${status.id}/${user_to_render.id}" class="inline">
								    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
												    Delete your message
												  </button>
												</form>
											</span>	
										</p>
									</blockquote>
								</c:when>
								<c:when test = "${user_to_render.id == currentUser.id}">
									<blockquote class="blockquote">
										<p>
											<img class="rounded-circle" alt="image" alt="image" height="105" src="${status.getPoster().image_address}">
					    					<a href="/users/${status.getPoster().id}"><c:out value="${status.getPoster().name}"/></a>
											<span id="post-text"><c:out value="${status.status_body}"/></span><span class="post-date"><fmt:formatDate type = "both" value = "${status.createdAt}" /></span>
											<span id="delete-status-button">
								    			<form method="post" action="/delete/status/${status.id }/${user_to_render.id}" class="inline">
								    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
												    Delete off your wall
												  </button>
												</form>
											</span>
										</p>
									</blockquote>

								</c:when>
								<c:when test = "${currentUser.getRoles().contains(ADMIN_ROLE_OBJECT)}">
									<blockquote class="blockquote">
										<p>
											<img class="rounded-circle" alt="image" height="105" src="${status.getPoster().image_address}">
					    					<a href="/users/${status.getPoster().id}"><c:out value="${status.getPoster().name}"/></a>
											<span id="post-text"><c:out value="${status.status_body}"/></span><span class="post-date"><fmt:formatDate type = "both" value = "${status.createdAt}" /></span>
											<span id="delete-status-button">
								    			<form method="post" action="/delete/status/${status.id }/${user_to_render.id}" class="inline">
								    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
												    ADMIN DELETE
												  </button>
												</form>
											</span>
										</p>
									</blockquote>	
								</c:when>
								<c:otherwise>
									<blockquote class="blockquote">
										<p>
											<img class="rounded-circle" alt="image" height="90" src="${status.getPoster().image_address}">
					    					<a href="/users/${status.getPoster().id}"><c:out value="${status.getPoster().name}"/></a>
											<span id="post-text"><c:out value="${status.status_body}"/></span><span class="post-date"><fmt:formatDate type = "both" value = "${status.createdAt}" /></span>
										</p>
									</blockquote>	
								</c:otherwise>
							</c:choose>
	
							<!-- for each status there is a comment box -->
							<form:form method="POST" action="/status/reply/${status.id}/${user_to_render.id}" modelAttribute="statusReply">
						       	<div class="form-group row">
									<div class="col-xs-9">
										<form:input class="form-control" id="statusReplyBody" name="status-reply" path="statusReplyBody" placeholder="Comment on this status "/>
									</div>
								</div>
								<div class="form-group row">
									<div class="offset-xs-3 col-xs-9">
								        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>			
										<button type="submit" class="btn btn-primary">Submit</button>
									</div>
								</div>
							</form:form>
								    		    	
							<!-- for each status it posts the replies.  Status reply text body appends here as well as delete functions based on CURRENT USER, SELECTED USER, OR ADMIN USER-->	    		    	
							<div class="status-reply">
								<c:forEach items="${status.getRepliedStatusMessages()}" var="reply">
										<img class="rounded-circle" alt="image" alt="image"  width="50" height="55" src="${reply.getUserWhoRepliedToStatus().image_address}">					
										<a href="/users/${reply.getUserWhoRepliedToStatus().id}"><c:out value="${reply.getUserWhoRepliedToStatus().name}"/></a>
										  <span id="reply-text"><c:out value="${reply.statusReplyBody}"/></span> - <span class="post-date"><fmt:formatDate type = "both" value = "${reply.createdAt}" /></span>
										<c:choose>
											<c:when test = "${currentUser.getRoles().contains(ADMIN_ROLE_OBJECT)}">
								    			<form method="post" action="/status/reply/delete/${reply.id}/${user_to_render.id}" class="inline">
								    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
												    ADMIN DELETE
												  </button>
												</form>
											</c:when>
											<c:when test = "${user_to_render.id == currentUser.id}">
								    			<form method="post" action="/status/reply/delete/${reply.id}/${user_to_render.id}" class="inline">
								    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
												    Delete your reply 
												  </button>
												</form>
											</c:when>
											<c:when test = "${reply.getUserWhoRepliedToStatus().id == currentUser.id}">
								    			<form method="post" action="/status/reply/delete/${reply.id}/${user_to_render.id}" class="inline">
								    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
												    Delete your reply
												  </button>
												</form>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
										<hr>
								</c:forEach>
							</div>
			    		</c:forEach>
					</div>
		    	</div>
			</div>
		</div>
	</div>
<hr>



</body>
</html>