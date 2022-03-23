package com.memo.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	//실제 이미지가 저장되는 경로
	public final static String FILE_UPLOAD_PATH = "D:\\구태현\\6_spring_project\\ex_memo\\workspace\\images/";
	//input : file
	//output: image path
	public String saveFile(String loginId, MultipartFile file) throws IOException {
		// 파일 디렉토리 경로 예: mayo10002_1423723493/sun.png
		// 파일 명이 겹치지 않게 하기 위해 현재 시간을 경로에 붙여준다.
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";
		String filePath = FILE_UPLOAD_PATH + directoryName;
		
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			return null; // 디렉토리 폴더 생성 실패 시 path null 리턴
		}
		
		byte[] bytes = file.getBytes();
		// D:\\구태현\\6_spring_project\\ex_memo\\workspace\\images/mayo10002_1423723493/sun.png
		Path path = Paths.get(filePath + file.getOriginalFilename());
		Files.write(path, bytes);
		
		// http://localhost/images/mayo10002_1423723493/sun.png
		return "/images/" + directoryName + file.getOriginalFilename();
	}
}
