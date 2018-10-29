package com.redhat.cloudnative.breakfix.dashboard.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.redhat.cloudnative.breakfix.dashboard.model.BreakFix;
import com.redhat.cloudnative.breakfix.dashboard.model.Competitor;
import com.redhat.cloudnative.breakfix.dashboard.service.CompetitorRepository;

@Controller
@RequestMapping(value = "/challenge")
public class ChallengeController {

	@Autowired
	private CompetitorRepository repository;

	@Autowired
	private RestTemplate restTemplate;

	@Value("${catalog.status}")
	private String catalogStatusEndpoint;
	@Value("${catalog.break.sleep}")
	private String catalogBreakSleepEndpoint;
	@Value("${catalog.fix.sleep}")
	private String catalogFixSleepEndpoint;
	@Value("${catalog.break.exception}")
	private String catalogBreakExceptionEndpoint;
	@Value("${catalog.fix.exception}")
	private String catalogFixExceptionEndpoint;
	@Value("${catalog.break.disabled}")
	private String catalogBreakDisableEndpoint;

	@Value("${inventory.status}")
	private String inventoryStatusEndpoint;
	@Value("${inventory.break.sleep}")
	private String inventoryBreakSleepEndpoint;
	@Value("${inventory.fix.sleep}")
	private String inventoryFixSleepEndpoint;
	@Value("${inventory.break.exception}")
	private String inventoryBreakExceptionEndpoint;
	@Value("${inventory.fix.exception}")
	private String inventoryFixExceptionEndpoint;
	@Value("${inventory.break.disabled}")
	private String inventoryBreakDisabledEndpoint;

	@Value("${openshift.base_url}")
	private String openshiftBaseUrl;
	
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public ModelAndView welcome(ModelMap model) {
		return new ModelAndView("signin", "competitor", new Competitor());
	}

	@RequestMapping(value = "/start", method = RequestMethod.POST)
	public ModelAndView start(@Valid @ModelAttribute Competitor competitor, BindingResult result) {
//	    if (result.hasErrors()) {
//	       return new ModelAndView("welcome", "competitor", competitor);
//	    }
				
		String timeout = "4000";
		String exMessage = "Opppssss!!!!%20Please,%20REDEPLOY%20ME!!!";		
		String[] services = {"inventory", "catalog"};
		String[] breakTypes = {"sleep/" + timeout, "exception/" + exMessage, "disabled"};
		
		String service = services[(new Random()).nextInt(1)];
		String breakType = breakTypes[(new Random()).nextInt(2)];		
		
		String breakUrl = "http://" + service + "-coolstore." + openshiftBaseUrl + "/api/break/" + breakType;

		// TODO Manage exceptions
		BreakFix breakFix = restTemplate.getForObject(breakUrl, BreakFix.class);

		// Save and register the new competitor
		competitor.setStartTime(new Date());
		repository.save(competitor);
		
		ModelAndView modelAndView = new ModelAndView("working", "competitor", competitor);
		modelAndView.addObject("status", "Your MSA architecture is broke. Please fix it!");
		modelAndView.addObject("time", "00:00");
		modelAndView.addObject("breakFix", breakFix);
				
		return modelAndView;
	}

	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public ModelAndView check(@Valid @ModelAttribute Competitor competitor) {
		// Finding Competitor
		competitor = repository.findOne(competitor.getCompetitorId());

		// Check that everything is running
		String catalogStatus = restTemplate.getForObject(catalogStatusEndpoint, String.class);
		String inventoryStatus = restTemplate.getForObject(inventoryStatusEndpoint, String.class);

		if ("\"OK\"".equals(catalogStatus) && "\"OK\"".equals(inventoryStatus)) {
			// TODO Save and register the new competitor if everything is right
			competitor.setStopTime(new Date());
			competitor.setTime(competitor.getStopTime().getTime() - competitor.getStartTime().getTime());

			repository.save(competitor);

			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("mm:ss");

			ModelAndView modelAndView = new ModelAndView("success", "competitor", competitor);
			modelAndView.addObject("status", "Your MSA architecture is Fine.!");
			modelAndView.addObject("time", simpleDateFormat.format(competitor.getTime()));

			return modelAndView;
		}

		long time = System.currentTimeMillis() - competitor.getStartTime().getTime();

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("mm:ss");
		// simpleDateFormat.format(now, stringBuffer, new FieldPosition(0));
		simpleDateFormat.format(time);

		ModelAndView modelAndView = new ModelAndView("working", "competitor", competitor);
		modelAndView.addObject("status", "Your MSA architecture is broke. Please fix it!");
		modelAndView.addObject("time", simpleDateFormat.format(time));

		return modelAndView;
	}

}