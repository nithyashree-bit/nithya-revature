package com.rev.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.rev.entity.Product;
import com.rev.entity.Seller; // Import your Seller entity
import com.rev.service.BuyerService;
import com.rev.service.ProductService;
import com.rev.service.SellerService; // Import your SellerService

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {


    @Autowired
    private BuyerService buyerService; // Buyer service for managing buyers
    
    @Autowired
    private SellerService sellerService; // Seller service for managing sellers
    

    @GetMapping("/admin")
    public String showAdminLoginForm(Model model) {
        return "admin-login"; // Return the admin login page view
    }

    @PostMapping("/admin/login")
    public String login(Model model, HttpSession session,@RequestParam String username,@RequestParam String password ) {
        if(username.equals("admin123@revshop.com") && password.equals("11")) {
            session.setAttribute("adminName", "admin"); // Store admin info in session
            return "redirect:/admin/dashboard"; // Redirect to admin dashboard
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "admin-login"; // Return to login page with error message
        }
    }
    
    @GetMapping("/admin/dashboard")
    public String showAdminDashboard(Model model) {
        // Add any necessary attributes to the model
        return "admin_dashboard"; // This should correspond to your JSP file
    }

    
   

    @GetMapping("/admin/buyers")
    public String viewBuyers(Model model) {
        model.addAttribute("buyers", buyerService.getAllBuyers());
        return "view_buyers"; // Create a JSP file to display buyers
    }

    @GetMapping("/admin/sellers")
    public String viewSellers(Model model) {
        model.addAttribute("sellers", sellerService.getAllSellers());
        return "view_sellers"; // Create a JSP file to display sellers
    }

    @PostMapping("/buyer/delete")
    public String deleteBuyer(@RequestParam("buyerId") Long buyerId) {
        buyerService.deleteBuyerById(buyerId);
        return "redirect:/admin/buyers";
    }

    @PostMapping("/seller/delete")
    public String deleteSeller(@RequestParam("sellerId") Long sellerId) {
        sellerService.deleteSellerById(sellerId);
        return "redirect:/admin/sellers";
    }

    @Autowired
    private ProductService productService; // Assuming you have a ProductService

//    @GetMapping("/products")
//    public String viewProducts(Model model) {
//        model.addAttribute("products", productService.getAllProducts());
//        return "view_products"; // Ensure you have this JSP file created
//    }
//
//    @PostMapping("/product/delete")
//    public String deleteProduct(@RequestParam("productId") Long productId) {
//        productService.deleteProductById(productId);
//        return "redirect:/admin/products"; // Redirect back to the products list
//    }
    
    
   

//    @GetMapping("/admin/seller/products")
//    public String viewSellerProducts(@RequestParam("sellerId") Long sellerId, Model model) {
//        Seller seller = sellerService.getSellerById(sellerId);
//        List<Product> products = productService.getProductsBySellerId(sellerId);
//        
//        model.addAttribute("seller", seller);
//        model.addAttribute("products", products);
//        return "view_seller_products"; // Ensure to create this JSP page
//    }
    @GetMapping("admin/seller/products")
    public String viewSellerProducts(@RequestParam Long sellerId, Model model) {
        // Fetch the seller by ID
        Seller seller = sellerService.getSellerById(sellerId);
        
        // Fetch products associated with the seller
        List<Product> products = productService.getProductsBySellerId(sellerId);
        
        // Add attributes to the model for use in the JSP
        model.addAttribute("seller", seller);
        model.addAttribute("products", products);
        
        return "view_seller_products"; // Ensure this JSP page exists in your views
    }
    @GetMapping("/seller/products")
    public String viewProducts(@RequestParam Long sellerId, Model model) {
        List<Product> products = productService.getProductsBySellerId(sellerId);
        Seller seller = sellerService.getSellerById(sellerId); // Fetch the seller information if needed
        model.addAttribute("products", products);
        model.addAttribute("seller", seller);
        return "view_seller_products"; // This should match the JSP file name under views
    }
    
    @GetMapping("/admin/user-counts")
    public ResponseEntity<Map<String, Integer>> getUserCounts() {
        int sellerCount = sellerService.getCount(); // Implemented correctly
        int buyerCount = buyerService.getCount(); // Implemented correctly

        Map<String, Integer> counts = new HashMap<>();
        counts.put("sellers", sellerCount);
        counts.put("buyers", buyerCount);
        return ResponseEntity.ok(counts); // Return the counts as a JSON response
    }
    
    
    @GetMapping("/admin/logout")
    public String logout() {
        // Logic for logout if needed
        return "redirect:/admin/login"; // Adjust as necessary
    }
    
    @PostMapping("/product/delete")
    public String deleteProduct(@RequestParam("productId") Long productId, 
                                @RequestParam("sellerId") Long sellerId, 
                                RedirectAttributes redirectAttributes) {
        try {
            productService.deleteProduct(productId);
            redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/seller/products?sellerId=" + sellerId; // Include sellerId in the redirect
    }
    
}