package com.olas.filmsinfoservice.annotation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.olas.filmsinfoservice.user.UserModel;

public class UserPasswordValid implements ConstraintValidator<PasswordMatches, Object>
{
	@Override
	public void initialize(PasswordMatches constraintAnnotation) 
	{}

	@Override
	public boolean isValid(Object object, ConstraintValidatorContext context) 
	{
		UserModel user = (UserModel) object;
		return user.getPassword().equals(user.getMatchingPassword());
	}
}
