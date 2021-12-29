package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.zerock.domain.AttachFileDTO;
import org.zerock.domain.testDTO;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import java.util.LinkedList;
@Controller
@Log4j
public class UploadController {

	
	private boolean checkImageType(File file) {//

		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	
	
//泥⑤��뙆�씪 �뾽濡쒕뱶
	
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String uploadAjaxPost(@RequestParam("files[]") List<MultipartFile> files) throws IOException, ServletException {
		
//		System.out.println("-----> " + files.get(0).getOriginalFilename());
		String orName=files.get(0).getOriginalFilename();
		List<AttachFileDTO> list = new ArrayList<>();

		String uploadFolder = "C:\\kym\\eclipse\\workspace\\training\\src\\main\\webapp\\resources";
//		String uploadFolder = "C:\\kym\\eclipse\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\training\\resources";
		String uploadFolderPath = "\\img";
		
		JSONObject tFileBox = new JSONObject();
		JSONArray tfileArr = new JSONArray();
		JSONObject fileUrl = new JSONObject();
		JSONObject filePath = new JSONObject();
		JSONObject fileWid = new JSONObject();
		JSONObject fileHei = new JSONObject();
		JSONObject fileNam = new JSONObject();
		
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		if (uploadPath.exists() == false) {  
			uploadPath.mkdirs();
		}
		
		for (MultipartFile multipartFile : files) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName =orName;

			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			log.info("only file name: " + uploadFileName);
			
			
			attachDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);

				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());

				attachDTO.setUploadPath(uploadFolderPath);

				if (checkImageType(saveFile) && multipartFile.getSize()<=5242880) {
					attachDTO.setImage(true);
				} 
				list.add(attachDTO);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
			fileUrl.put("url", "/resources/img/"+uploadFileName);
			filePath.put("path", "\\img/"+uploadFileName);
			fileWid.put("width", "50px");
			fileHei.put("height", "50px");
			fileNam.put("name", orName);
			tfileArr.put(fileUrl);
			tfileArr.put(filePath);
			tfileArr.put(fileWid);
			tfileArr.put(fileHei);
			tfileArr.put(fileNam);
			tFileBox.put("files", tfileArr);
		} // end for
		

//		t.put("fileName", "aaa.jpg");
//		t.put("uploadPath", "\\\\img");
//		t.put("uuid", "a117932f-a94d-4138-86c5-bf0b9e796510");
//		t.put("image", "true");
	
		System.out.println(tFileBox);
	

		return tFileBox.toString();
	}

	
	
	@PostMapping(value = "/uploadAjaxActions", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPostt(MultipartFile[] tuploadFile) {
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\kym\\eclipse\\workspace\\training\\src\\main\\webapp\\resources";
		String uploadFolderPaths = "\\thumb";
							
		File uploadPaths = new File(uploadFolder, uploadFolderPaths);
for (MultipartFile multipartFile : tuploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();

			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			
			attachDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
					attachDTO.setUuid(uuid.toString());
					
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPaths, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);
					
					thumbnail.close();
					
				list.add(attachDTO);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} // end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody			
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) throws UnsupportedEncodingException {
		
		Resource resource = new FileSystemResource("C:\\kym\\eclipse\\workspace\\training\\src\\main\\webapp\\resources\\" + fileName);

		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND); 
		}
		String resourceName = resource.getFilename();

		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();
		try {

			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
			
			String downloadName = null;

			if (checkIE) { 
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF8").replaceAll("\\+", " ");
			} else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		File file;

		try {
			file = new File("C:\\kym\\eclipse\\workspace\\training\\src\\main\\webapp\\resources" + URLDecoder.decode(fileName, "UTF-8"));
			log.info("00000 " +  URLDecoder.decode(fileName, "UTF-8"));
			file.delete();

	
			if (type.equals("image")) {

//				String largeFileName = file.getAbsolutePath().replace("s_", "");
				String largeFileName = file.getAbsolutePath().replace("%2Fresources%2Fimg%2", "\\img\\");


				file = new File(largeFileName);
				System.out.println(file);
				file.delete();
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}
	
	@PostMapping("/tdeleteFile")
	@ResponseBody
	public ResponseEntity<String> tdeleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);
		log.info("deleteFile type: " + type);

		File file;

		try {
			file = new File("C:\\kym\\eclipse\\workspace\\training\\src\\main\\webapp\\resources" + URLDecoder.decode(fileName, "UTF-8"));
			log.info("00000 " +  URLDecoder.decode(fileName, "UTF-8"));
			file.delete();

	
			if (type.equals("image")) {

				String largeFileName = file.getAbsolutePath().replace("s_", "");

				log.info("largeFileName: " + largeFileName);

				file = new File(largeFileName);

				file.delete();
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}

}