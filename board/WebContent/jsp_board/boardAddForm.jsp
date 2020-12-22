<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOARD ADD</title>
</head>
<body>
<h1>게시글 추가</h1>
<form action="<%=request.getContextPath()%>/jsp_board/boardAddAction.jsp" method="post">
    <div>boardPw : </div>
    <div><input name="boardPw" id="boardPw" type="password"/></div>
    <div>boardTitle : </div>
    <div><input name="boardTitle" id="boardTitle" type="text"/></div>
    <div>boardContent : </div>
    <div><textarea name="boardContent" id="boardContent" rows="5" cols="50"></textarea></div>
    <div>boardName : </div>
    <div><input name="boardUser" id="boardUser" type="text"/></div>
    <div>
        <input type="submit" value="글쓰기"/>
        <input type="reset" value="초기화"/>
    </div>
</form>
</body>
</html>

