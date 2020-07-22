
package com.koreait.projectE.command;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.projectE.commom.Command;
import com.koreait.projectE.dao.ListDAO;
import com.koreait.projectE.dto.DepartmentDTO;

public class SearchCommand implements Command {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();		
		HttpServletRequest request = (HttpServletRequest) map.get("request");	
		
		String query = request.getParameter("main-search");		
		ListDAO lDAO = sqlSession.getMapper(ListDAO.class);
		
		//검색한 결과를 가져온다 .
		ArrayList<DepartmentDTO> list = lDAO.search_list(query);		
		model.addAttribute("list", list);
		model.addAttribute("size", list.size());
		
		

	}

}
