package com.meaningfarm.mall.product;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
	
	Logger logger = LoggerFactory.getLogger(ProductService.class);
	
	@Autowired
	private ProductDAO productDAO;
	
	public List<ProductVO> productList() {
		List<ProductVO> productList = null;
		productList = productDAO.productList();
		logger.info("ProductService productList " + productList);
		return productList;
	}
	
	public ProductVO productDetail(int product_no) {
		logger.info("ProductService productDetail");
		ProductVO productDetail = productDAO.productDetail(product_no);
		return productDetail;
	}
	
	public int productInsert(ProductVO productVO) {
		logger.info("ProductService productInsert");
		// if문을 vo.set~~을 0으로
		if(productVO.getOption_no() == null) {
			productVO.setOption_no(0);
		}
		if(productVO.getProduct_dlvyfee() == null) {
			productVO.setProduct_dlvyfee(0);
		}
		int result = productDAO.productInsert(productVO);
		logger.info("ProductService productInsert result" + productVO);
		int str = productVO.getOption_no();
		logger.info("result " + result);
		return result;
	}
	
	public void productUpdate(ProductVO productVO) {
		logger.info("ProductService productUpdate " + productVO);
		productDAO.productUpdate(productVO);
	}
	
	public void productDelete(int product_no) {
		logger.info("ProductService productDelete " + product_no);
		productDAO.productDelete(product_no);
	}
	
	public List<OptionVO> optionList() {
		List<OptionVO> optionList = null;
		optionList = productDAO.optionList();
		logger.info("ProductService optionList " + optionList);
		return optionList;
	}
	
//	public List<Map<String, Object>> optionList(Map<String, Object> optionListMap) {
//		logger.info("ProductService optionList");
//		List<Map<String, Object>> optionList = null;
//		optionList = productDAO.optionList(optionListMap);
//		return optionList;
//	}
	
	public OptionVO optionDetail(int option_no) {
		logger.info("ProductService optionDetail");
		OptionVO optionDetail = productDAO.optionDetail(option_no);
		return optionDetail;
	}
	
	public int optionInsert(OptionVO optionVO) {
		logger.info("ProductService optionInsert");
		int result = productDAO.optionInsert(optionVO);
		return result;
	}
	
	public void optionUpdate(OptionVO optionVO) {
		logger.info("ProductService optionUpdate " + optionVO);
		productDAO.optionUpdate(optionVO);
	}
	
	public void optionDelete(int option_no) {
		logger.info("ProductService optionDelete " + option_no);
		productDAO.optionDelete(option_no);
	}

	public void optionCheckDelete(int option_no) {
		logger.info("ProductService optionDelete " + option_no);
		productDAO.optionDelete(option_no);
	}

}
