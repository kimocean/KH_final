package com.meaningfarm.mall.product;

import java.util.List;

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
	
	public void productInsert(ProductVO productVO) {
		logger.info("ProductService productInsert");
		// if문을 vo.set~~을 0으로
		if(productVO.getProduct_dlvyfee() == null) {
			productVO.setProduct_dlvyfee(0);
		}
		productDAO.productInsert(productVO);
		logger.info("ProductService productInsert result" + productVO);
		
	}
	
	public void productUpdate(ProductVO productVO) {
		logger.info("ProductService productUpdate " + productVO);
		productDAO.productUpdate(productVO);
	}
	
	public void productDelete(int product_no) {
		logger.info("ProductService productDelete " + product_no);
		productDAO.productDelete(product_no);
	}
	
	
	
	
	public List<CategoryTypeVO> CTList() {
		List<CategoryTypeVO> CTList = null;
		CTList = productDAO.CTList();
		return CTList;
	}

	public List<CategoryLocalVO> CLList() {
		List<CategoryLocalVO> CLList = null;
		CLList = productDAO.CLList();
		return CLList;
	}
	
//	public List<ProductFileVO> productfileList(int product_no) {
//		List<ProductFileVO> PFList = null;
//		PFList = productDAO.productfileList(product_no);
//		return PFList;
//	}

	public int productfileInsert(ProductFileVO productfileVO) {
		logger.info("ProductService productfileInsert");
		int result = productDAO.productfileInsert(productfileVO);
		logger.info("ProductService productfileInsert result" + productfileVO);
		logger.info("result " + result);
		return result;
	}

	public void productfileDelete(int productfile_no) {
		logger.info("ProductService productfileDelete " + productfile_no);
		productDAO.productfileDelete(productfile_no);		
	}

}
