package com.meaningfarm.mall.product;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;
import net.sf.json.JSONArray;

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
//	@GetMapping("/productinsert")
//	public void productInsert() {
//		logger.info("글 작성");
//	}
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
		
		List<CategoryTypeVO> CTList = null;
		CTList = productService.CTList();
		model.addAttribute("selectCategoryType", JSONArray.fromObject(CTList));
		
		List<CategoryLocalVO> CLList = null;
		CLList = productService.CLList();
		model.addAttribute("selectCategoryLocal", JSONArray.fromObject(CLList));
		return "product/productdetail";
	}
	// product 상품 수정
	@PostMapping("/productdetail")
	public String productUpdate(ProductVO productVO) {
		logger.info("ProductController productUpdate " + productVO);
		productService.productUpdate(productVO);
		return "redirect:/product/productlisttest";
	}
	// product 상품 삭제
	@PostMapping("/productdelete")
	public String productDelete(ProductVO productVO) {
		logger.info("ProductController productDelete " + productVO);
		productService.productDelete(productVO.getProduct_no());
		return "redirect:/product/productlisttest";
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
	
	
	
//	@GetMapping("/optioncategory")
//	public void optionCategory(Model model) throws Exception {
//		logger.info("productController optionCategory");
//		ObjectMapper objm = new ObjectMapper();
//		List list = productService.optionList();
//		String optionCategoryList = objm.writeValueAsString(list); // java 객체를 string 타입의 json 형식 데이터로 변환
//		model.addAttribute("optionSelectAll", optionCategoryList);
//		logger.info("list " + list);
//		logger.info("optionCategoryList " + optionCategoryList);
//	}
	
	
	
	
	
	
	
	
	
	
	@GetMapping(value={"/productinsert"})
	public void categoryList(Model model) throws Exception {
		logger.info("ProductController CTList");
		List<CategoryTypeVO> CTList = null;
		CTList = productService.CTList();
		model.addAttribute("selectCategoryType", JSONArray.fromObject(CTList));
		
		List<CategoryLocalVO> CLList = null;
		CLList = productService.CLList();
		model.addAttribute("selectCategoryLocal", JSONArray.fromObject(CLList));
	}
	
	@PostMapping("/insertimg")
//	public void insertImg(@RequestParam(value="uploadImg") MultipartFile uploadImg) {
	public void insertImg(@RequestParam(value="uploadImg") MultipartFile[] uploadImg) {
		logger.info("insertImg");
		String uploadFolder = "C:\\upload";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);
		
		File uploadPath = new File(uploadFolder, datePath);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile multipartImg : uploadImg) {
//			logger.info("파일 이름 " + uploadImg.getOriginalFilename());
//			logger.info("파일 타입 " + uploadImg.getContentType());
//			logger.info("파일 크기 " + uploadImg.getSize());
			
			String uploadImgName = multipartImg.getOriginalFilename(); // 파일 이름
			String uuid = UUID.randomUUID().toString();
			uploadImgName = uuid + "_" + uploadImgName;
			File saveImg = new File(uploadPath, uploadImgName); // 파일 위치, 파일 이름을 합친 File 객체
			// 파일 저장
			try {
				multipartImg.transferTo(saveImg);
				File thumbnailImg = new File(uploadPath, "s_" + uploadImgName);
				/*
				 * 방법 1
				 * BufferedImage bo_image = ImageIO.read(saveImg); double ratio = 3; // 비율 int
				 * width = (int)(bo_image.getWidth() / ratio); // 너비 int height =
				 * (int)(bo_image.getHeight() / ratio); // 너비 BufferedImage bt_image = new
				 * BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR); Graphics2D
				 * graphic = bt_image.createGraphics(); graphic.drawImage(bo_image, 0, 0, 300,
				 * 300, null); ImageIO.write(bt_image, "jpg", thumbnailImg);
				 */
				// 방법 2
				Thumbnails.of(saveImg).size(160, 160).toFile(thumbnailImg);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
