package com.koreait.projectE.command.Board;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.projectE.commom.Command;
import com.koreait.projectE.dao.BoardDAO;
import com.koreait.projectE.dto.DepartmentDTO;

public class ReviewWriteCommand implements Command {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map  =model.asMap();
		HttpServletRequest request =(HttpServletRequest) map.get("request");
		
		//REVIEW 테이블은 외래키로 DEPARTMENT_INFO 테이블의 DSAUP_NO 와 
		// CUSTOMER 테이블의 CNO 을 외래키로 가지고있다 .
		String dSaup_no = request.getParameter("dSaup_no");
		int cNo = Integer.parseInt(request.getParameter("cNo"));
		
		//REVIEW 테이블에는 음식점 이름이 없기 때문에 
		//DEPARTMENT_INFO 테이블에서 음식점 이름을 가져온다.
		BoardDAO bdao = sqlSession.getMapper(BoardDAO.class);
		DepartmentDTO deptDTO = bdao.DepartView(dSaup_no);
		
		model.addAttribute("deptDTO", deptDTO);
		model.addAttribute("cNo", cNo);
		
		
	}

}
