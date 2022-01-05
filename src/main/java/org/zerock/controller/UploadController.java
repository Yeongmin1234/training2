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

	
	private boolean checkImageType(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	
	
	
	
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
	
	//img
//================================================================================================================================================================================================
    //file
	
	@PostMapping("/fileUploadFormAction")
	public void fileUploadFormAction(MultipartFile[] uploadFile, Model model) {
							//두개 이상을 선택하기 위해 배열에다가 저장
		String uploadFolder = "C:\\upload";
						//어디다가 파일 업로드 할껀지의 경로
		for (MultipartFile multipartFile : uploadFile) {

			log.info("-------------------------------------");
			log.info("Upload File Name: " + multipartFile.getOriginalFilename());
			log.info("Upload File Size: " + multipartFile.getSize());

			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			//C:\\upload에 실제파일명 문자열을 saveFile변수에 저장
			log.info("saveFile : "+saveFile);
			try { 
				multipartFile.transferTo(saveFile);
							//transferTo(파일명) : 파일명으로 저장
			} catch (Exception e) {
				log.error(e.getMessage());
			}  //end catch
		}  //end for

	}
	
	private String fileGetFolder() {//이해함 ㅇㅇㅇ

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜형태(format)를 년/월/일 형태로 sdf변수에 저장 
		Date date = new Date();
		//오늘날짜를 저장하는 date변수에 저장 
		String str = sdf.format(date);
		//오늘날짜를  년/월/일 형태(format)로 str변수에 저장

		return str.replace("-", File.separator);
				 // 치환함수 // -를   \\로 변경시켜줌(ex.2021-10-27 ->2021\\10\\27
	}
	
	private boolean fileCheckImageType(File file) {//

		try {
			String contentType = Files.probeContentType(file.toPath());
					//받은 타입이                     파일형식을 보는 메소드                   = file의 형식을 가져온다.
			return contentType.startsWith("image");
					//이미지타입이면(true) 리턴
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}
	

	@PostMapping(value = "/fileUploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> fileUploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("uploadFile : " +uploadFile[0].getOriginalFilename());
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "C:\\upload\\";
		String uploadFolderPath = fileGetFolder(); 	 
							
		log.info("getFolder : "+uploadFolderPath);
		// make folder --------
		File uploadPath = new File(uploadFolder, uploadFolderPath); 
		if (uploadPath.exists() == false) {  
			uploadPath.mkdirs();  
		}
		
		
		for (MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			String uploadFileName = multipartFile.getOriginalFilename();
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

				if (fileCheckImageType(saveFile) && multipartFile.getSize()<=10240000) {
					attachDTO.setImage(true);
				} 
				list.add(attachDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}  
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	
	
	
	@GetMapping("/fileDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> fileGetFile(String fileName) {

		log.info("fileName: " + fileName);
							//경로안에있는 섬네일 이미지파일이름
		File file = new File("C:\\upload\\" + fileName);
							//C:\\upload\\+경로안에있는 섬네일 이미지파일이름
		log.info("file: " + file);

		ResponseEntity<byte[]> result = null;//???

		try {
			HttpHeaders header = new HttpHeaders();
			//HttpHeaders는 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송을 할 수 있게 한다.
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			//헤더에. 추가		받은타입                     	파일형식을 보는 메소드                   = file의 형식을 가져온다.
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
											//지정한 파일의 정보를새로운 byte[]로 저장함
			//									 body부분 값을 전송                                  헤더값을 전송 , 상태		           
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	
	
	
	
	@GetMapping(value = "/fileDownload", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody					 //다운로드 할 수 있는 환경을 header에 추가
	public ResponseEntity<Resource> fileDownloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
//마임을 쓰기 위해서 produces = MediaType.APPLICATION_OCTET_STREAM_VALUE , Resource , @RequestHeader("User-Agent") String userAgent들이 꼭 있어야함 
		Resource resource = new FileSystemResource("C:\\upload\\" + fileName);
//다운로드를 할수 있는 클래스=Resource
		if (resource.exists() == false) { // 다운로드 할 파일이 존재하지 않으며
			return new ResponseEntity<>(HttpStatus.NOT_FOUND); //파일이 없다라는 메세지 웹브라우저에게 전달
		}
		// 다운로드할 파일을 가져와서 resourceName에 전환
		String resourceName = resource.getFilename();

		// remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
												//substring특성상 + 1을 하지 않으면 _부터 나옴 
		HttpHeaders headers = new HttpHeaders();
		try {

			boolean checkIE = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
																				//익스플로어를 의미																	
			String downloadName = null;

			if (checkIE) { //checkIE가 트루이면 지금 현재 사용자의 브라우저가 인터넷 익스플로어라는 의미
				//인터넷 익스플로어 브라우저 전용
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF8").replaceAll("\\+", " ");
								//이것을 하지 않으면 다운로드 할 때 한글이 깨짐
			} else {
				//인터넷 익스플로어를 제외하고 처리하는 방식
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			headers.add("Content-Disposition", "attachment; filename=" + downloadName);

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
			//			  다운로드 할수 있도록 처리(resource),HttpHeaders객체를 이용해서(headers)
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	
	
	
	@PostMapping("/fileDeleteFile")
	@ResponseBody
	public ResponseEntity<String> fileDeleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);

		File file;

		try {
			file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

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