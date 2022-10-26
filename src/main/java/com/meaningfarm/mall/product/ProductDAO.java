package com.meaningfarm.mall.product;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {
	Logger logger = LoggerFactory.getLogger(ProductDAO.class);
	
	@Autowired
	SqlSessionTemplate sst;
	
	public List<ProductVO> productList() {
		List<ProductVO> productList = null;
		productList = sst.selectList("productSelectAll");
		logger.info("ProductDAO productList " + productList);
		return productList;
	}
	
	public ProductVO productDetail(int product_no) {
		logger.info("ProductDAO productDetail product_no " + product_no);
		return sst.selectOne("productSelectOne", product_no);
	}
	
	public int productInsert(ProductVO productVO) {
		logger.info("ProductDAO productInsert");
		int result = 0;
		result = sst.insert("productInsert", productVO);
		logger.info("ProductDAO productInsert result " + result);
		return result;
	}
	
	public void productUpdate(ProductVO productVO) {
		logger.info("ProductDAO productUpdate " + productVO);
		sst.update("productUpdate", productVO);
	}
	
	public void productDelete(int product_no) {
		logger.info("ProductService productDelete " + product_no);
		sst.delete("productDelete", product_no);
	}
	
	public List<OptionVO> optionList() {
		List<OptionVO> optionList = null;
		optionList = sst.selectList("optionSelectAll");
		logger.info("ProductDAO optionList " + optionList);
		return optionList;
	}
	
//	public List<Map<String, Object>> optionList(Map<String, Object> optionListMap) {
//		logger.info("ProductDAO optionList");
//		List<Map<String, Object>> optionList = null;
//		optionList = sst.selectList("optionSelectAll", optionListMap); // 여기 앞에는 xml name 적기
//		return optionList;
//	}
	
	public OptionVO optionDetail(int option_no) {
		logger.info("ProductDAO optionDetail option_no " + option_no);
		return sst.selectOne("optionSelectOne", option_no);
	}

	public int optionInsert(OptionVO optionVO) {
		int result = 0;
		result = sst.insert("optionInsert", optionVO);
		logger.info("ProductDAO optionInsert result " + result);
		return result;
	}
	
	public void optionUpdate(OptionVO optionVO) {
		logger.info("ProductDAO optionUpdate " + optionVO);
		sst.update("optionUpdate", optionVO);
	}
	
	public void optionDelete(int option_no) {
		logger.info("ProductService optionDelete " + option_no);
		sst.delete("optionDelete", option_no);
	}
	
	
	
	
	public List<CategoryLocalVO> CLList() {
		List<CategoryLocalVO> CLList = null;
		CLList = sst.selectList("selectCategoryLocal");
		return CLList;
	}
	
	public List<CategoryTypeVO> CTList() {
		List<CategoryTypeVO> CTList = null;
		CTList = sst.selectList("selectCategoryType");
		return CTList;
		
	}
}
