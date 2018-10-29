package com.redhat.cloudnative.breakfix.dashboard.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.redhat.cloudnative.breakfix.dashboard.model.Competitor;
import com.redhat.cloudnative.breakfix.dashboard.service.CompetitorRepository;

@Controller
@RequestMapping(value = "/dashboard")
public class DashboardController {

	@Autowired
    private CompetitorRepository repository;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView start(@Valid @ModelAttribute Competitor competitor, BindingResult result) {
//	    if (result.hasErrors()) {
//	       return new ModelAndView("welcome", "competitor", competitor);
//	    }
		
		// TODO Show the Services status (BreakFix)

        Iterable<Competitor> competitors = repository.findAllByOrderByTimeAsc();
		
		ModelAndView modelAndView = new ModelAndView("dashboard", "competitors", competitors);
		//modelAndView.addObject("breakFix", breakFix);
				
		return modelAndView;
	}
        
}