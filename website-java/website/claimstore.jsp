<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"
         import="com.tridion.ambientdata.*, 
		 com.tridion.ambientdata.claimstore.*, 
		 com.tridion.ambientdata.processing.*,
		 java.net.*, 
		 java.util.*, 
		 java.util.Map.Entry,
		 net.minidev.json.JSONObject"%>
<%!
		public String serializeClaimStore() {
			ClaimStore store = AmbientDataContext.getCurrentClaimStore();
			if (store == null) {
				return "{}";
			}
			
			TreeMap<String, Object> claims = new TreeMap<String, Object>();
			Map<URI, Object> allClaims = store.getAll();
			for (URI claimUri : allClaims.keySet()) {
				claims.put(claimUri.toString(), allClaims.get(claimUri));
			}
			
			JSONObject jsonObj = new JSONObject(claims);
			return jsonObj.toJSONString();
		}
%>
<%	
	if ("json".equals(request.getParameter("format"))) {
		out.println(serializeClaimStore());
		out.flush();
		out.close();
		return;
	}
%>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>ADF Claim Store</title>
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

		<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.4.min.js"></script>
		<script src="http://ajax.aspnetcdn.com/ajax/knockout/knockout-3.3.0.js"></script>
		<script src="http://tridionpractice.github.io/tridion-practice/javascripts/AmbientDataFramework/Knockout-LocalStorage.js"></script>
		<script src="http://tridionpractice.github.io/tridion-practice/javascripts/AmbientDataFramework/ClaimModel.js"></script>
		<script src="http://tridionpractice.github.io/tridion-practice/javascripts/AmbientDataFramework/ClaimsViewModel.js"></script>
	</head>

	<body>
		<div id="layout" class="pure-g">
			<div class="sidebar pure-u-1 pure-u-md-1-4">
				<div class="header">
					<h1 class="brand-title">ADF Claim Store</h1>
					<h2 class="brand-tagline">View claims and values</h2>

					<nav class="nav">
						<ul class="nav-list">
							<li class="nav-item">
								<a class="pure-button" href="/">Back to home</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>

			<div class="content pure-u-1 pure-u-md-3-4">
				<div>
					<div class="posts">
						<h1 class="content-subhead">Ambient Data Framework - Claims</h1>

						<section class="post">
							<header class="post-header">
								<h2 class="post-title">Current claims and values</h2>
								<!--
								<div class="topBar">
									Filter: <input type="text" placeholder="Enter search term" data-bind="textInput: filter" />
								</div>
								<div class="refreshArea">
									<span data-bind="visible: loading">Loading...</span>
									<button class="refreshButton" data-bind="click: refresh, visible:!autoRefresh()">Refresh</button>
									<input id="chkAutoRefresh" type="checkbox" data-bind="checked: autoRefresh"><label for="chkAutoRefresh">Refresh automatically</label></input>
								</div>
								-->
							</header>

							<div class="post-description">
								<table class="mq-table pure-table-bordered pure-table">
									<thead>
										<th>Name</th>
										<th>Value</th>
									</thead>
									<tbody data-bind="foreach: claims">
										<tr>
											<td data-bind="text: key"></td>
											<!-- ko if: (nestedValues.length == 0) -->
											<td data-bind="text: value"></td>
											<!-- /ko -->							
											<!-- ko if: (nestedValues.length > 0) -->
											<td>
												<ul data-bind="foreach: { data: nestedValues, as: 'entry'}">
													<li>
														<span data-bind="text: entry.key"></span><!-- ko if: entry.value -->: <span data-bind="text: entry.value"></span><!-- /ko -->
													</li>
												</ul>
											</td>
											<!-- /ko -->
										</tr>
									</tbody>
								</table>
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