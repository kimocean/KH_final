package com.meaningfarm.mall.product;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private ProductService productService;
	
//	@GetMapping("/list")
//	public void productList() {
//		logger.info("게시판 목록");
//	}
	// product 상품 목록 페이지 띄우기
	@GetMapping("/productlisttest")
	public String productList(Model model) {
		logger.info("ProductController productList");
		model.addAttribute("productSelectAll", productService.productList());
		logger.info(productService.productList().toString());
		return "product/productlisttest";
	}
	// product 상품 등록 창 띄우기
	@GetMapping("/productinsert")
	public void productInsert() {
		logger.info("글 작성");
	}
	// product 상품 등록 버튼 누를 때
	@PostMapping("/productinsert")
	public String productInsert(ProductVO productVO) {
		logger.info("글 작성 버튼 누름 ProductVO " + productVO);
		productService.productInsert(productVO);
		return "redirect:/product/productlisttest";
	}
	// product 상품 상세 창으로 가는 거
	@GetMapping("/productdetail")
	public String productDetail(ProductVO productVO, Model model) {
		logger.info("ProductController productDetail");
		model.addAttribute("productSelectOne", productService.productDetail(productVO.getProduct_no()));
		return "product/productdetail";
	}
	// product 상품 수정
	@PostMapping("/productdetail")
	public String productUpdate(ProductVO productVO) {
		logger.info("ProductController productUpdate");
		productService.productUpdate(productVO);
		return "redirect:/product/productlist";
	}
	// product 상품 삭제
	@PostMapping("/productdelete")
	public String productDelete(ProductVO productVO) {
		logger.info("ProductController productDelete " + productVO);
		productService.productDelete(productVO.getProduct_no());
		return "redirect:/product/productlist";
	}
	// product 옵션 설정 창으로 이동
	@RequestMapping("/product/optionpopup")
	public String optionPopup() {
		return "product/optionpopup";
	}
	
	///////////////////////////////////////////////////////////////////////
	
	// option 목록 창으로 이동
	@GetMapping("/optionlist")
	public String optionList(Model model) {
		logger.info("ProductController optionList");
		model.addAttribute("optionSelectAll", productService.optionList());
		logger.info(productService.optionList().toString());
		return "product/optionlist";
	}
	
//	@GetMapping("/optionpopup")
//	public String optionList(@RequestParam Map<String, Object> optionListMap, Model model) {
//		logger.info("ProductController optionList " + optionListMap.toString());
//		List<Map<String, Object>> optionList = null;
//		optionList = productService.optionList(optionListMap);
//		logger.info("ProductController optionList " + optionListMap.toString());
//		return "forward:optionpopup";
//	}
	// option 등록 창 띄우기
	@GetMapping("/optioninsert")
	public void optionInsert() {
		logger.info("ProductController get-optioninsert");
	}
	// option 등록 버튼 누를 때
	@PostMapping("/optioninsert")
	public String optionInsert(OptionVO optionVO) {
		logger.info("글 작성 버튼 누름 OptionVO " + optionVO);
		productService.optionInsert(optionVO);
		return "redirect:/product/optionpopup";
	}
	// option 옵션 상세 창으로 가는 거
	@GetMapping("/optiondetail")
	public String optionDetail(OptionVO optionVO, Model model) {
		logger.info("ProductController optionDetail");
		model.addAttribute("optionSelectOne", productService.optionDetail(optionVO.getOption_no()));
		return "product/optiondetail";
	}
	// option 상품 수정
	@PostMapping("/optiondetail")
	public String optionUpdate(OptionVO optionVO) {
		logger.info("ProductController optionUpdate " + optionVO);
		productService.optionUpdate(optionVO);
		return "redirect:/product/optionpopup";
	}
	// option 옵션 삭제
	@PostMapping("/optiondelete")
	public String optionDelete(OptionVO optionVO) {
		logger.info("ProductController optionDelete " + optionVO);
		productService.optionDelete(optionVO.getOption_no());
		return "redirect:/product/optionpopup";
	}
	// option 옵션 선택 삭제
	@PostMapping("/optioncheckdelete")
	public String optionCheckDelete(@RequestParam(value="option_nos", required=false) String option_nos, Model model) {
		List<String> optionCheckList = null;
		optionCheckList = new ArrayList<String>(Arrays.asList(option_nos.split(",")));
		for(String option_no : optionCheckList) {
			productService.optionDelete(Integer.parseInt(option_no));
		}
		return "redirect:/product/optionpopup";
	}
}
