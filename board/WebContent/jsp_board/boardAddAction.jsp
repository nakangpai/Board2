<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
  
	String boardPw = request.getParameter("boardPw");
    String boardTitle = request.getParameter("boardTitle");
    String boardContent = request.getParameter("boardContent");
    String boardUser = request.getParameter("boardUser");
 
    String dbUrl = "jdbc:mariadb://127.0.0.1:3306/board";
    String dbUser = "root";
    String dbPw = "java1004";
 
    Connection connection = null;
    PreparedStatement statement = null;

    try {
    	Class.forName("org.mariadb.jdbc.Driver");
    	connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
        String sql = "INSERT INTO board(board_pw, board_title, board_content, board_user, board_date) values(?,?,?,?,now())";
      
        statement = connection.prepareStatement(sql);
      
        statement.setString(1,boardPw);
        statement.setString(2,boardTitle);
        statement.setString(3,boardContent);
        statement.setString(4,boardUser);
       
        statement.executeUpdate(); 
     // boardList로 이동 
     response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } catch(Exception e) {
        e.printStackTrace(); //에러메시지 출력 
        out.print("입력 예외 발생");  response.sendRedirect(request.getContextPath()+"/jsp_board/boardAddForm.jsp");
    } finally {
        try {statement.close();} catch(Exception e){}
        try {connection.close();} catch(Exception e){}
    }
%>
</body>
</html>
