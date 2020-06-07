package bean;

import java.io.*;
import java.nio.file.*;

import com.amazonaws.AmazonClientException;
import com.amazonaws.HttpMethod;
import com.amazonaws.SdkClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.s3.*;
import com.amazonaws.services.s3.model.*;
import com.amazonaws.services.s3.transfer.TransferManagerConfiguration;

import java.net.URL;

public class PresignedUrl implements Serializable{
  String bucketName;
  String objectKey;
  int timer;

  public void setBucketName(String s){
    this.bucketName=s;
  }

  public void setObjectKey(String s){
    this.objectKey=s;
  }

  public void setTimer(int  t){
    this.timer=t;
  }

  public String getUrl(){
    URL url=null;
    try{
        AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                        .withRegion("us-east-1")
                        .build();
        // Set the presigned URL to expire after one hour.
        java.util.Date expiration = new java.util.Date();
        long expTimeMillis = expiration.getTime();
        expTimeMillis += 1000 * this.timer;
        expiration.setTime(expTimeMillis);
        // Generate the presigned URL.
        System.out.println("Generating pre-signed URL.");
        GeneratePresignedUrlRequest generatePresignedUrlRequest =
                new GeneratePresignedUrlRequest(this.bucketName,this.objectKey)
                        .withMethod(HttpMethod.GET)
                        .withExpiration(expiration);
        url = s3Client.generatePresignedUrl(generatePresignedUrlRequest);
    }
    catch (AmazonServiceException e) {
            // The call was transmitted successfully, but Amazon S3 couldn't process 
            // it, so it returned an error response.
            e.printStackTrace();
    } 
    catch (SdkClientException e) {
        // Amazon S3 couldn't be contacted for a response, or the client
        // couldn't parse the response from Amazon S3.
        e.printStackTrace();
    }
    finally{
      return url==null?"":url.toString();
    }
  }

  
}


