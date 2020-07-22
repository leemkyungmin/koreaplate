package com.koreait.projectE.command.Board;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.projectE.commom.Command;
import com.koreait.projectE.dao.BoardDAO;
import com.koreait.projectE.dto.DepartmentDTO;
import com.koreait.projectE.dto.ReviewDTO;

public class ReviewDetailCommand implements Command {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String,Object> map = model.asMap();
		HttpServletRequest request =(HttpServletRequest) map.get("request");
		 
		//rNo REVIEW 테이블 PK
		int rNo= Integer.parseInt(request.getParameter("rNo"));
		BoardDAO bdao = sqlSession.getMapper(BoardDAO.class);
		
		//REVIEW 테이블에서 rNo 를 이용해 데이터 가져오기 
		ReviewDTO rdto =bdao.reivewDetail(rNo);
		model.addAttribute("rdto", rdto);
		
		
		DepartmentDTO deptdto = bdao.DepartView(rdto.getdSaup_no());
		model.addAttribute("deptdto", deptdto); 
		
	}

}
