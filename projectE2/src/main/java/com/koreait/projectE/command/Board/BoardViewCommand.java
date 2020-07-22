package com.koreait.projectE.command.Board;

import java.util.ArrayList;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.projectE.commom.Command;
import com.koreait.projectE.dao.BoardDAO;
import com.koreait.projectE.dto.DepartmentDTO;
import com.koreait.projectE.dto.MenuDTO;
import com.koreait.projectE.dto.ReviewDTO;

public class BoardViewCommand implements Command {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		BoardDAO bdao =sqlSession.getMapper(BoardDAO.class);
		
		Map<String,Object> map = model.asMap();
				
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String dSaup_no = request.getParameter("dSaup_no");
		
		//페이지 요청시 hit 수 증가  
		bdao.UpdateHit(dSaup_no);
		//페이지 로딩시 작성되어 있는 리뷰를 가지고 평점을 업데이트 시킨다.(리뷰 작성 또는 삭제시 에서도 가능)
		bdao.DepartRatingUpdate(dSaup_no);
		
		//view 페이지 업체 정보 가져오기 
		DepartmentDTO deptDTO =bdao.DepartView(dSaup_no);
		model.addAttribute("deptDTO", deptDTO);
		
		//같은 지역내 주변 인기 식당을 보여주기 위해 DB에 저장된 주소중 
		//첫번째 공백 다음 부터 두번째 공백 전까지의 데이터를 가져와
		//주변 인기 식당 리스트를 가져온다.
		String address =deptDTO.getdAddress();
		String[] addr =address.split(" ");
		//ex addr[0]="서울특별시"
		//addr[1] ="은평구" 
		model.addAttribute("side_list",  bdao.getSide_list(addr[1],deptDTO.getdName()));
		
		//APPOINTMENT(예약자 db)에서 총 예약 갯수 가져오기
		model.addAttribute("appointmentCount",bdao.appointmentCount(dSaup_no));
		
		//menu_info 에서 업체 메뉴 가져오기 
		model.addAttribute("menuList", bdao.menuList(dSaup_no));
	
		//view 페이지 리뷰 가져오기 
		ArrayList<ReviewDTO> reviewList = bdao.reviewList(dSaup_no);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("reviewCount",reviewList.size());
		
		
	}

}
