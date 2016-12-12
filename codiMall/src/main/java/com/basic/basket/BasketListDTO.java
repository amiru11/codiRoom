package com.basic.basket;

import java.util.List;

import com.basic.product.ProductEachDTO;

public class BasketListDTO {
	
	private int basket_num;
	private int product_num;
	private String product_name;
	private int productInfo_price;
	private double productInfo_saleRate;
	private String basketInfo_size;
	private String basketInfo_color;
	private int  basketInfo_each;
	private List<ProductEachDTO> productEachDTO;
	
	
	
	public List<ProductEachDTO> getProductEachDTO() {
		return productEachDTO;
	}

	public void setProductEachDTO(List<ProductEachDTO> productEachDTO) {
		this.productEachDTO = productEachDTO;
	}


	public int getBasket_num() {
		return basket_num;
	}

	public void setBasket_num(int basket_num) {
		this.basket_num = basket_num;
	}

	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProductInfo_price() {
		return productInfo_price;
	}

	public void setProductInfo_price(int productInfo_price) {
		this.productInfo_price = productInfo_price;
	}

	public double getProductInfo_saleRate() {
		return productInfo_saleRate;
	}

	public void setProductInfo_saleRate(double productInfo_saleRate) {
		this.productInfo_saleRate = productInfo_saleRate;
	}

	public String getBasketInfo_size() {
		return basketInfo_size;
	}

	public void setBasketInfo_size(String basketInfo_size) {
		this.basketInfo_size = basketInfo_size;
	}

	public String getBasketInfo_color() {
		return basketInfo_color;
	}

	public void setBasketInfo_color(String basketInfo_color) {
		this.basketInfo_color = basketInfo_color;
	}

	public int getBasketInfo_each() {
		return basketInfo_each;
	}

	public void setBasketInfo_each(int basketInfo_each) {
		this.basketInfo_each = basketInfo_each;
	}
}
