package com.redhat.cloudnative.catalog;

import java.util.List;
import java.util.Spliterator;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redhat.cloudnative.catalog.breakfix.service.BreakFixService;

@Controller
@RequestMapping(value = "/api/catalog")
public class CatalogController {

	@Autowired
    private ProductRepository repository;
	
	@Autowired
	private BreakFixService breakFixService;

    @ResponseBody
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Product> getAll() {
        Spliterator<Product> products = repository.findAll().spliterator();
        
        breakFixService.process();
        
        return StreamSupport.stream(products, false).collect(Collectors.toList());
    }
    
}