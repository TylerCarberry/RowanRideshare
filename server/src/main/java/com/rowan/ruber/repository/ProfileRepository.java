package com.rowan.ruber.repository;

import org.springframework.data.repository.CrudRepository;
import com.rowan.ruber.model.Profile;

public interface ProfileRepository extends CrudRepository<Profile, Integer> {

}