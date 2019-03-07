<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"
         import="
			com.tridion.broker.StorageException,
			com.tridion.meta.ComponentMeta,
			com.tridion.meta.ComponentMetaFactory,
			com.tridion.dcp.ComponentPresentation,
			com.tridion.dcp.ComponentPresentationFactory,
			com.tridion.util.TCMURI,
			java.text.ParseException" %>
<%!
	public boolean isEmpty(String input) {
		return "".equals(input) || input == null;
	}
	
	public String getComponentTitle(TCMURI uri) {
		ComponentMetaFactory componentMetaFactory = new ComponentMetaFactory(uri.getPublicationId());
		ComponentMeta componentMeta = componentMetaFactory.getMeta(uri.getItemId());
		return componentMeta.getTitle();
	}
	
	public String renderComponent(TCMURI uri) throws StorageException,ParseException {
		ComponentPresentationFactory factory = new ComponentPresentationFactory(uri.getPublicationId());
		ComponentPresentation cp = factory.getComponentPresentationWithHighestPriority(uri.getItemId());
		return cp.getContent();
	}
%>
 <%
	String componentId = request.getParameter("id");
	TCMURI componentUri = new TCMURI(componentId);
	String componentTitle = getComponentTitle(componentUri);
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
								<a class="pure-button" href="/#pages">Pages</a>
							</li>
							<li class="nav-item">
								<a class="pure-button" href="/#components">Components</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>

			<div class="content pure-u-1 pure-u-md-3-4">
				<div>
					<div class="posts">
						<h1 class="content-subhead">Rendered Component Presentation</h1>

						<section class="post">
							<header class="post-header">
								<h2 class="post-title"><%=componentTitle%></h2>
							</header>

							<div class="post-description">
								<%=renderComponent(componentUri)%>
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