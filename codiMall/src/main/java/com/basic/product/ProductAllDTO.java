package com.basic.product;

import java.util.List;

public class ProductAllDTO {
	private int r;
	private int selCount;
	private ProductSelectDTO productSelectDTO;
	private KindDTO kindDTO;
	private ProductDTO productDTO;
	private ProductInfoDTO productInfoDTO;
	private ProductPicDTO productPicDTO;
	private List<ProductEachDTO> productEachDTOs;
	
	public List<ProductEachDTO> getProductEachDTOs() {
		return productEachDTOs;
	}
	public void setProductEachDTOs(List<ProductEachDTO> productEachDTOs) {
		this.productEachDTOs = productEachDTOs;
	}
	public int getR() {
		return r;
	}
	public void setR(int r) {
		this.r = r;
	}
	public ProductSelectDTO getProductSelectDTO() {
		return productSelectDTO;
	}
	public void setProductSelectDTO(ProductSelectDTO productSelectDTO) {
		this.productSelectDTO = productSelectDTO;
	}
	public int getSelCount() {
		return selCount;
	}
	public void setSelCount(int selCount) {
		this.selCount = selCount;
	}
	public KindDTO getKindDTO() {
		return kindDTO;
	}
	public void setKindDTO(KindDTO kindDTO) {
		this.kindDTO = kindDTO;
	}
	public ProductDTO getProductDTO() {
		return productDTO;
	}
	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}
	public ProductInfoDTO getProductInfoDTO() {
		return productInfoDTO;
	}
	public void setProductInfoDTO(ProductInfoDTO productInfoDTO) {
		this.productInfoDTO = productInfoDTO;
	}
	public ProductPicDTO getProductPicDTO() {
		return productPicDTO;
	}
	public void setProductPicDTO(ProductPicDTO productPicDTO) {
		this.productPicDTO = productPicDTO;
	}

	
	

}
