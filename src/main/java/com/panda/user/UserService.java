package com.panda.user;


public interface UserService {

	public UserDTO Login(UserDTO user) throws Exception;
	
	public void Register(UserDTO user) throws Exception;
}
