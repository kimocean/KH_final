package com.meaningfarm.mall.product;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lombok.Data;

@Data
public class PageVO {
//	// 현재 페이지
//	private int pageNum = 0;
//	// 한 페이지당 보여질 게시물 수
//	private int amount = 0;
//	// 기본 생성자 -> 기본 세팅 : pageNum = 1, amount = 10인데 나는 2로 함
//	public PageVO() {
//		this(1, 2);
//	}
//	public PageVO(int pageNum, int amount) {
//		this.pageNum = pageNum;
//		this.amount = amount;
//	}
	
	// 현재 페이지, 시작 페이지, 끝페이지, 게시글 총 갯수, 페이지당 글 갯수, 마지막 페이지, sql 쿼리에 쓸 start, end
	private int nowPage, startPage, endPage, total, cntPerPage, lastPage, start, end;
	private int cntPage = 5;
	private String m_id = "";
	
	public PageVO() {}
	
	public PageVO(int total, int nowPage, int cntPerPage, String m_id) {
		setNowPage(nowPage);
		setCntPerPage(cntPerPage);
		setTotal(total, m_id);
		setM_id(m_id);
		calcLastPage(getTotal(), getCntPerPage());
		calcStartEndPage(getNowPage(), cntPage);
		calcStartEnd(getNowPage(), getCntPerPage());
	}
	
	// 제일 마지막 페이지 계산
	public void calcLastPage(int total, int cntPerPage) {
		setLastPage((int)Math.ceil((double)total / (double)cntPerPage));
	}
	// 시작, 끝 페이지 계산
	public void calcStartEndPage(int nowPage, int cntPage) {
		setEndPage(((int)Math.ceil((double)nowPage / (double) cntPage)) * cntPage);
		if(getLastPage() < getEndPage()) {
			setEndPage(getLastPage());
		}
		setStartPage(getEndPage() - cntPage + 1);
		if(getStartPage() < 1) {
			setStartPage(1);
		}
	}
	// DB 쿼리에서 사용할 start, end 값 계산
	public void calcStartEnd(int nowPage, int cntPerPage) {
		setEnd(nowPage * cntPerPage);
		setStart(getEnd() - cntPerPage + 1);
	}
	
	public void setTotal(int total, String m_id) {
		setM_id(m_id);
		this.total = total;
	}
	
}
