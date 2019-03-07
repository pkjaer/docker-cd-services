<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"
         import="
			com.tridion.broker.StorageException,
			com.tridion.dcp.ComponentPresentation,
			com.tridion.dcp.ComponentPresentationFactory,
			com.tridion.util.TCMURI,
			java.text.ParseException" %>
<%!
	public boolean isEmpty(String input) {
		return "".equals(input) || input == null;
	}
	
	public String renderComponent(String id) throws StorageException,ParseException {
		TCMURI parsed = new TCMURI(id);
		ComponentPresentationFactory factory = new ComponentPresentationFactory(parsed.getPublicationId());
		ComponentPresentation cp = factory.getComponentPresentationWithHighestPriority(parsed.getItemId());
		return cp.getContent();
	}
%>
 <%
	String componentId = request.getParameter("id");

	if (!isEmpty(componentId)) {
		out.println(renderComponent(componentId));
	}
%>