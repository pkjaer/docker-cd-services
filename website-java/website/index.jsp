<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"
         import="
			com.tridion.broker.StorageException,
			com.tridion.broker.querying.Query,
			com.tridion.broker.querying.criteria.content.ItemTypeCriteria,
			com.tridion.broker.querying.sorting.SortParameter,
			com.tridion.meta.Item" %>
<%!
	public boolean isEmpty(String input) {
		return "".equals(input) || input == null;
	}
	
	public boolean isEmpty(String[] input) {
		return input == null || input.length < 1;
	}
	
	public boolean isEmpty(Item[] input) {
		return input == null || input.length < 1;
	}
	
	public String escapeUri(String uri) {
		return isEmpty(uri) ? "" : uri.replace(":", "%3a");
	}
	
	public String getUriFromItem(Item item) {
		return escapeUri("tcm:" + item.getPublicationId() +"-" + item.getId() + "-" + item.getType());
	}
	
	public Item[] getPages() throws StorageException {
		Query query = new Query();
		query.setCriteria(new ItemTypeCriteria(64));
		query.addSorting(new SortParameter(SortParameter.ITEMS_URL, SortParameter.ASCENDING));
		
		return query.executeEntityQuery();
	}
	
	public Item[] getComponents() throws StorageException {
		Query query = new Query();
		query.setCriteria(new ItemTypeCriteria(16));
		
		return query.executeEntityQuery();
	}
%>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Available Content</title>
		<link rel="stylesheet" href="css/pure/pure-min.css" integrity="sha384-" crossorigin="anonymous">
		
		<!--[if lte IE 8]>
			<link rel="stylesheet" href="css/pure/grids-responsive-old-ie-min.css">
		<![endif]-->
		<!--[if gt IE 8]><!-->
			<link rel="stylesheet" href="css/pure/grids-responsive-min.css">
		<!--<![endif]-->
		
		<!--[if lte IE 8]>
			<link rel="stylesheet" href="css/layouts/blog-old-ie.css">
		<![endif]-->
		<!--[if gt IE 8]><!-->
			<link rel="stylesheet" href="css/layouts/blog.css">
		<!--<![endif]-->
	</head>

	<body>
		<div id="layout" class="pure-g">
			<div class="sidebar pure-u-1 pure-u-md-1-4">
				<div class="header">
					<h1 class="brand-title">Available Content</h1>
					<h2 class="brand-tagline">Explore your published content</h2>

					<nav class="nav">
						<ul class="nav-list">
							<li class="nav-item">
								<a class="pure-button" href="#pages">Pages</a>
							</li>
							<li class="nav-item">
								<a class="pure-button" href="#components">Components</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>

			<div class="content pure-u-1 pure-u-md-3-4">
				<div>
					<div class="posts">
						<a name="pages" />
						<h1 class="content-subhead">Pages</h1>

						<section class="post">
							<header class="post-header">
								<h2 class="post-title">List of published Pages</h2>
							</header>

							<div class="post-description">
								<% for (Item entry : getPages()) { %>
								<p><a href="page.jsp?id=<%=getUriFromItem(entry)%>"><%=entry.getTitle()%></a></p>
								<% } %>
							</div>
						</section>
					</div>
					<div class="posts">
						<a name="components" />
						<h1 class="content-subhead">Components</h1>

						<section class="post">
							<header class="post-header">
								<h2 class="post-title">List of published Components</h2>
							</header>

							<div class="post-description">
								<% for (Item entry : getComponents()) { %>
								<p><a href="component.jsp?id=<%=getUriFromItem(entry)%>"><%=entry.getTitle()%></a> [<a href="component-raw.jsp?id=<%=getUriFromItem(entry)%>">view raw</a>]</p>
								<% } %>
							</div>
						</section>
					</div>

					<div class="footer">
						<div class="pure-menu pure-menu-horizontal">
							<ul>
								<li class="pure-menu-item"><a href="https://github.com/pkjaer/docker-cd-services" class="pure-menu-link">View project on GitHub</a></li>
								<li class="pure-menu-item"><a href="https://github.com/pkjaer/docker-cd-services/issues/new" class="pure-menu-link">Report issue</a></li>
								<li class="pure-menu-item"><a href="http://purecss.io/" class="pure-menu-link">Design by Pure.css</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

	</body>
</html>