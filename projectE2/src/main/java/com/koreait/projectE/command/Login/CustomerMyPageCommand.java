package com.koreait.projectE.command.Login;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.projectE.commom.Command;
import com.koreait.projectE.dao.LoginDAO;
import com.koreait.projectE.dto.AppointmentDTO;
import com.koreait.projectE.dto.ReviewDTO;

public class CustomerMyPageCommand implements Command {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession(); 
		
		//회원 로그인시 session에서 cNo를 가져온다.
		int cNo = (Integer) session.getAttribute("cNo");
		LoginDAO lDAO = sqlSession.getMapper(LoginDAO.class);
		
		//회원 정보를 가져온다.
		model.addAttribute("cDTO", lDAO.selectBycNo(cNo));
		
		//로그인한 회원의 리뷰정보를 가져온다.
		ArrayList<ReviewDTO> list = lDAO.customerMyReview(cNo);
		model.addAttribute("list", list);
		
		//가져온 리뷰정보에는 음식점 이름이 없기 때문에 
		//ArrayList<ReviewDTO> list 에서 한개씩 꺼내와 
		//DEPARTMENT_INFO 테이블에서 음식점 이름을 가져와 
		// dNames 에 저장 
		ArrayList<String> dNames =new ArrayList<String>();
		for(int i =0 ; i<list.size(); i++) {
			dNames.add( lDAO.deptName(list.get(i).getdSaup_no()));
		}
		model.addAttribute("dList", dNames);
		
		//로그인한 회원의 예약한 정보를 가져온다 .
		ArrayList<AppointmentDTO> list2 = lDAO.customerMyAppointment(cNo);
		model.addAttribute("list2", list2);
		
		//예약 테이블에 음식점 이름이 없기 때문에 
		//음식점 이름과 연락처를 가져와 dNames2에 저장
		ArrayList<String> dNames2 = new ArrayList<String>();
		for(int i =0 ; i<list2.size(); i++) {
			dNames2.add( lDAO.deptName(list2.get(i).getdSaup_no()));
			dNames2.add( lDAO.deptPhone(list2.get(i).getdSaup_no()));
		}
		model.addAttribute("dList2", dNames2);
	}

}
