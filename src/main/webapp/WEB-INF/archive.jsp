<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div id="messages">
	<h5>Messages:</h5>
			<c:choose>
				<c:when test = "${user_to_render.id != currentUser.id}">
			   		<form:form method="POST" action="/message" modelAttribute="message">
			   			<input type="hidden" name="user_to_render_id" value="${user_to_render.getId()}"/>
			   			<form:textarea type="text" columns="30" name="message" path="message_body" placeholder="Post a message"/>
			       		<input type="submit" value="Submit Message"/>
			   		</form:form>
				</c:when>
				<c:otherwise>						
				</c:otherwise>
			</c:choose>	
  		<c:forEach items="${wall_messages}" var="message">
  			<p><a href="/users/${message.getMessagePoster().id}"><c:out value="${message.getMessagePoster().name}"/></a>: "<c:out value="${message.message_body}"/>" - <span class="post-date"><c:out value="${message.createdAt}"/></span>
			<c:choose>
				<c:when test = "${message.getMessagePoster().id == currentUser.id}">
	    			<form method="post" action="/delete/message/${message.id}/${user_to_render.id}" class="inline">
	    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					  <button type="submit" name="submit_param" value="submit_value" class="link-button">
					    Delete Message
					  </button>
					</form>
				</c:when>
				<c:otherwise>

				</c:otherwise>
			</c:choose>		    			

		</p>
		<div class="message-replies">
			<form:form method="POST" action="/message/reply/${message.id}/${user_to_render.id}" modelAttribute="message_reply">
		
			<h5>Message Replies:</h5>
    		<form:textarea type="text" columns="50" name="messageReply" path="messageReplyBody" placeholder="Reply to this message"/>
        		<input type="submit" value="Reply"/>
    		</form:form>
			<c:forEach items="${message.getRepliedMessageMessages()}" var="reply">
				<p>
					<a href="/users/${reply.getUserWhoRepliedToMessage().id}"><c:out value="${reply.getUserWhoRepliedToMessage().name}"/></a>
					:  "<c:out value="${reply.messageReplyBody}"/>" - <span class="post-date"><c:out value="${reply.createdAt}"/></span>
					<c:choose>
						<c:when test = "${reply.getUserWhoRepliedToMessage().id == currentUser.id}">
			    			<form method="post" action="/message/reply/delete/${reply.id}/${user_to_render.id}" class="inline">
			    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							  <button type="submit" name="submit_param" value="submit_value" class="link-button">
							    Delete Reply
							  </button>
							</form>
						</c:when>
						<c:otherwise>
						
						</c:otherwise>
					</c:choose>
					<hr>
				</p>
			</c:forEach>
		</div>
  			<br>
  		</c:forEach>
  		</div>

</body>
</html>