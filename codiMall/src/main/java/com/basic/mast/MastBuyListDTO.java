package com.basic.mast;

import com.basic.buy.BuyDTO;
import com.basic.buy.BuyStateDTO;
import com.basic.product.ProductDTO;

public class MastBuyListDTO {
	
	private BuyDTO buyDTO;
	private ProductDTO productDTO;
	private BuyStateDTO buyStateDTO;
	
	
	public ProductDTO getProductDTO() {
		return productDTO;
	}
	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}
	public BuyDTO getBuyDTO() {
		return buyDTO;
	}
	public void setBuyDTO(BuyDTO buyDTO) {
		this.buyDTO = buyDTO;
	}
	public BuyStateDTO getBuyStateDTO() {
		return buyStateDTO;
	}
	public void setBuyStateDTO(BuyStateDTO buyStateDTO) {
		this.buyStateDTO = buyStateDTO;
	}
	
	

}
