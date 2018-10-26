package com.redhat.cloudnative.breakfix.dashboard.service;

import org.springframework.data.repository.CrudRepository;

import com.redhat.cloudnative.breakfix.dashboard.model.Competitor;

public interface CompetitorRepository extends CrudRepository<Competitor, String> {
}
