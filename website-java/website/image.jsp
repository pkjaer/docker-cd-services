<%@page language="java" contentType="image/jpeg" import="java.io.*, javax.servlet.http.HttpServletResponse, com.tridion.content.BinaryFactory, com.tridion.data.BinaryData" %>
<%!
	public boolean isEmpty(String input) {
		return "".equals(input) || input == null;
	}
	
	public BinaryData getBinaryData(String id) {
		BinaryFactory factory = new BinaryFactory();
		return factory.getBinary(id);
	}
	
	public void writeImage(String id, HttpServletResponse response) throws IOException {
		BinaryData imageData = getBinaryData(id);
		if (imageData == null) {
			return;
		}

		InputStream inputStream = imageData.getInputStream();
		if (inputStream == null) {
			return;
		}
		
		OutputStream outputStream = response.getOutputStream();

		byte[] buffer = new byte[32 * 1024];
		int read = 0;

		while ((read = inputStream.read(buffer)) > -1) {
			outputStream.write(buffer, 0, read);
		}

		outputStream.flush();
		outputStream.close();
	}
%>
 <%
	String componentId = request.getParameter("id");

	if (!isEmpty(componentId)) {
		writeImage(componentId, response);
	}
%>