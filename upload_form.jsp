<form
	action="<%=request.getContextPath() %>/UploadFileController"
	method="post"
	enctype="multipart/form-data">
		<input type="text" name="description" />
		<input type="file"name="file" />
		<input type="submit" />
</form>
