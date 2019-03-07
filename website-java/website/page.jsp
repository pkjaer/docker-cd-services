<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"
         import="
			com.tridion.broker.StorageException,
			com.sdl.web.api.dynamic.PageContentAssembler, 
			com.sdl.web.api.dynamic.PageContentAssemblerImpl, 
			com.tridion.broker.querying.Query,
			com.tridion.broker.querying.criteria.content.PageURLCriteria,
			java.util.Map, 
			java.util.HashMap" %>
<%!
	public boolean isEmpty(String input) {
		return "".equals(input) || input == null;
	}
	
	public boolean isEmpty(String[] input) {
		return input == null || input.length < 1;
	}
	
	public Map<String, String> getContentParameters() {
		Map<String, String> parameters = new HashMap<String, String>();
		//String queryString = request.getQueryString();
		//parameters.put("QueryStringParameters", queryString);
		return parameters;
	}
	
	public String renderPage(String id) throws StorageException {
		PageContentAssembler pageAssembly = new PageContentAssemblerImpl();
		return pageAssembly.getContent(id, getContentParameters());
	}
	
	public String renderPageByUrl(String url) throws StorageException {
		Query query = new Query();
		query.setCriteria(new PageURLCriteria(url));
		String[] result = query.executeQuery();
		
		if (!isEmpty(result)) {
			return renderPage(result[0]);
		}
		return "<h1>The requested page could not be found.</h1>";
	}
%>
<%
	String pageId = request.getParameter("id");
	String pageUrl = request.getParameter("url");

	if (!isEmpty(pageId)) {
		out.println(renderPage(pageId));
	} else if (!isEmpty(pageUrl)) {
		out.println(renderPageByUrl(pageUrl));
	}
%>