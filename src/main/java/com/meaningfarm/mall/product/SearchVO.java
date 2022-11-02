package com.meaningfarm.mall.product;

import lombok.Data;

@Data
public class SearchVO extends PageVO {
	
	private String searchType = "";
	private String keyword = "";
}
