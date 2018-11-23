package com.model2.mvc.web.product;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	public ProductController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}

	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/addProduct : POST");

		productService.addProduct(product);

		return "forward:/product/addProduct.jsp";
	}

	@RequestMapping(value="getProduct")
	public String getProduct(@RequestParam("prodNo") String prodNo, Model model) throws Exception {

		System.out.println("/getProduct : GET");

		Product product = productService.getProduct(prodNo);

		model.addAttribute("product", product);

		return "forward:/product/getProduct.jsp";
	}

	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct(@RequestParam("prodNo") String prodNo, Model model) throws Exception {

		System.out.println("/updateProduct : GET");

		Product product = productService.getProduct(prodNo);

		model.addAttribute("product", product);

		return "forward:/product/updateProduct.jsp";
	}

	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, Model model,
			@RequestParam("menu") String menu) throws Exception {

		System.out.println("/updateProduct : POST");

		productService.updateProduct(product);

		return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=" + menu;
	}

	@RequestMapping(value="listProduct")
	public String listProduct(@ModelAttribute("search") Search search, Model model)throws Exception {

		System.out.println("/listProduct.do");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		// Business logic 수행
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/product/listProduct.jsp";
	}
}
