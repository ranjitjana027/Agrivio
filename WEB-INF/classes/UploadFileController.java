// compile with : javac -cp ../../../../lib/servlet-api.jar;../lib/*; UploadFileController.java
import java.io.*;
import java.nio.file.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.transfer.TransferManagerConfiguration;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10 MB
maxFileSize = 1024 * 1024 * 50, // 50 MB
maxRequestSize = 1024 * 1024 * 100) // 100 MB
public class UploadFileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
  	private static final String UPLOAD_DIR = "index";
	private static String bucketName = "agrivio-assets";

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("application/json");
		HttpSession session=request.getSession();
		PrintWriter out = response.getWriter();
		System.out.println(request.getPart("file").getSubmittedFileName());
		String folder=request.getParameter("folder");
		if(session.getAttribute("userid")==null || request.getPart("file").getSubmittedFileName()==null){
			out.println("{ \"success\": false}");
		}
		else{
			boolean success=false;
			AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
	                    .withRegion("us-east-1")
	                    .build();

	    //get file part from request
			Part filePart = request.getPart("file");

			//get type of file added
			String contentType = filePart.getContentType();

			//get submitted filename.
			//if didn't add enctype attribute, we might only get file name
			String fileName = filePart.getSubmittedFileName();
			System.out.println(fileName);
			long fileSize = filePart.getSize();
			String ext=((fileName.lastIndexOf(".")!=-1) && (fileName.lastIndexOf(".")!=0))? fileName.substring(fileName.lastIndexOf(".")) : "";
			fileName=ext.equals("")?fileName:fileName.substring(0,fileName.lastIndexOf(ext));
			File file = File.createTempFile(fileName, ext);
			try (InputStream fileContent = filePart.getInputStream()) {
	        Files.copy(fileContent, file.toPath(),StandardCopyOption.REPLACE_EXISTING);
	    }

			String uploadedFileName=(folder==null)?file.getName():folder+"/"+file.getName();
	  	if (contentType.startsWith("image/") || contentType.startsWith("video/")) {

		    try {
			      	System.out.println("Uploading file to s3");
			      	//s3Client.putObject(bucketName, fileName, "Uploaded String Object");


					PutObjectRequest pRequest = new PutObjectRequest(bucketName,uploadedFileName, file);
					 ObjectMetadata metadata = new ObjectMetadata();
					 metadata.setContentType(contentType);
					 //metadata.addUserMetadata("title", "someTitle");
					 pRequest.setMetadata(metadata);
					 s3Client.putObject(pRequest);
					 success=true;
		    }
				catch (AmazonServiceException ase) {
		      System.out
		          .println("Caught an AmazonServiceException, which "
		              + "means your request made it "
		              + "to Amazon S3, but was rejected with an error response"
		              + " for some reason.");
		      System.out.println("Error Message:    " + ase.getMessage());
		      System.out.println("HTTP Status Code: " + ase.getStatusCode());
		      System.out.println("AWS Error Code:   " + ase.getErrorCode());
						System.out.println("Error Type:       " + ase.getErrorType());
						System.out.println("Request ID:       " + ase.getRequestId());
					}
				catch (AmazonClientException ace) {
					System.out.println("Caught an AmazonClientException, which "
							+ "means the client encountered "
							+ "an internal error while trying to "
							+ "communicate with S3, "
							+ "such as not being able to access the network.");
					System.out.println("Error Message: " + ace.getMessage());
					ace.printStackTrace();
				}
				finally{
					if(success){
						out.println("{ \"success\": true, \"filename\": \""+uploadedFileName+"\"}");
					}
					else{
						out.println("{ \"success\": false}");
					}
				}
			}
			else {
				System.out.println("Invalid File Type.");
				out.println("{ \"success\": false}");
	    }
		}

	}

}
