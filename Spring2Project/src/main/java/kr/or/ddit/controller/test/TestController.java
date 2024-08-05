package kr.or.ddit.controller.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.Image;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/test")
public class TestController {
	
	private String path = "D:\\00.JSP_SPRING\\02.SPRING\\workspace_spring2\\Spring2Project\\src\\main\\webapp\\resources\\image";
	
	public List<Image> fileSearch(String type) throws Exception {
		File dir = new File(path);
		String[] files = dir.list();
		log.info("@@" + type);
		List<Image> list = new ArrayList<Image>();
		for (String fileName : files) {
			log.info("file : " + fileName);
			String contentType = fileName.substring(fileName.indexOf(".") + 1);
			log.info("filename : " + fileName);
			log.info("fileType : " + contentType);
			Image img = new Image();
			img.setFileName(fileName);
			img.setContentType(contentType);
			if (type.equals("all")) {
				list.add(img);
			} else if (contentType.equals(type)) {
				list.add(img);
			}
		}
		return list;
	}
	
	@RequestMapping(value = "/test01.do", method = RequestMethod.GET)
	public String test01(Model model) {
		log.info("test01() 실행...!");
		try {
			model.addAttribute("list", fileSearch("all"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "test/test01";
	}
	
	@ResponseBody
	@RequestMapping(value = "/test01/{type}", method = RequestMethod.GET)
	public List<Image> test01(@PathVariable String type, Model model) {
		log.info("test01(type) 실행...!");
		
		// # 비동기 통신 시, 단일 데이터를 받는 방법 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
		// 1) 클라이언트에서 data : selectedValue로 설정하고 컨트롤러에서는 
		// 		@RequestBody String type과 같이 받는다.
		// 2) 클라이언트에서 data : JSON.stringify(data)로 설정하고 컨트롤러에서는
		// 		@RequestBody Map<String, String> map과 같이 받는다.
		
		List<Image> list = new ArrayList<Image>();
		try {
			list = fileSearch(type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 썸네일 조회
	@ResponseBody
	@RequestMapping(value = "/show_img/{fileName}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> show_img(@PathVariable String fileName){
		log.info("show_img() 실행...!");
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		try {
			in = new FileInputStream(path + "\\" + fileName);
			headers.setContentType(MediaType.IMAGE_JPEG);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return entity;
	}
	
	// 다운로드
	@ResponseBody
	@RequestMapping(value = "/download_img/{fileName}", method = RequestMethod.GET)
	public ResponseEntity<byte[]> download_img(@PathVariable String fileName){
		log.info("download_img() 실행...!");
		log.info("fileName : " + fileName);
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		HttpHeaders headers = new HttpHeaders();
		try {
			in = new FileInputStream(path + "\\" + fileName);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"),"ISO-8859-1") + "\""); 
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return entity;
	}
	
}
