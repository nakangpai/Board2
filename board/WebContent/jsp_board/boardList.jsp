<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD LIST</title>
</head>
<body class="container">
<h1>게시글 리스트</h1>
<%
    
    int currentPage = 1;
    if(request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    System.out.println("currentPage : "+currentPage); 
 
    int totalRowCount = 0; 
    String dbUrl = "jdbc:mariadb://127.0.0.1:3306/board";
    String dbUser = "root";
    String dbPw = "java1004";
  
    Connection connection = null;
    PreparedStatement totalStatement = null;
    PreparedStatement listStatement = null;
    ResultSet totalResultSet = null;
    ResultSet listResultSet = null;
    
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
        
        String totalSql = "SELECT COUNT(*) FROM board"; 
        totalStatement = connection.prepareStatement(totalSql);
        // 리스트에 쿼리문 대입
        totalResultSet = totalStatement.executeQuery();
        if(totalResultSet.next()) {
            totalRowCount = totalResultSet.getInt(1);
        }
%>
    <div>전체행의 수 : <%=totalRowCount%></div>
<%
	// 페이지당 게시글 개수 
    int pagePerRow = 10; 
    String listSql = "SELECT board_no, board_title, board_user, board_date FROM board ORDER BY board_no DESC LIMIT ?, ?";
   
    listStatement = connection.prepareStatement(listSql);
	listStatement.setInt(1, (currentPage-1)*pagePerRow);
    listStatement.setInt(2, pagePerRow); 
    listResultSet = listStatement.executeQuery();
%>
    <table class="table table-border table-hover">
        <thead>
            <tr>
                <th>boardTitle</th>
                <th>boardUser</th>
                <th>boardDate</th>
            </tr>
        </thead>
        <tbody>
<%
            while(listResultSet.next()) {
%>
                <tr>
                    <td><a href="<%=request.getContextPath()%>/jsp_board/boardView.jsp?boardNo=<%=listResultSet.getInt("board_no")%>"><%=listResultSet.getString("board_title")%></a></td>
                    <td><%=listResultSet.getString("board_user")%></td>
                    <td><%=listResultSet.getString("board_date")%></td>
                </tr>
<%        
            }
%>
        </tbody>
    </table>
    <div>
        <a href="<%=request.getContextPath()%>/jsp_board/boardAddForm.jsp">게시글 입력</a>
    </div>
<%
    // 마지막 페이지는 전체글의수를 pagePerRow로 나누었을때 나누어 떨어지면 몫이 마지막 페이지
    int lastPage = totalRowCount/pagePerRow;
    if(totalRowCount % pagePerRow != 0) {
        lastPage++;
    }
%>
    <div>
<%
        if(currentPage>1) {
%>
            <a href="<%=request.getContextPath()%>/jsp_board/boardList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%
        }
        if(currentPage < lastPage) { 
%>
            <a href="<%=request.getContextPath()%>/jsp_board/boardList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%
        }
%>
    </div>
<%
    } catch(Exception e) {
        e.printStackTrace();
        out.print("목록 가져오기 실패");
    } finally {
        try {totalResultSet.close();} catch(Exception e){}
        try {listResultSet.close();} catch(Exception e){}
        try {totalStatement.close();} catch(Exception e){}
        try {listStatement.close();} catch(Exception e){}
        try {connection.close();} catch(Exception e){}
    }
%>
</body>
</html>