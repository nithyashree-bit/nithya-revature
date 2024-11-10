//package com.rev.controller;
//
//import java.util.List;
//import java.util.Optional;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.SessionAttribute;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.rev.entity.Product;
//import com.rev.entity.Seller;
//import com.rev.service.ProductService;
//import com.rev.service.SellerService;
//
//@Controller
//@RequestMapping("/seller")
//public class SellerProductController {
//
//    @Autowired
//    private ProductService productService;
//
//    @Autowired
//    private SellerService sellerService;
//    
//    @GetMapping("/add-product")
//    public String showAddProductForm(Model model) {
//        model.addAttribute("product", new Product()); // Create a new Product object
//        return "seller_add_product"; // Name of the JSP file to render
//    }
//    @GetMapping("/my-products")
//    public String showMyProducts(Model model, @SessionAttribute String sellerName) {
//        Optional<Seller> seller = Optional.ofNullable(sellerService.findByUsername(sellerName));
//        if (seller.isPresent()) {
//            List<Product> products = productService.getProductsBySellerId(seller.get().getId());
//            model.addAttribute("products", products);
//            return "seller_my_product"; // Ensure this view exists
//        } else {
//            return "redirect:/seller/login"; // Redirect to login if seller not found
//        }
//    }
//
//    @PostMapping("/add-product")
//    public String addProduct(@ModelAttribute Product product, 
//                             @SessionAttribute String sellerName, 
//                             RedirectAttributes redirectAttributes) {
//        Optional<Seller> seller = Optional.ofNullable(sellerService.findByUsername(sellerName));
//        if (seller.isPresent()) {
//            product.setSellerId(seller.get().getId()); // Set the seller ID to the product
//            productService.addProduct(product); // Call your service to save the product
//
//            // Add a success message
//            redirectAttributes.addFlashAttribute("message", "Product added successfully!");
//
//            return "redirect:/sellers/seller_my_product"; // Redirect to the seller's products page
//        } else {
//            return "redirect:/sellers/login"; // Redirect to login if the seller is not found
//        }
//        
//    }
//    
//    @GetMapping("/delete-product/{productId}")
//    public String deleteProduct(@PathVariable Long productId, RedirectAttributes redirectAttributes) {
//        try {
//            productService.deleteProduct(productId); // Call service to delete the product
//            redirectAttributes.addFlashAttribute("message", "Product deleted successfully!");
//        } catch (Exception e) {
//            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting product: " + e.getMessage());
//            e.printStackTrace(); // Print stack trace to console for debugging
//        }
//        return "redirect:/seller/dashboard"; // Redirect to the seller's products page
//    }
//
//    // Endpoint to show seller's products
//
//    @GetMapping("/edit-product/{productId}")
//    public String showUpdateProductForm(@PathVariable Long productId, Model model) {
//        Product product = productService.getProductById(productId);
//        model.addAttribute("product", product); // Add product to the model
//        return "edit-product"; // Name of the JSP file to render the edit form
//    }
//    
//    @PostMapping("/edit-product/{productId}")
//    public String updateProduct(
//        @PathVariable Long productId,
//        @ModelAttribute("product") Product updatedProduct,
//        RedirectAttributes redirectAttributes) {
//        
//    	
//        try {
//            productService.updateProduct(productId, updatedProduct); // Call service to update the product
//            redirectAttributes.addFlashAttribute("message", "Product updated successfully!");
//        } catch (Exception e) {
//            redirectAttributes.addFlashAttribute("errorMessage", "Error updating product: " + e.getMessage());
//            e.printStackTrace(); // Print stack trace for debugging
//        }
//        return "redirect:/sellers/dashboard"; // Redirect back to the products list
//    }
//
//    
//    
//
//    
//
//    
//}
