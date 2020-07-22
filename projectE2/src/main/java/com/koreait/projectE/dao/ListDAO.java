package com.koreait.projectE.dao;

import java.util.ArrayList;

import com.koreait.projectE.dto.DepartmentDTO;
import com.koreait.projectE.dto.MainListDTO;

public interface ListDAO {
	
	//메인 페이지 시,도 개수 가져오기 
	public ArrayList<MainListDTO> main_list();
	
	// 시 내부의 등록된 업체 리스트 가져오기 
	public ArrayList<DepartmentDTO> location_list(String location);
	
	//시 내부의 등록된 업체 갯수 
	public MainListDTO get_locationCount(String location);
	
	//검색한 지역, 음식점 이름 리스트를 가져온다 .
	public ArrayList<DepartmentDTO> search_list(String query);

		
}
