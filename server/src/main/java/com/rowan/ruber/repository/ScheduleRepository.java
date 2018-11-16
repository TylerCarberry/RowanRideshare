package com.rowan.ruber.repository;

import org.springframework.data.repository.CrudRepository;
import com.rowan.ruber.model.Schedule;

// This will be AUTO IMPLEMENTED by Spring into a Bean called scheduleRepository in the RuberController
// CRUD refers Create, Read, Update, Delete
public interface ScheduleRepository extends CrudRepository<Schedule, Integer> {

}