package com.redhat.cloudnative.breakfix.dashboard.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "COMPETITOR", uniqueConstraints = @UniqueConstraint(columnNames = "competitorId"))
public class Competitor implements Serializable {

	private static final long serialVersionUID = -8692919002070524889L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String competitorId;

	//@NotNull
	private String fullName;

	//@NotNull
	private String email;

	//@NotNull
	private String company;

	private Date startTime;

	private Date stopTime;

	private long time;

	public Competitor() {
	}

	public String getCompetitorId() {
		return competitorId;
	}

	public void setCompetitorId(String competitorId) {
		this.competitorId = competitorId;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getStopTime() {
		return stopTime;
	}

	public void setStopTime(Date stopTime) {
		this.stopTime = stopTime;
	}

	public long getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time = time;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Competitor [competitorId=");
		builder.append(competitorId);
		builder.append(", fullName=");
		builder.append(fullName);
		builder.append(", email=");
		builder.append(email);
		builder.append(", company=");
		builder.append(company);
		builder.append(", startTime=");
		builder.append(startTime);
		builder.append(", stopTime=");
		builder.append(stopTime);
		builder.append(", time=");
		builder.append(time);
		builder.append("]");
		return builder.toString();
	}

}