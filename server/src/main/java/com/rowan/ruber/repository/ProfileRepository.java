package com.rowan.ruber.repository;

import org.springframework.data.repository.CrudRepository;
import com.rowan.ruber.model.Profile;

// This will be AUTO IMPLEMENTED by Spring into a Bean called profileRepository in the RuberController
// CRUD refers Create, Read, Update, Delete
public interface ProfileRepository extends CrudRepository<Profile, Integer> {

}