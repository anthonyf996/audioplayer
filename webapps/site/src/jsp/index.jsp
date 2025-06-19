<!DOCTYPE html>
<%@include file="../incl/const.incl" %>
<html>
<head>
	<title><%= WEBSITE_NAME %></title>
	<%@include file="../incl/header_common.incl" %>
	<link rel="stylesheet" type="text/css" href="../css/main.css">
</head>
<body>
	<%@ page language="java" import="java.sql.*" %>
	<h1><%= WEBSITE_NAME %></h1>
	<main>
	<input id="song-search" type="text" placeholder="Search">
	<div class="cont-song-list">
<%
	org.sqlite.SQLiteConfig sqliteConfig = null;

	Connection conn = null;

	PreparedStatement pstmt = null;

	ResultSet rs = null;

	try {
		sqliteConfig = new org.sqlite.SQLiteConfig();
		sqliteConfig.enforceForeignKeys(true);

		Class.forName("org.sqlite.JDBC");
		conn = DriverManager.getConnection(
			PREPROC_LANG + ":" + DB_MANAGER + ":" + DB_DIR + DB, sqliteConfig.toProperties()
		);
%>
<%
		int numSongs = 0;
		pstmt = conn.prepareStatement("SELECT COUNT(*) AS NUM FROM Songs;");
		rs = pstmt.executeQuery();

		while(rs.next()) {
			numSongs = Integer.parseInt(rs.getString("NUM"));
		}

		int nextIndex = 0;
		int[] song_ids = new int[numSongs];
		pstmt = conn.prepareStatement("SELECT song_id FROM Songs;");
		rs = pstmt.executeQuery();

		while(rs.next()) {
			song_ids[nextIndex] = Integer.parseInt(rs.getString("song_id"));
			nextIndex++;
		}

		String[] titles = new String[numSongs];

		for (int i : song_ids) {
			String title = null;
			String genre = null;
			String artworkPath = "../../content/images/music_icon_gray.png";
			String songPath = null;
			pstmt = conn.prepareStatement("SELECT * FROM SongAttributes WHERE song_id=" + i);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String attr = rs.getString("attribute");
				String attr_value = rs.getString("attr_value");
				if (attr.equals("title")) {
					title = attr_value;
				}
				if (attr.equals("genre")) {
					genre = attr_value;
				}
				if (attr.equals("artworkPath")) {
					artworkPath = attr_value;
				}
				if (attr.equals("songPath")) {
					songPath = attr_value;
				}
			}
			%>
			<div class="song-list-item" data-title="<%= title %>" data-song-path="<%= songPath %>">
				<img class="song-list-item-artwork" src="<%= artworkPath %>" alt="<%= title %>">
				<p class="song-list-item-title"><%= title %></p>
			</div>
			<%
		}
%>
<%
	} catch (SQLException sqle) {
		out.println(sqle.getMessage());
	} catch (Exception e) {
		out.println(e.getMessage());
	} finally {
		if (rs != null) {
			rs.close();
		}
		if (pstmt != null) {
			pstmt.close();
		}
		if (conn != null) {
			conn.close();
		}
	}
%>
	</div>
	</main>

	<script src="../js/main.js"></script>
</body>
</html>
